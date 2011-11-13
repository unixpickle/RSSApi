//
//  RSSItemIdentifier.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSItemIdentifier.h"

@implementation RSSItemIdentifier

- (BOOL)isEqualToIdentifier:(RSSItemIdentifier *)anIdentifier {
	if (![anIdentifier isKindOfClass:[self class]] || ![self isKindOfClass:[anIdentifier class]]) {
		return NO;
	}
	return YES;
}

@end
