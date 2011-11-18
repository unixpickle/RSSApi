//
//  RSSFeedChangeInsert.h
//  RSSApi
//
//  Created by Alex Nichol on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANListChange.h"

@interface ANListChangeInsert : ANListChange {
	id insertItem;
}

@property (readonly) id insertItem;

- (id)initWithOriginalIndex:(NSUInteger)anIndex item:(id)anItem;

@end
