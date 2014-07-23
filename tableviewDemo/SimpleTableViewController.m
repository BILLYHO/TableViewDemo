//
//  SimpleTableViewController.m
//  tableviewDemo
//
//  Created by billy.ho on 7/23/14.
//  Copyright (c) 2014 BILLYHO. All rights reserved.
//

#import "SimpleTableViewController.h"
#import "ViewController.h"

@interface SimpleTableViewController ()

@property (nonatomic, strong) NSArray *contentArr;
@property (nonatomic, strong) NSArray *vcArr;

@end

@implementation SimpleTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupContentArr];
    [self setupVCArr];
    
    self.title = @"SimpleTableView";
    UITableView *simpleTableView = [[UITableView alloc] initWithFrame:self.view.frame];
    simpleTableView.delegate = self;
    simpleTableView.dataSource = self;
    [self.view addSubview:simpleTableView];
    [simpleTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupContentArr
{
    _contentArr = @[@"Customed Table View"];
}

- (void)setupVCArr
{
    ViewController *view = [[ViewController alloc] init];
    _vcArr = @[view];
}

#pragma -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contentArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier: identifier];
    }
    
    cell.textLabel.text = [_contentArr objectAtIndex:indexPath.row];
    return cell;
}

#pragma -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[_vcArr objectAtIndex:indexPath.row] animated:YES];
}

@end
