//
//  RSS2Item.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSS2Item.h"

@interface RSS2Item (Initialization)

- (NSDate *)dateFromDateString:(NSString *)dateString;

@end

@implementation RSS2Item

- (id)initWithItemNode:(ANHTMLElement *)item {
	if ((self = [super init])) {
		NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
		ANHTMLElement * elTitle = [item elementWithName:@"title"];
		ANHTMLElement * elLink = [item elementWithName:@"link"];
		ANHTMLElement * elDescription = [item elementWithName:@"description"];
		ANHTMLElement * elGuid = [item elementWithName:@"guid"];
		ANHTMLElement * elPubDate = [item elementWithName:@"pubDate"];
		
		// Process unique information
		if (elLink) {
			NSString * urlString = [[elLink toPlainText] stringByTrimmingCharactersInSet:whitespace];
			articleURL = [[NSURL alloc] initWithString:urlString];
		}
		if (elGuid) {
			NSString * guid = [[elGuid toPlainText] stringByTrimmingCharactersInSet:whitespace];
			identifier = [[RSSItemGUIDIdentifier alloc] initWithGUID:guid];
		} else if (articleURL) {
			identifier = [[RSSItemURLIdentifier alloc] initWithURL:articleURL];
		}
		
		if (!identifier) return nil;
		
		summary = [[elDescription toPlainText] stringByTrimmingCharactersInSet:whitespace];
		title = [[elTitle toPlainText] stringByTrimmingCharactersInSet:whitespace];
		
		if (elPubDate) {
			NSString * dateString = [[elPubDate toPlainText] stringByTrimmingCharactersInSet:whitespace];
			creationDate = [self dateFromDateString:dateString];
		}
	}
	return self;
}

- (NSDate *)dateFromDateString:(NSString *)dateString {
	NSDate * theDate = nil;
	
	NSDateFormatter * rssFormatter = [[NSDateFormatter alloc] init];
	[rssFormatter setDateFormat:@"E, dd LLL yyyy HH:mm:ss Z"];
	theDate = [rssFormatter dateFromString:dateString];
	if (!theDate) {
		[rssFormatter setDateFormat:@"E, dd LLL yyyy HH:mm:ss zzzz"];
		theDate = [rssFormatter dateFromString:dateString];
	}
	
	return theDate;
}

@end
