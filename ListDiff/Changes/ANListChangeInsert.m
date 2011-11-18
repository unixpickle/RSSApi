//
//  RSSFeedChangeInsert.m
//  RSSApi
//
//  Created by Alex Nichol on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANListChangeInsert.h"

@implementation ANListChangeInsert

@synthesize insertItem;

- (id)initWithOriginalIndex:(NSUInteger)anIndex item:(id)anItem {
	if ((self = [super initWithOriginalIndex:anIndex])) {
		insertItem = anItem;
	}
	return self;
}

- (void)applyIndexTransformToChildren {
	ANListChange * change = self.nextChange;
	while (change != nil) {
		if (change.affectedIndex >= self.affectedIndex) {
			change.affectedIndex += 1;
		}
		change = change.nextChange;
	}
}

- (id)description {
	return [NSString stringWithFormat:@"Insert %@ at index %ld", insertItem, affectedIndex];
}

@end
