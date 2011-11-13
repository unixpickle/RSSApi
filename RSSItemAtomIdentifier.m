//
//  RSSItemAtomIdentifier.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSItemAtomIdentifier.h"

@implementation RSSItemAtomIdentifier

@synthesize identifierString;

- (id)initWithIDString:(NSString *)idString {
	if ((self = [super init])) {
		NSCharacterSet * whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
		identifierString = [idString stringByTrimmingCharactersInSet:whitespace];
	}
	return self;
}

- (BOOL)isEqualToIdentifier:(RSSItemIdentifier *)anIdentifier {
	if (![anIdentifier isKindOfClass:[RSSItemAtomIdentifier class]]) {
		return NO;
	}
	if ([[self identifierString] isEqualToString:[(RSSItemAtomIdentifier *)anIdentifier identifierString]]) {
		return YES;
	}
	return NO;
}

@end
