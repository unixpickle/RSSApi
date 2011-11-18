//
//  RSS2Feed.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSS2Feed.h"

@implementation RSS2Feed

- (id)initWithRootNode:(ANHTMLElement *)_element {
	if ((self = [super init])) {
		ANHTMLElement * element = [[_element childElementsWithName:@"channel"] lastObject];
		if (!element) return nil;
		NSCharacterSet * whitespace = [NSCharacterSet whitespaceCharacterSet];
		NSMutableArray * itemList = [NSMutableArray array];
		ANHTMLElement * elTitle = [[element childElementsWithName:@"title"] lastObject];
		ANHTMLElement * elLink = [[element childElementsWithName:@"link"] lastObject];
		ANHTMLElement * elDescription = [[element childElementsWithName:@"description"] lastObject];
		NSArray * itemElements = [element childElementsWithName:@"item"];
		
		title = [[elTitle stringValue] stringByTrimmingCharactersInSet:whitespace];
		feedDescription = [[elDescription stringValue] stringByTrimmingCharactersInSet:whitespace];
		if (elLink) {
			NSString * linkString = [[elLink stringValue] stringByTrimmingCharactersInSet:whitespace];
			link = [[NSURL alloc] initWithString:linkString];
		}
		
		for (ANHTMLElement * itemElement in itemElements) {
			RSS2Item * item = [[RSS2Item alloc] initWithItemNode:itemElement];
			if (!item) {
				return nil;
			}
			[itemList addObject:item];
		}
		items = [[NSArray alloc] initWithArray:itemList];
	}
	return self;
}

@end
