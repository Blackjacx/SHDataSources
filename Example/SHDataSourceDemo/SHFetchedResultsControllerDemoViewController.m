//
//  SHFetchedResultsControllerDemoViewController.m
//  SHDataSourceDemo
//
//  Created by Stefan Herold on 08/10/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import "SHFetchedResultsControllerDemoViewController.h"

@interface SHFetchedResultsControllerDemoViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic) SHDataSource * dataSource;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property(nonatomic) NSManagedObjectModel *managedObjectModel;
@property(nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

static NSString *coloredCellID = @"coloredCellID";
static NSString *textCellID = @"textCellID";
static NSString *kDemoEntityName = @"Color";
static NSString *kManagedObjectModelFileName = @"DataBase";
static NSString *kSQLITEDataBasename = @"DataBase.sqlite";


@implementation SHFetchedResultsControllerDemoViewController


// =================================================================================================
#pragma mark - Loading
// =================================================================================================


- (void)viewDidLoad {
	[super viewDidLoad];
	
	SHItemCollection *collection = [[SHItemCollection alloc] initWithFetchedResultsController:self.fetchedResultsController cellIdentifier:textCellID];
	collection.fetchedResultsControllerDelegate = self;
	self.dataSource = [SHDataSource dataSourceWithItemCollection:collection cellConfigurationHandler:^(id <SHDataSourcesCellDataHandler> cell, id item, NSIndexPath *indexPath) {
		[cell setData:item];
	}];
	self.dataSource.editable = YES;
//	self.dataSource.draggingEnabled = YES; // Reordering in a core data example makes no sense unless we burn the order into the model
	
	self.tableView.dataSource = self.dataSource;
	
	[self performSelector:@selector(addItemsToUltraHighSection) withObject:nil afterDelay:3.0f];
	[self performSelector:@selector(addItemsToFirstSection) withObject:nil afterDelay:6.0f];
	[self performSelector:@selector(insertItemsAtTheBeginningOfSectionOne) withObject:nil afterDelay:9.0f];
}


// -------------------------------------------------------------------------------------------------


- (void)addItemsToUltraHighSection {
	[self.dataSource addItems:@[[UIColor purpleColor], [UIColor orangeColor]] toSection:1000 cellIdentifier:coloredCellID];
}


// -------------------------------------------------------------------------------------------------


- (void)addItemsToFirstSection {
	[self.dataSource addItems:@[[UIColor blackColor], [UIColor lightGrayColor]] toSection:0 cellIdentifier:coloredCellID];
}


// -------------------------------------------------------------------------------------------------


- (void)insertItemsAtTheBeginningOfSectionOne {
	[self.dataSource insertItems:@[[UIColor magentaColor], [UIColor yellowColor]] atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] withCellIdentifier:coloredCellID];
}


// =================================================================================================
#pragma mark - Actions
// =================================================================================================


- (IBAction)onEdit:(id)sender {
	BOOL newValue = !self.tableView.editing;
	[self.tableView setEditing:newValue animated:YES];
	UIBarButtonItem *newItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:newValue ?UIBarButtonSystemItemDone : UIBarButtonSystemItemEdit target:self action:_cmd];
	self.navigationItem.rightBarButtonItem = newItem;
}


// =================================================================================================
#pragma mark - UITableViewCell Delegate
// =================================================================================================


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellID = [self.dataSource cellIdentifierForIndexPath:indexPath];
	if([cellID isEqualToString:textCellID]) {
		return 88.0f;
	}
	return 44.0f;
}


// =================================================================================================
#pragma mark - SHItemCollectionFetchedResultsController Delegate
// =================================================================================================


- (void)fetchedResultsController:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	UITableView *tableView = self.tableView;
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
			break;
			
		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
			break;
			
		case NSFetchedResultsChangeUpdate:
			[tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
			break;
			
		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
			[tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
			break;
	}
}


// -------------------------------------------------------------------------------------------------


- (void)fetchedResultsControllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView endUpdates];
}


// -------------------------------------------------------------------------------------------------


- (void)fetchedResultsControllerWillChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView beginUpdates];
}


// =================================================================================================
#pragma mark - Undo Support
// =================================================================================================


- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (NSUndoManager *)undoManager {
	return self.managedObjectContext.undoManager;
}


// =================================================================================================
#pragma mark - Core Data Stack (usually in App-Delegate)
// =================================================================================================


- (NSFetchedResultsController *)fetchedResultsController {
	if (_fetchedResultsController != nil) {
		return _fetchedResultsController;
	}
	
	// Create the fetch request for the entity.
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:kDemoEntityName inManagedObjectContext:self.managedObjectContext];
	[request setEntity:entity];
	
	/* Optional settings
	 
	 [request setResultType:NSManagedObjectResultType];
	 [request setIncludesPropertyValues:YES];
	 [request setIncludesPendingChanges:NO];
	 [request setReturnsObjectsAsFaults:NO];
	 */
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
	[request setSortDescriptors:@[sortDescriptor]];
	
	// Edit the section name key path and cache name if appropriate.
	// nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	self.fetchedResultsController = aFetchedResultsController;
	
	return _fetchedResultsController;
}


// -------------------------------------------------------------------------------------------------


- (NSManagedObjectContext *)managedObjectContext {
	// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
	if (_managedObjectContext != nil) {
		return _managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
	if (!coordinator) {
		return nil;
	}
	
	_managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	_managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
	_managedObjectContext.undoManager = [[NSUndoManager alloc] init];
	
	return _managedObjectContext;
}

- (NSURL *)applicationDocumentsDirectory {
	// The directory the application uses to store the Core Data store file.
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


// -------------------------------------------------------------------------------------------------


- (NSManagedObjectModel *)managedObjectModel {
	// The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kManagedObjectModelFileName withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}


// -------------------------------------------------------------------------------------------------


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	// The persistent store coordinator for the application. This implementation creates and return a coordinator, having added
	// 1) A sqlite persistent store for permanent storage of objects on disk
	// 2) An in-memory store for temporary files
	if (_persistentStoreCoordinator != nil) {
		return _persistentStoreCoordinator;
	}
	
	// Create the coordinator and store
	
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kSQLITEDataBasename];
	NSError *sqliteError = nil;
	NSString *failureReason = @"There was an error creating or loading the application's saved data.";
	
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&sqliteError]) {
#if DEBUG
		// Report any error we got.
		NSMutableDictionary *dict = [NSMutableDictionary dictionary];
		dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
		dict[NSLocalizedFailureReasonErrorKey] = failureReason;
		dict[NSUnderlyingErrorKey] = sqliteError;
		sqliteError = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
		// Replace this with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", sqliteError, [sqliteError userInfo]);
		abort();
#endif
	}
	
	return _persistentStoreCoordinator;
}


@end
