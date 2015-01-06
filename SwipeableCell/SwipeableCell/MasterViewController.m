//
//  MasterViewController.m
//  SwipeableCell
//
//  Created by BILLY HO on 12/31/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "SwipeableCell.h"

@interface MasterViewController () <SwipeableCellDelegate> {
	NSMutableArray *_objects;
}

@property (nonatomic, strong) NSIndexPath *cellsCurrentlyEditing;
@end

@implementation MasterViewController

- (void)awakeFromNib {
	[super awakeFromNib];
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
	    self.clearsSelectionOnViewWillAppear = NO;
	    self.preferredContentSize = CGSizeMake(320.0, 600.0);
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	//1
	_objects = [NSMutableArray array];
 
	//2
	NSInteger numberOfItems = 30;
	for (NSInteger i = 1; i <= numberOfItems; i++)
	{
		NSString *item = [NSString stringWithFormat:@"Longer Title Item #%ld", i];
		[_objects addObject:item];
	}
	
	//self.cellsCurrentlyEditing = [[NSIndexPath alloc]init];
	self.cellsCurrentlyEditing = nil;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([[segue identifier] isEqualToString:@"showDetail"]) {
	    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	    NSDate *object = _objects[indexPath.row];
	    DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
	    [controller setDetailItem:object];
	    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
	    controller.navigationItem.leftItemsSupplementBackButton = YES;
	}
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	SwipeableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
 
	NSString *item = _objects[indexPath.row];
	cell.itemText = item;
	cell.delegate = self;
	if ([self.cellsCurrentlyEditing isEqual:indexPath]) {
		[cell openCell];
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.cellsCurrentlyEditing) {
		SwipeableCell *cell = (SwipeableCell *)[tableView cellForRowAtIndexPath:self.cellsCurrentlyEditing];
		[cell closeCell];
	}
	else
	{
		NSDate *object = _objects[indexPath.row];
		UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
		DetailViewController *controller = (DetailViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"DetailViewController"];
		[controller setDetailItem:object];
		controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
		controller.navigationItem.leftItemsSupplementBackButton = YES;
		[self.navigationController pushViewController:controller animated:YES];
	}
}

#pragma mark - SwipeableCellDelegate
- (void)buttonOneActionForItemText:(NSString *)itemText {
	NSLog(@"In the delegate, Clicked button one for %@", itemText);
	[self showDetailWithText:[NSString stringWithFormat:@"Clicked button one for %@", itemText]];
}

- (void)buttonTwoActionForItemText:(NSString *)itemText {
	NSLog(@"In the delegate, Clicked button two for %@", itemText);
	[self showDetailWithText:[NSString stringWithFormat:@"Clicked button two for %@", itemText]];
}

- (void)showDetailWithText:(NSString *)detailText
{
	//1
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	DetailViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
	detail.title = @"In the delegate!";
	detail.detailItem = detailText;
 
	//2
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detail];
 
	//3
	UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeModal)];
	[detail.navigationItem setRightBarButtonItem:done];
 
	[self presentViewController:navController animated:YES completion:nil];
}

//4
- (void)closeModal
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)cellShouldOpen:(UITableViewCell *)cell
{
	if (self.cellsCurrentlyEditing)
	{
		SwipeableCell *oldCell = (SwipeableCell *)[self.tableView cellForRowAtIndexPath:self.cellsCurrentlyEditing];
		[oldCell closeCell];
		self.tableView.scrollEnabled = YES;
		return NO;
	}
	return YES;
}

- (void)cellWillOpen:(UITableViewCell *)cell
{
	self.tableView.scrollEnabled = NO;
}

- (void)cellDidOpen:(UITableViewCell *)cell {
	NSIndexPath *currentEditingIndexPath = [self.tableView indexPathForCell:cell];
	self.cellsCurrentlyEditing = currentEditingIndexPath;
	self.tableView.scrollEnabled = NO;
}

- (void)cellDidClose:(UITableViewCell *)cell {
	self.cellsCurrentlyEditing = nil;
	self.tableView.scrollEnabled = YES;
}

@end
