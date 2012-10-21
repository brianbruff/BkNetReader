//
//  BKRSSItem.h
//  BkNetReader
//
//  Created by Brian Keating on 12/10/2012.
//  Copyright (c) 2012 Brian Keating. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface BKRSSItem : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* desc;
@property (strong, nonatomic) NSDate* timestamp;
@property (strong, nonatomic) NSString* url;
//@property (strong, nonatomic) NSString* pubDate;

-(void)initWithPost:(Post*) post;

@end
