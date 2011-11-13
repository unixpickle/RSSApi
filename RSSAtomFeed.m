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
		ANHTMLElement * elTitle = [element elementWithName:@"title"];
		ANHTMLElement * elLink = [element elementWithName:@"link"];
		ANHTMLElement * elSubtitle = [element elementWithName:@"subtitle"];
		NSArray * entryElements = [element elementsWithName:@"entry"];
		
		title = [[elTitle toPlainText] stringByTrimmingCharactersInSet:whitespace];
		feedDescription = [[elSubtitle toPlainText] stringByTrimmingCharactersInSet:whitespace];
		if (elLink) {
			NSString * linkString = [elLink valueForAttribute:@"href"];
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
