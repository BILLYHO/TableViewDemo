//
//  TableViewController.m
//  CallOrder
//
//  Created by BILLY HO on 12/22/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "TableViewController.h"

@implementation TableViewController


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSLog(@"numberOfSectionsInTableView");
	return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	NSLog(@"heightForHeaderInSection %ld", (long)section);
	return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	NSLog(@"heightForFooterInSection %ld", (long)section);
	return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"numberOfRowsInSection %ld", (long) section);
	return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"heightForRowAtIndexPath sec %ld, row %ld",indexPath.section, indexPath.row );
	return 44;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"cellForRowAtIndexPath sec %ld, row %ld",indexPath.section, indexPath.row);
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
	cell.textLabel.text = [NSString stringWithFormat:@"row %ld", (long)indexPath.row];
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"canEditRowAtIndexPath sec %ld, row %ld",indexPath.section, indexPath.row );
	return YES;
}

//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//	NSLog(@"viewForHeaderInSection %ld",section);
//	UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.sectionHeaderHeight)];
//	NSLog(@"%f",view.frame.size.height);
//	view.backgroundColor = [UIColor redColor];
//	return view;
//}

//- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//	
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSLog(@"titleForHeaderInSection sec %ld",section);
	return [NSString stringWithFormat:@"Section Header %ld", section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	NSLog(@"titleForFooterInSection sec %ld",section);
	return [NSString stringWithFormat:@"Section Footer %ld", section];
}

@end
