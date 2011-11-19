//
//  FeedStreamTest.h
//  RSSApi
//
//  Created by Alex Nichol on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSFeedStream.h"

@interface FeedStreamTest : NSObject <RSSFeedStreamDelegate> {
	RSSFeedStream * stream;
}

- (id)initWithStream:(RSSFeedStream *)aStream;
- (void)timerRefresh;

@end
