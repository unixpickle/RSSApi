//
//  RSSFeedChangeRemove.m
//  RSSApi
//
//  Created by Alex Nichol on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANListChangeRemove.h"

@implementation ANListChangeRemove

- (void)applyIndexTransformToChildren {
	ANListChange * change = self.nextChange;
	while (change != nil) {
		if (change.affectedIndex >= self.affectedIndex) {
			change.affectedIndex -= 1;
		}
		change = change.nextChange;
	}
}

- (id)description {
	return [NSString stringWithFormat:@"Remove item at index %ld", affectedIndex];
}

@end
