//
//  RSSItem.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSItem.h"

@implementation RSSItem

@synthesize identifier;
@synthesize title;
@synthesize summary;
@synthesize articleURL, alternateURL;
@synthesize creationDate, updateDate;

- (id)description {
	return [NSString stringWithFormat:@" {\n  Title: %@\n  URL: %@\n  Created: %@\n  Updated: %@\n  Summary: %@\n }",
			 title, articleURL, creationDate, updateDate, summary];
}

- (BOOL)isEqualToItem:(RSSItem *)anotherItem {
	return [[self identifier] isEqualToIdentifier:[anotherItem identifier]];
}

@end
