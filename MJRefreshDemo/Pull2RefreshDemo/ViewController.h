//
//  ViewController.h
//  Pull2RefreshDemo
//
//  Created by BILLY HO on 3/20/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *demoTableView;

//@property (nonatomic, strong) UIRefreshControl* refreshControl;

@property (strong, nonatomic) MJRefreshHeaderView *header;
@property (strong, nonatomic) MJRefreshFooterView *footer;

@property (nonatomic) NSInteger numberOfRows;

@end
