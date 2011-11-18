//
//  ANListPreservedBlock.m
//  RSSApi
//
//  Created by Alex Nichol on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANListPreservedBlock.h"

@implementation ANListPreservedBlock

@synthesize originalRange;

+ (ANListPreservedBlock *)blockWithRange:(NSRange)aRange {
	ANListPreservedBlock * block = [[ANListPreservedBlock alloc] init];
	block.originalRange = aRange;
	return block;
}

@end
