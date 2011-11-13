//
//  RSSFeed.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#import "RSSFeed.h"

@implementation RSSFeed

@synthesize items;
@synthesize title;
@synthesize link;
@synthesize feedDescription;

- (id)initWithRootNode:(ANHTMLElement *)element {
	if ((self = [super init])) {
	}
	return self;
}

- (id)description {
	NSMutableString * descString = [NSMutableString string];
	
	[descString appendFormat:@"{\n"];
	[descString appendFormat:@" Feed Title: %@\n Feed URL: %@\n Feed Description: %@\n Items: ", title, link, feedDescription];
	for (NSUInteger i = 0; i < [items count]; i++) {
		[descString appendFormat:@"%@", [items objectAtIndex:i]];
		if (i + 1 < [items count]) {
			[descString appendFormat:@","];
		}
		[descString appendFormat:@"\n"];
	}
	[descString appendFormat:@"}"];
	
	return descString;
}

@end
