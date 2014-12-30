//
//  ViewController.m
//  pullToRefreshDemo
//
//  Created by BILLY HO on 3/19/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	_numberOfRows = 15;
	
	_refreshControl = [[UIRefreshControl alloc] init];
	[_refreshControl addTarget:self
						action:@selector(refreshView:)
			  forControlEvents:UIControlEventValueChanged];
	
	[_refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"下拉刷新"]];
	[_demoTableView addSubview:_refreshControl];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.refreshControl beginRefreshing];
		[self.refreshControl endRefreshing];
	});
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _numberOfRows;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *infoCellIndentifier = @"identifier";
	UITableViewCell	*cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:infoCellIndentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoCellIndentifier];
	}
	
	cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", indexPath.row];
	
	return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)refreshView:(UIRefreshControl *)refresh
{
	_numberOfRows += 2;

	sleep(1);

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"上次更新日期 %@",
                             [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    
	[refresh endRefreshing];
	[self.demoTableView reloadData];
}



@end
