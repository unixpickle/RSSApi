//
//  ANListPreservedBlock.h
//  RSSApi
//
//  Created by Alex Nichol on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANListPreservedBlock : NSObject {
	NSRange originalRange;
}

@property (readwrite) NSRange originalRange;

+ (ANListPreservedBlock *)blockWithRange:(NSRange)aRange;

@end
