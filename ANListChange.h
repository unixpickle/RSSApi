//
//  RSSFeedChange.h
//  RSSApi
//
//  Created by Alex Nichol on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANListChange : NSObject {
	NSUInteger affectedIndex;
	NSUInteger originalIndex;
	ANListChange * nextChange;
}

@property (readwrite) NSUInteger affectedIndex;
@property (readonly) NSUInteger originalIndex;
@property (nonatomic, retain) ANListChange * nextChange;

- (id)initWithOriginalIndex:(NSUInteger)anIndex;

- (void)applyIndexTransformToChildren;
- (void)applyTransformRecursively;
- (void)resetRecursively;

@end
