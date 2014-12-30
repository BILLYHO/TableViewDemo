//
//  ViewController.h
//  pullToRefreshDemo
//
//  Created by BILLY HO on 3/19/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *demoTableView;
@property (nonatomic, strong) UIRefreshControl* refreshControl;

@property (nonatomic) NSInteger numberOfRows;

@end
