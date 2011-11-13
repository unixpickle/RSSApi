//
//  RSSFeed.h
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANHTMLDocument.h"

@interface RSSFeed : NSObject {
	NSArray * items;
	NSString * title;
	NSURL * link;
	NSString * feedDescription;
}

@property (readonly) NSArray * items;
@property (readonly) NSString * title;
@property (readonly) NSURL * link;
@property (readonly) NSString * feedDescription;

- (id)initWithRootNode:(ANHTMLElement *)element;

@end
