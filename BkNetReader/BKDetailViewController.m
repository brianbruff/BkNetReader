//
//  BKDetailViewController.m
//  BkNetReader
//
//  Created by Brian Keating on 05/10/2012.
//  Copyright (c) 2012 Brian Keating. All rights reserved.
//

#import "BKDetailViewController.h"
#import "BKRSSItem.h"

@interface BKDetailViewController ()
{
    IBOutlet UIWebView* webView;
}
@end

@implementation BKDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    BKRSSItem* item = (BKRSSItem*)self.detailItem;
    self.title = item.title;
    webView.delegate = self;
    NSURLRequest* articleRequest = [NSURLRequest requestWithURL: item.link];
    [webView loadRequest: articleRequest];
}

-(void)viewDidDisappear:(BOOL)animated
{
    webView.delegate = nil;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

@end
