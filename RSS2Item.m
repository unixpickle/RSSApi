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
		ANHTMLElement * elTitle = [[item childElementsWithName:@"title"] lastObject];
		ANHTMLElement * elLink = [[item childElementsWithName:@"link"] lastObject];
		ANHTMLElement * elDescription = [[item childElementsWithName:@"description"] lastObject];
		ANHTMLElement * elGuid = [[item childElementsWithName:@"guid"] lastObject];
		ANHTMLElement * elPubDate = [[item childElementsWithName:@"pubDate"] lastObject];
		
		// Process unique information
		if (elLink) {
			NSString * urlString = [[elLink stringValue] stringByTrimmingCharactersInSet:whitespace];
			articleURL = [[NSURL alloc] initWithString:urlString];
		}
		if (elGuid) {
			NSString * guid = [[elGuid stringValue] stringByTrimmingCharactersInSet:whitespace];
			identifier = [[RSSItemGUIDIdentifier alloc] initWithGUID:guid];
		} else if (articleURL) {
			identifier = [[RSSItemURLIdentifier alloc] initWithURL:articleURL];
		}
		
		if (!identifier) return nil;
		
		summary = [[elDescription stringValue] stringByTrimmingCharactersInSet:whitespace];
		title = [[elTitle stringValue] stringByTrimmingCharactersInSet:whitespace];
		
		if (elPubDate) {
			NSString * dateString = [[elPubDate stringValue] stringByTrimmingCharactersInSet:whitespace];
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
