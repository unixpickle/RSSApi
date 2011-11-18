//
//  ANListMutations.m
//  RSSApi
//
//  Created by Alex Nichol on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANListMutations.h"

@interface ANListMutations (Splitting)

- (BOOL)compareItem:(id)anItem toItem:(id)anotherItem;
- (void)groupPreservedBlocks;

@end

@implementation ANListMutations

@synthesize compareSelector;

- (id)initWithOld:(NSArray *)oldArray new:(NSArray *)newArray {
	if ((self = [super init])) {
		oldList = oldArray;
		newList = newArray;
		compareSelector = @selector(isEqual:);
	}
	return self;
}

- (ANListChange *)rootChangeFromOldToNew {
	// several stages are involved here
	if (!groupedBlocks) {
		[self groupPreservedBlocks];
	}
	
	ANListChange * rootChange = [[ANListChange alloc] init];
	ANListChange * lastChange = rootChange;
	
	NSUInteger oldIndex = 0;
	for (NSUInteger i = 0; i < [groupedBlocks count]; i++) {
		id anObject = [groupedBlocks objectAtIndex:i];
		if ([anObject isKindOfClass:[ANListPreservedBlock class]]) {
			ANListPreservedBlock * block = (ANListPreservedBlock *)anObject;
			while (oldIndex < block.originalRange.location) {
				ANListChangeRemove * remove = [[ANListChangeRemove alloc] initWithOriginalIndex:oldIndex];
				lastChange.nextChange = remove;
				lastChange = remove;
				oldIndex += 1;
			}
			oldIndex += block.originalRange.length;
		} else {
			// object was inserted
			ANListChangeInsert * insert = [[ANListChangeInsert alloc] initWithOriginalIndex:oldIndex item:anObject];
			lastChange.nextChange = insert;
			lastChange = insert;
		}
	}
	
	while (oldIndex < [oldList count]) {
		ANListChangeRemove * remove = [[ANListChangeRemove alloc] initWithOriginalIndex:oldIndex];
		lastChange.nextChange = remove;
		lastChange = remove;
		oldIndex += 1;
	}
	
	return rootChange.nextChange;
}

#pragma mark Algorithm

- (void)groupPreservedBlocks {
	groupedBlocks = [NSMutableArray array];
	NSUInteger oldIndex = 0;
	NSUInteger newIndex = 0;
	while (newIndex < [newList count]) {
		id anItem = [newList objectAtIndex:newIndex];
		BOOL foundIntersection = NO;
		// find it after old index in the old list
		for (NSUInteger i = oldIndex; i < [oldList count]; i++) {
			id anotherItem = [oldList objectAtIndex:i];
			if ([self compareItem:anItem toItem:anotherItem]) {
				// found our intersection point
				oldIndex = i + 1;
				NSUInteger startIndex = i;
				NSUInteger length = 1;
				foundIntersection = YES;
				newIndex++;
				for (NSUInteger j = startIndex + 1; j < [oldList count]; j++) {
					if (newIndex == [newList count]) break;
					id nextItem = [oldList objectAtIndex:j];
					id correspondingItem = [newList objectAtIndex:newIndex];
					if ([self compareItem:nextItem toItem:correspondingItem]) {
						length += 1;
						newIndex++;
						oldIndex++;
					} else break;
				}
				
				NSRange originalBlock = NSMakeRange(startIndex, length);
				ANListPreservedBlock * block = [ANListPreservedBlock blockWithRange:originalBlock];
				[groupedBlocks addObject:block];
				
				break;
			}
		}
		
		if (!foundIntersection) {
			[groupedBlocks addObject:anItem];
			newIndex++;
		}
	}
}

- (BOOL)compareItem:(id)anItem toItem:(id)anotherItem {
	NSMethodSignature * signature = [anItem methodSignatureForSelector:compareSelector];
	NSInvocation * compare = [NSInvocation invocationWithMethodSignature:signature];
	[compare setTarget:anItem];
	[compare setSelector:compareSelector];
	[compare setArgument:&anotherItem atIndex:2];
	BOOL result = NO;
	[compare invoke];
	[compare getReturnValue:&result];
	return result;
}

@end
