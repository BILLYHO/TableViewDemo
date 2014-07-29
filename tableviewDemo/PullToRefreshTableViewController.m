//
//  PullToRefreshTableViewController.m
//  tableviewDemo
//
//  Created by billy.ho on 7/25/14.
//  Copyright (c) 2014 BILLYHO. All rights reserved.
//

#import "PullToRefreshTableViewController.h"
#import "MJRefresh.h"

@interface PullToRefreshTableViewController ()
@property (nonatomic, strong) UITableView *myTable;
@end

@implementation PullToRefreshTableViewController

static int row;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Pull To Refresh TableView";
    _myTable = [[UITableView alloc] initWithFrame:self.view.frame];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    self.navigationController.navigationBar.translucent = YES;
    [self.view addSubview:_myTable];
    [_myTable addHeaderWithTarget:self action:@selector(headerRereshing)];
    row = 2;
    [_myTable headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)headerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        row += 2;
        [_myTable reloadData];
        [_myTable headerEndRefreshing];
    });
}
#pragma -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return row;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier: identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    
    return cell;
}

#pragma -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
