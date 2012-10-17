//
//  BKAppDelegate.h
//  BkNetReader
//
//  Created by Brian Keating on 05/10/2012.
//  Copyright (c) 2012 Brian Keating. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
