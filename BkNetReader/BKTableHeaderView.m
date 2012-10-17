//
//  BKTableHeaderView.m
//  BkNetReader
//
//  Created by Brian Keating on 12/10/2012.
//  Copyright (c) 2012 Brian Keating. All rights reserved.
//

#import "BKTableHeaderView.h"

@interface BKTableHeaderView()
{
	UILabel* label;
}
@end


@implementation BKTableHeaderView

- (id)initWithText:(NSString*)text
{
	UIImage* img = [UIImage imageNamed:@"arss_header.png"];
    //UIImage* img = [UIImage imageNamed:@"me.jpg"];
    if ((self = [super initWithImage:img])) {
        // Initialization code
		label = [[UILabel alloc] initWithFrame:CGRectMake(20,10,200,70)];
		label.textColor = [UIColor whiteColor];
		label.shadowColor = [UIColor grayColor];
		label.shadowOffset = CGSizeMake(1, 1);
		label.backgroundColor = [UIColor clearColor];
		label.font = [UIFont systemFontOfSize:20];
		label.text = text;
		label.numberOfLines = 2;
		[self addSubview:label];
    }
    return self;
}

- (void)setText:(NSString*)text
{
	label.text = text;
}

@end
