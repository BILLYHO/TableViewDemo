//
//  TableViewController.m
//  AutoResizeCell
//
//  Created by BILLY HO on 12/29/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "TableViewController.h"
#import "LoremIpsum.h"
#import "ResizeCell.h"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *textArr;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	_textArr = [[NSMutableArray alloc] init];
	for (int i=0; i<20; i++)
	{
		[_textArr addObject:[LoremIpsum paragraph]];
	}
	
	//NSLog(@"%f, %f", self.view.frame.size.width, self.view.frame.size.height);
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _textArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResizeCell"];
	if (!cell)
	{
		cell = [[ResizeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ResizeCell"];
	}
    
	[cell configCellWithText: _textArr[indexPath.row] pic:(indexPath.row % 2 == 0 ? YES : NO)];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	return 200;
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
