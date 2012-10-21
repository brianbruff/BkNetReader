//
//  BKRSSItem.m
//  BkNetReader
//
//  Created by Brian Keating on 12/10/2012.
//  Copyright (c) 2012 Brian Keating. All rights reserved.
//

#import "BKRSSItem.h"

@implementation BKRSSItem


 -(void)initWithPost:(Post*) post
 {
     self.url = post.url;
     self.title = post.title;
     self.timestamp = post.timestamp;
     self.desc = post.desc;
 }


@end
