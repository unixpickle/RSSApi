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

		ANHTMLElement * elTitle = [[entry childElementsWithName:@"title"] lastObject];
		ANHTMLElement * elLink = [[entry childElementsWithName:@"link"] lastObject];
		ANHTMLElement * elId = [[entry childElementsWithName:@"id"] lastObject];
		ANHTMLElement * elUpdated = [[entry childElementsWithName:@"updated"] lastObject];
		ANHTMLElement * elPublished = [[entry childElementsWithName:@"published"] lastObject];
		ANHTMLElement * elContent = [[entry childElementsWithName:@"content"] lastObject];
		
		if (elLink) {
			[self handleLinkElement:elLink];
		}
		[self handleIDElement:elId];
		if (!identifier) return nil;
		
		title = [[elTitle stringValue] stringByTrimmingCharactersInSet:whitespace];
		
		if (elUpdated) {
			updateDate = [self dateFromDateElement:elUpdated];
		}
		if (elPublished) {
			creationDate = [self dateFromDateElement:elPublished];
		}
		
		if (elContent) {
			summary = [[elContent stringValue] stringByTrimmingCharactersInSet:whitespace];
		}
	}
	return self;
}

- (void)handleLinkElement:(ANHTMLElement *)aLink {
	NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	NSString * urlString = [[aLink.attributes attributeForName:@"href"].attributeValue stringByTrimmingCharactersInSet:whitespace];
	NSString * rel = [[aLink.attributes attributeForName:@"href"].attributeValue stringByTrimmingCharactersInSet:whitespace];
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
		NSString * idString = [[elId stringValue] stringByTrimmingCharactersInSet:whitespace];
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
	NSString * dateString = [[elDate stringValue] stringByTrimmingCharactersInSet:whitespace];
	
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
