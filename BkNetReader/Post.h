//
//  Post.h
//  BkNetReader
//
//  Created by Brian Keating on 21/10/2012.
//  Copyright (c) 2012 Brian Keating. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSDate * timestamp;

@end
