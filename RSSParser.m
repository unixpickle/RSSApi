//
//  RSSParser.m
//  RSSApi
//
//  Created by Alex Nichol on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSSParser.h"

@implementation RSSParser

+ (RSSFeed *)feedFromRSSDocument:(NSData *)_document {
	ANHTMLDocument * document = [[ANHTMLDocument alloc] initWithDocumentData:_document];
	if (!document) {
		return nil;
	}
	ANHTMLElement * rootFeedElem = [document rootElement];
	if ([rootFeedElem compareName:@"feed"]) {
		return [[RSSAtomFeed alloc] initWithRootNode:rootFeedElem];
	} else if ([rootFeedElem compareName:@"rss"]) {
		return [[RSS2Feed alloc] initWithRootNode:rootFeedElem];
	} else {
		return nil;
	}
}

@end
