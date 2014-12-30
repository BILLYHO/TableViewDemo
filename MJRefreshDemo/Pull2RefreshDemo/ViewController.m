//
//  ViewController.m
//  Pull2RefreshDemo
//
//  Created by BILLY HO on 3/20/14.
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
	_numberOfRows = 10;
	
	// 集成刷新控件
    // 下拉刷新
    [self addHeader];
    // 上拉加载更多
    [self addFooter];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addHeader
{
    //__unsafe_unretained UITableViewController *vc = self;
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.demoTableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        
        _numberOfRows += 1;
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0.5];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    //[header beginRefreshing];
    _header = header;
}

- (void)addFooter
{
    //__unsafe_unretained UITableViewController *vc = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.demoTableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        
		_numberOfRows += 2;
        
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是footer
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0.5];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    _footer = footer;
}



- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.demoTableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
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
	
	cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
	
	return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
