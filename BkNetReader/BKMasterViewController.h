//
//  BKMasterViewController.h
//  BkNetReader
//
//  Created by Brian Keating on 05/10/2012.
//  Copyright (c) 2012 Brian Keating. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface BKMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
