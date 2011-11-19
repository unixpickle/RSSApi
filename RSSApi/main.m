//
//  main.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedStreamTest.h"

int main (int argc, const char * argv[]) {
	@autoreleasepool {
		NSURL * theURL = [NSURL fileURLWithPath:@"/Users/alex/Desktop/change.rss"];
	    RSSFeedStream * stream = [[RSSFeedStream alloc] initWithFeedURL:theURL];
		FeedStreamTest * test = [[FeedStreamTest alloc] initWithStream:stream];
		[test timerRefresh];
		[[NSRunLoop currentRunLoop] run];
	}
    return 0;
}

