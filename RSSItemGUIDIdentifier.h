//
//  RSSItemGUIDIdentifier.h
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSItemIdentifier.h"

@interface RSSItemGUIDIdentifier : RSSItemIdentifier {
	NSString * guidString;
}

@property (readonly) NSString * guidString;

- (id)initWithGUID:(NSString *)guid;

@end
