//
//  RSSParser.h
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSS2Feed.h"
#import "RSSAtomFeed.h"

@interface RSSParser : NSObject {
	
}

+ (RSSFeed *)feedFromRSSDocument:(NSData *)document;

@end
