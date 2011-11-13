//
//  RSS2Item.h
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSItem.h"
#import "ANHTMLDocument.h"
#import "RSSItemURLIdentifier.h"
#import "RSSItemGUIDIdentifier.h"

@interface RSS2Item : RSSItem {
	
}

- (id)initWithItemNode:(ANHTMLElement *)item;

@end
