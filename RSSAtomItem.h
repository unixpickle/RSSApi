//
//  RSSAtomItem.h
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANHTMLDocument.h"
#import "RSSItem.h"
#import "RSSItemAtomIdentifier.h"
#import "RSSItemURLIdentifier.h"

@interface RSSAtomItem : RSSItem {
	
}

- (id)initWithEntryNode:(ANHTMLElement *)entry;

@end
