//
//  RSSFeedStream.m
//  RSSApi
//
//  Created by Alex Nichol on 11/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSFeedStream.h"

@interface RSSFeedStream (Private)

- (NSThread *)refreshThread;
- (void)setRefreshThread:(NSThread *)aThread;
- (void)setCurrentFeed:(RSSFeed *)aFeed;

- (void)backgroundReload:(NSThread *)mainThread;
- (void)handleUpdatedFeed:(RSSFeed *)newFeed mainThread:(NSThread *)mainThread;

- (void)delegateInformNew:(RSSItem *)anItem;
- (void)delegateInformDone;
- (void)delegateInformFailed;

@end

@implementation RSSFeedStream

@synthesize feedURL;
@synthesize delegate;

- (id)initWithFeedURL:(NSURL *)aURL {
	if ((self = [super init])) {
		feedURL = aURL;
	}
	return self;
}

- (void)refreshInBackground {
	if ([self isRefreshing]) {
		[self cancelRefresh];
	}
	self.refreshThread = [[NSThread alloc] initWithTarget:self
												 selector:@selector(backgroundReload:)
												   object:[NSThread currentThread]];
	[self.refreshThread start];
}

- (BOOL)isRefreshing {
	if (self.refreshThread) {
		return YES;
	}
	return NO;
}

- (void)cancelRefresh {
	if (self.refreshThread) {
		[self.refreshThread cancel];
		self.refreshThread = nil;
	}
}

- (RSSFeed *)currentFeed {
	RSSFeed * feed = nil;
	[currentFeedLock lock];
	feed = currentFeed;
	[currentFeedLock unlock];
	return feed;
}

#pragma mark - Private -

#pragma mark Properties

- (NSThread *)refreshThread {
	id obj;
	[refreshThreadLock lock];
	obj = refreshThread;
	[refreshThreadLock unlock];
	return obj;
}

- (void)setRefreshThread:(NSThread *)aThread {
	[refreshThreadLock lock];
	refreshThread = aThread;
	[refreshThreadLock unlock];
}

- (void)setCurrentFeed:(RSSFeed *)aFeed {
	[currentFeedLock lock];
	currentFeed = aFeed;
	[currentFeedLock unlock];
}

#pragma mark Background Thread

- (void)backgroundReload:(NSThread *)mainThread {
	@autoreleasepool {
		// download the file, parse it, report differences.
		
		NSURLRequest * request = [[NSURLRequest alloc] initWithURL:self.feedURL
													   cachePolicy:NSURLRequestReloadIgnoringCacheData
												   timeoutInterval:60];
		
		NSData * fetchedFeed = [NSURLConnection sendSynchronousRequest:request
													 returningResponse:nil error:nil];
		
		if ([[NSThread currentThread] isCancelled]) {
			return;
		}
		
		if (!fetchedFeed) {
			self.refreshThread = nil;
			[self performSelector:@selector(delegateInformFailed)
						 onThread:mainThread
					   withObject:nil
					waitUntilDone:NO];
			return;
		}
		
		RSSFeed * parsed = [RSSParser feedFromRSSDocument:fetchedFeed];
		
		if ([[NSThread currentThread] isCancelled]) {
			return;
		}
		
		if (!parsed) {
			self.refreshThread = nil;
			[self performSelector:@selector(delegateInformFailed)
						 onThread:mainThread
					   withObject:nil
					waitUntilDone:NO];
			return;
		}
		
		[self handleUpdatedFeed:parsed mainThread:mainThread];
		
		self.refreshThread = nil;
		[self performSelector:@selector(delegateInformDone)
					 onThread:mainThread
				   withObject:nil
				waitUntilDone:NO];
	}
}

- (void)handleUpdatedFeed:(RSSFeed *)newFeed mainThread:(NSThread *)mainThread {
	ANListMutations * mutations = [[ANListMutations alloc] initWithOld:[self.currentFeed items]
																   new:[newFeed items]];
	[mutations setCompareSelector:@selector(isEqualToItem:)];
	ANListChange * change = [mutations rootChangeFromOldToNew];
	[change applyTransformRecursively];
	
	self.currentFeed = newFeed;
	
	while (change != nil) {
		// TODO: if it's an insert, tell the delegate...
		if ([change isKindOfClass:[ANListChangeInsert class]]) {
			[self performSelector:@selector(delegateInformNew:)
						 onThread:mainThread
					   withObject:[(ANListChangeInsert *)change insertItem]
					waitUntilDone:NO];
		}
		change = change.nextChange;
	}
}

- (void)delegateInformNew:(RSSItem *)anItem {
	if ([delegate respondsToSelector:@selector(feedStream:foundNewArticle:)]) {
		[delegate feedStream:self foundNewArticle:anItem];
	}
}

- (void)delegateInformDone {
	if ([delegate respondsToSelector:@selector(feedStreamRefreshDone:)]) {
		[delegate feedStreamRefreshDone:self];
	}
}

- (void)delegateInformFailed {
	if ([delegate respondsToSelector:@selector(feedStreamRefreshFailed:)]) {
		[delegate feedStreamRefreshFailed:self];
	}
}

@end
