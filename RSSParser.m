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
	ANHTMLDocument * document = [[ANHTMLDocument alloc] initWithHTMLDocument:_document];
	if (!document) {
		return nil;
	}
	ANHTMLElement * rootFeedElem = [document rootElement];
	if ([rootFeedElem nameEquals:@"feed"]) {
		return [[RSSAtomFeed alloc] initWithRootNode:rootFeedElem];
	} else if ([rootFeedElem nameEquals:@"rss"]) {
		return [[RSS2Feed alloc] initWithRootNode:rootFeedElem];
	} else {
		return nil;
	}
}

@end
