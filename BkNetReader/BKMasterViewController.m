//
//  BKMasterViewController.m
//  BkNetReader
//
//  Created by Brian Keating on 05/10/2012.
//  Copyright (c) 2012 Brian Keating. All rights reserved.
//

#import "BKMasterViewController.h"
#import "BKDetailViewController.h"
#import "BKTableHeaderView.h"
#import "BKRSSLoader.h"
#import "BKRSSItem.h"



@interface BKMasterViewController ()
{
    NSArray *_objects;
    NSURL* feedURL;
    UIRefreshControl* refreshControl;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end


@implementation BKMasterViewController



#pragma mark - Table View



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configuration
    self.title = @"BrianKeating.net";
   feedURL = [NSURL URLWithString:@"http://www.briankeating.net/syndication.axd"];
    
    
    //add refresh control to the table view
    refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self
                       action:@selector(refreshInvoked:forState:)
             forControlEvents:UIControlEventValueChanged];
    
    NSString* fetchMessage = [NSString stringWithFormat:@"Fetching: %@",feedURL];
    
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage
                                                                     attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:11.0]}];
    
    [self.tableView addSubview: refreshControl];
    
    // add the header
    self.tableView.tableHeaderView = [[BKTableHeaderView alloc] initWithText:@"fetching rss reed"];
    
    [self refreshFeed];
    
}



//ADD as a separate method
-(void) refreshInvoked:(id)sender forState:(UIControlState)state {
    [self refreshFeed];
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        BKRSSItem* item = [_objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:item];
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Posts" inManagedObjectContext	:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [[self.fetchedResultsController sections] count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    //return [sectionInfo numberOfObjects];
    return [_objects count];
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
   // NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSObject* object = [_objects objectAtIndex:indexPath.row];
    BKRSSItem *item = (BKRSSItem*)object;
    //cell.textLabel.text = [[item valueForKey:@"name"] description];
    cell.textLabel.text = item.title;
}


-(void)refreshFeed
{
    [refreshControl endRefreshing];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    BKRSSLoader* rss = [[BKRSSLoader alloc] init];
    [rss fetchRssWithURL:feedURL
                complete:^(NSString *title, NSArray *results) {
                    //completed fetching the RSS
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //UI code on the main queue
                        [(BKTableHeaderView*)self.tableView.tableHeaderView setText:title];
                        
                        _objects = results;
                        
                        //for (NSObject* obj in _objects){
                         //   [self insertNewObject:obj];
                        //}
                        
                        [self.tableView reloadData];
                        
                        // Stop refresh control
                        //[self.refreshControl endRefreshing];
                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    });
                }];
    // Stop refresh control
    [self.refreshControl endRefreshing];
}


- (void)insertNewObject:(NSObject*) object
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newPostObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    BKRSSItem* item = (BKRSSItem*)object;		
    // Set the values
    [newPostObject setValue:item.title forKey:@"title"];
    [newPostObject setValue:item.description forKey:@"desc"];
    [newPostObject setValue:[item.link absoluteString] forKey:@"url"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

@end
