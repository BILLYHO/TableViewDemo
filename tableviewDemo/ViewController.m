//
//  ViewController.m
//  tableviewDemo
//
//  Created by billy.ho on 7/15/14.
//  Copyright (c) 2014 BILLYHO. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"TableViewDemo";
    UITableView *myTable = [[UITableView alloc] initWithFrame:self.view.frame];
    myTable.delegate = self;
    myTable.dataSource = self;
    self.navigationController.navigationBar.translucent = YES;
    [self.view addSubview:myTable];
    [myTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %d", section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SimpleTableIdentifier";

    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: identifier];
    }
    
    NSString *content = [NSString stringWithFormat:@"Row %d, Section %d", indexPath.row, indexPath.section];
    
    [cell configCell:content];
    return cell;
}

#pragma -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
