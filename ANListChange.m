//
//  RSSFeedChange.m
//  RSSApi
//
//  Created by Alex Nichol on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANListChange.h"

@implementation ANListChange

@synthesize affectedIndex;
@synthesize originalIndex;
@synthesize nextChange;

- (id)initWithOriginalIndex:(NSUInteger)anIndex {
	if ((self = [super init])) {
		originalIndex = anIndex;
		affectedIndex = anIndex;
	}
	return self;
}

- (void)applyIndexTransformToChildren {
	[self doesNotRecognizeSelector:@selector(applyIndexTransformToChildren)];
}

- (void)applyTransformRecursively {
	[self applyIndexTransformToChildren];
	[self.nextChange applyTransformRecursively];
}

- (void)resetRecursively {
	ANListChange * change = self;
	while (change != nil) {
		change.affectedIndex = change.originalIndex;
		change = change.nextChange;
	}
}

@end
