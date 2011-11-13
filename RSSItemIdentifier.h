//
//  RSSItemIdentifier.h
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * An abstract class for item identifiers.
 * This could be subclassed for different kinds of
 * RSS feeds.
 */
@interface RSSItemIdentifier : NSObject {
	
}

- (BOOL)isEqualToIdentifier:(RSSItemIdentifier *)anIdentifier;

@end
