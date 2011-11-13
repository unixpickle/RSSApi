//
//  main.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSParser.h"
#import "ANListMutations.h"

int main (int argc, const char * argv[]) {
	@autoreleasepool {
	    NSData * diff1 = [NSData dataWithContentsOfFile:@"/Users/alex/Desktop/diff1.rss"];
		NSData * diff2 = [NSData dataWithContentsOfFile:@"/Users/alex/Desktop/diff2.rss"];
		RSSFeed * feed1 = [RSSParser feedFromRSSDocument:diff1];
		RSSFeed * feed2 = [RSSParser feedFromRSSDocument:diff2];
		
		ANListMutations * mutations = [[ANListMutations alloc] initWithOld:[feed1 items] new:[feed2 items]];
		[mutations setCompareSelector:@selector(isEqualToItem:)];
		ANListChange * change = [mutations rootChangeFromOldToNew];
		[change applyTransformRecursively];
		
		NSLog(@"Changes from old to new:");
		while (change != nil) {
			NSLog(@"%@", change);
			change = change.nextChange;
		}
	}
    return 0;
}

