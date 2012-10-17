//
//  BKRSSLoader.h
//  BkNetReader
//
//  Created by Brian Keating on 12/10/2012.
//  Copyright (c) 2012 Brian Keating. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RSSLoaderCompleteBlock)(NSString* title, NSArray* results);

@interface BKRSSLoader : NSObject

-(void)fetchRssWithURL:(NSURL*)url complete:(RSSLoaderCompleteBlock)c;

@end
