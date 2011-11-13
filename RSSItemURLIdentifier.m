//
//  RSSItemURLIdentifier.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSItemURLIdentifier.h"

@implementation RSSItemURLIdentifier

@synthesize webURL;

- (id)initWithURL:(NSURL *)aURL {
	if ((self = [super init])) {
		webURL = aURL;
	}
	return self;
}

- (BOOL)isEqualToIdentifier:(RSSItemIdentifier *)anIdentifier {
	if (![anIdentifier isKindOfClass:[RSSItemURLIdentifier class]]) {
		return NO;
	}
	if ([[self webURL] isEqual:[(RSSItemURLIdentifier *)anIdentifier webURL]]) {
		return YES;
	}
	return NO;
}

@end
