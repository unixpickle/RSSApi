//
//  RSSFeedStream.h
//  RSSApi
//
//  Created by Alex Nichol on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSItem.h"
#import "RSSParser.h"
#import "ANListMutations.h"

@class RSSFeedStream;

@protocol RSSFeedStreamDelegate <NSObject>

@optional

- (void)feedStreamRefreshDone:(RSSFeedStream *)stream;
- (void)feedStreamRefreshFailed:(RSSFeedStream *)stream;
- (void)feedStream:(RSSFeedStream *)stream foundNewArticle:(RSSItem *)anItem;

@end

@interface RSSFeedStream : NSObject {
	NSURL * feedURL;
	
	NSThread * refreshThread;
	NSLock * refreshThreadLock;
	
	RSSFeed * currentFeed;
	NSLock * currentFeedLock;
	
	__weak id<RSSFeedStreamDelegate> delegate;
}

@property (readonly) NSURL * feedURL;
@property (readonly) RSSFeed * currentFeed;
@property (weak) id<RSSFeedStreamDelegate> delegate;

- (id)initWithFeedURL:(NSURL *)aURL;

- (void)refreshInBackground;
- (BOOL)isRefreshing;
- (void)cancelRefresh;

@end
