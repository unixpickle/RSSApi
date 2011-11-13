//
//  RSSItemGUIDIdentifier.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSItemGUIDIdentifier.h"

@implementation RSSItemGUIDIdentifier

@synthesize guidString;

- (id)initWithGUID:(NSString *)guid {
	if ((self = [super init])) {
		guidString = guid;
	}
	return self;
}

- (BOOL)isEqualToIdentifier:(RSSItemIdentifier *)anIdentifier {
	if (![anIdentifier isKindOfClass:[RSSItemGUIDIdentifier class]]) {
		return NO;
	}
	if ([[self guidString] isEqualToString:[(RSSItemGUIDIdentifier *)guidString guidString]]) {
		return YES;
	}
	return NO;
}

@end
