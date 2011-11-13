//
//  RSSItem.h
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSItemIdentifier.h"

@interface RSSItem : NSObject {
	RSSItemIdentifier * identifier;
	NSString * title;
	NSString * summary;
	NSURL * articleURL;
	NSURL * alternateURL;
	NSDate * creationDate;
	NSDate * updateDate;
}

@property (readonly) RSSItemIdentifier * identifier;
@property (readonly) NSString * title;
@property (readonly) NSString * summary;
@property (readonly) NSURL * articleURL;
@property (readonly) NSURL * alternateURL;
@property (readonly) NSDate * creationDate;
@property (readonly) NSDate * updateDate;

- (BOOL)isEqualToItem:(RSSItem *)anotherItem;

@end
