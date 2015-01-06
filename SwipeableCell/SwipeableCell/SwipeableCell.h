//
//  SwipeableCell.h
//  SwipeableCell
//
//  Created by BILLY HO on 12/31/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwipeableCellDelegate <NSObject>
- (void)buttonOneActionForItemText:(NSString *)itemText;
- (void)buttonTwoActionForItemText:(NSString *)itemText;
- (BOOL)cellShouldOpen:(UITableViewCell *)cell;
- (void)cellWillOpen:(UITableViewCell *)cell;
- (void)cellDidOpen:(UITableViewCell *)cell;
- (void)cellDidClose:(UITableViewCell *)cell;
@end

@interface SwipeableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIButton *button1;
@property (nonatomic, weak) IBOutlet UIButton *button2;
@property (nonatomic, weak) IBOutlet UIView *myContentView;
@property (nonatomic, weak) IBOutlet UILabel *myTextLabel;
@property (nonatomic, strong) NSString *itemText;
@property (nonatomic, weak) id <SwipeableCellDelegate> delegate;

- (void)closeCell;

@end
