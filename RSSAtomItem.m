//
//  RSSAtomItem.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSAtomItem.h"

@interface RSSAtomItem (Initialization)

- (void)handleLinkElement:(ANHTMLElement *)aLink;
- (void)handleIDElement:(ANHTMLElement *)elId;
- (NSDate *)dateFromDateElement:(ANHTMLElement *)elDate;

@end

@implementation RSSAtomItem

- (id)initWithEntryNode:(ANHTMLElement *)entry {
	if ((self = [super init])) {
		NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];

		ANHTMLElement * elTitle = [entry elementWithName:@"title"];
		ANHTMLElement * elLink = [entry elementWithName:@"link"];
		ANHTMLElement * elId = [entry elementWithName:@"id"];
		ANHTMLElement * elUpdated = [entry elementWithName:@"updated"];
		ANHTMLElement * elPublished = [entry elementWithName:@"published"];
		ANHTMLElement * elContent = [entry elementWithName:@"content"];
		
		if (elLink) {
			[self handleLinkElement:elLink];
		}
		[self handleIDElement:elId];
		if (!identifier) return nil;
		
		title = [[elTitle toPlainText] stringByTrimmingCharactersInSet:whitespace];
		
		if (elUpdated) {
			updateDate = [self dateFromDateElement:elUpdated];
		}
		if (elPublished) {
			creationDate = [self dateFromDateElement:elPublished];
		}
		
		if (elContent) {
			summary = [[elContent toPlainText] stringByTrimmingCharactersInSet:whitespace];
		}
	}
	return self;
}

- (void)handleLinkElement:(ANHTMLElement *)aLink {
	NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	NSString * urlString = [[aLink valueForAttribute:@"href"] stringByTrimmingCharactersInSet:whitespace];
	NSString * rel = [aLink valueForAttribute:@"rel"];
	if (rel) {
		if ([rel isEqualToString:@"alternate"]) {
			alternateURL = [[NSURL alloc] initWithString:urlString];
		}
	} else {
		articleURL = [[NSURL alloc] initWithString:urlString];
	}
}

- (void)handleIDElement:(ANHTMLElement *)elId {
	NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	if (elId) {
		NSString * idString = [[elId toPlainText] stringByTrimmingCharactersInSet:whitespace];
		identifier = [[RSSItemAtomIdentifier alloc] initWithIDString:idString];
	} else if (articleURL) {
		identifier = [[RSSItemURLIdentifier alloc] initWithURL:articleURL];
	} else if (alternateURL) {
		identifier = [[RSSItemURLIdentifier alloc] initWithURL:alternateURL];
	}
}

- (NSDate *)dateFromDateElement:(ANHTMLElement *)elDate {
	NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	NSDate * theDate = nil;
	NSString * dateString = [[elDate toPlainText] stringByTrimmingCharactersInSet:whitespace];
	
	NSDateFormatter * xmlFormatter = [[NSDateFormatter alloc] init];
	[xmlFormatter setDateFormat:@"yyy-MM-dd'T'HH:mm:ss'Z'"];
	theDate = [xmlFormatter dateFromString:dateString];
	
	if (!theDate) {
		[xmlFormatter setDateFormat:@"yyy-MM-dd'T'HH:mm:ss+HH:mm"];
		theDate = [xmlFormatter dateFromString:dateString];
	}
	
	if (!theDate) {
		[xmlFormatter setDateFormat:@"yyy-MM-dd'T'HH:mm:ss-HH:mm"];
		theDate = [xmlFormatter dateFromString:dateString];
	}
	
	return theDate;
}

@end
