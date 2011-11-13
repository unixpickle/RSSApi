//
//  RSSItemURLIdentifier.h
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSItemIdentifier.h"

@interface RSSItemURLIdentifier : RSSItemIdentifier {
	NSURL * webURL;
}

@property (readonly) NSURL * webURL;

- (id)initWithURL:(NSURL *)aURL;

@end
