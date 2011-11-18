//
//  RSSAtomFeed.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSAtomFeed.h"

@implementation RSSAtomFeed

- (id)initWithRootNode:(ANHTMLElement *)element {
	if ((self = [super init])) {
		NSCharacterSet * whitespace = [NSCharacterSet whitespaceCharacterSet];
		NSMutableArray * itemList = [NSMutableArray array];
		ANHTMLElement * elTitle = [[element childElementsWithName:@"title"] lastObject];
		ANHTMLElement * elLink = [[element childElementsWithName:@"link"] lastObject];
		ANHTMLElement * elSubtitle = [[element childElementsWithName:@"subtitle"] lastObject];
		NSArray * entryElements = [element childElementsWithName:@"entry"];
		
		title = [[elTitle stringValue] stringByTrimmingCharactersInSet:whitespace];
		feedDescription = [[elSubtitle stringValue] stringByTrimmingCharactersInSet:whitespace];
		if (elLink) {
			NSString * linkString = [elLink.attributes attributeForName:@"href"].attributeValue;
			link = [[NSURL alloc] initWithString:linkString];
		}
		
		for (ANHTMLElement * entryElement in entryElements) {
			RSSAtomItem * item = [[RSSAtomItem alloc] initWithEntryNode:entryElement];
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
