//
//  FeedStreamTest.m
//  RSSApi
//
//  Created by Alex Nichol on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FeedStreamTest.h"

@implementation FeedStreamTest

- (id)initWithStream:(RSSFeedStream *)aStream {
	if ((self = [super init])) {
		stream = aStream;
		[stream setDelegate:self];
		[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerRefresh) userInfo:nil repeats:YES];
	}
	return self;
}

- (void)timerRefresh {
	if (![stream isRefreshing]) {
		[stream refreshInBackground];
	}
}

#pragma mark Feed

- (void)feedStreamRefreshDone:(RSSFeedStream *)stream {
	// NSLog(@"Refresh done.");
}

- (void)feedStreamRefreshFailed:(RSSFeedStream *)stream {
	NSLog(@"Refresh failed.");
}

- (void)feedStream:(RSSFeedStream *)stream foundNewArticle:(RSSItem *)anItem {
	NSLog(@"New article: %@", [anItem title]);
}

@end
