//
//  ANListMutations.h
//  RSSApi
//
//  Created by Alex Nichol on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANListChangeInsert.h"
#import "ANListChangeRemove.h"
#import "ANListPreservedBlock.h"

@interface ANListMutations : NSObject {
	NSArray * newList;
	NSArray * oldList;
	NSMutableArray * groupedBlocks;
	
	SEL compareSelector;
}

@property (readwrite) SEL compareSelector;

- (id)initWithOld:(NSArray *)oldArray new:(NSArray *)newArray;

- (ANListChange *)rootChangeFromOldToNew;

@end
