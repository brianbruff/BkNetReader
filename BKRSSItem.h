//
//  BKRSSItem.h
//  BkNetReader
//
//  Created by Brian Keating on 12/10/2012.
//  Copyright (c) 2012 Brian Keating. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKRSSItem : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSURL* link;
@property (strong, nonatomic) NSAttributedString* cellMessage;


@end
