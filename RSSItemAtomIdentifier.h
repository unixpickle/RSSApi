//
//  RSSItemAtomIdentifier.h
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSItemIdentifier.h"

@interface RSSItemAtomIdentifier : RSSItemIdentifier {
	NSString * identifierString;
}

@property (readonly) NSString * identifierString;

- (id)initWithIDString:(NSString *)idString;

@end
