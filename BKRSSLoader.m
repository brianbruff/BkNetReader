//
//  BKRSSLoader.m
//  BkNetReader
//
//  Created by Brian Keating on 12/10/2012.
//  Copyright (c) 2012 Brian Keating. All rights reserved.
//

#import "BKRSSLoader.h"

#import "RXMLElement.h"
#import "BKRSSItem.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation BKRSSLoader

-(void)fetchRssWithURL:(NSURL*)url complete:(RSSLoaderCompleteBlock)c
{
    dispatch_async(kBgQueue, ^{
        
        @try
        {            
            //work in the background
            RXMLElement *rss = [RXMLElement elementFromURL: url];            
            
            RXMLElement* title = [[rss child:@"channel"] child:@"title"];
            NSArray* items = [[rss child:@"channel"] children:@"item"];
            
            NSMutableArray* result = [NSMutableArray arrayWithCapacity:items.count];
            
            for (RXMLElement *e in items) {
                
                //iterate over the articles
                BKRSSItem* item = [[BKRSSItem alloc] init];
                item.title = [[e child:@"title"] text];
                item.desc = [[e child:@"description"] text];
                NSString * url = [NSString stringWithFormat:@"%@%@", [[e child:@"link"] text], @"?theme=App"];
                item.url = url;
                item.timestamp = [BKRSSLoader getDateForPublishString:[[e child:@"pubDate"] text]];
                
                [result addObject: item];
            }
            
            c([title text], result);
        }
        @catch (NSException* exp)
        {
            c(nil, nil);
        }
    });
}

+(NSDate*)getDateForPublishString:(NSString*) pubString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZ"];
    
    return [formatter dateFromString:pubString];
}


@end
