//
//  ResizeCell.m
//  AutoResizeCell
//
//  Created by BILLY HO on 12/29/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "ResizeCell.h"

@interface ResizeCell ()

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *timeStampLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *cellImageView;

@end

@implementation ResizeCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		self.avatarImageView = [[UIImageView alloc] init];
		[self.contentView addSubview:self.avatarImageView];
		
		self.timeStampLabel = [[UILabel alloc] init];
		[self.contentView addSubview:self.timeStampLabel];
		
		self.contentLabel = [[UILabel alloc] init];
		[self.contentLabel setBackgroundColor:[UIColor lightGrayColor]];
		[self.contentView addSubview:self.contentLabel];
		
		self.cellImageView = [[UIImageView alloc] init];
		[self.contentView addSubview:self.cellImageView];
		
		int padding = 10;
		UIView *superview = self.contentView;
		[self.avatarImageView makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(superview).with.offset(padding);
			make.left.equalTo(superview).with.offset(padding);
			make.width.equalTo(@(40));
			make.height.equalTo(@(40));
		}];
		
		[self.timeStampLabel makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(superview).with.offset(padding);
			make.left.equalTo(self.avatarImageView.right).with.offset(padding);
			make.bottom.equalTo(self.contentView.top).with.offset(-padding);
			make.right.equalTo(superview).with.offset(-padding);
			make.height.equalTo(self.avatarImageView.height);
		}];
		
		[self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.timeStampLabel.bottom).with.offset(padding);
			make.left.equalTo(superview).with.offset(padding);
			make.bottom.equalTo(self.cellImageView.top).with.offset(-padding);
			make.right.equalTo(superview).with.offset(-padding);
		}];
		
		[self.cellImageView makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(superview).with.offset(padding);
			make.bottom.equalTo(superview).with.offset(-padding);
		}];
		
	}
	return self;
}


- (void)configCellWithText:(NSString *)text pic:(BOOL)flag
{
	self.avatarImageView.image = [UIImage imageNamed:@"H-9.jpg"];
	self.timeStampLabel.text = [NSString stringWithFormat:@"%@",[NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle]];
	
	self.contentLabel.text = text;
	self.contentLabel.numberOfLines = 0;
	
	CGRect textsize = [self.contentLabel textRectForBounds:CGRectMake(0, 0, self.frame.size.width - 20, CGFLOAT_MAX) limitedToNumberOfLines:0];
	
	
	[self.contentLabel updateConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(@(textsize.size.height));
	}];
	
	if (flag)
	{
		self.cellImageView.image = [UIImage imageNamed:@"H-9.jpg"];
		[self.cellImageView updateConstraints:^(MASConstraintMaker *make) {
			make.width.equalTo(@(150));
			make.height.equalTo(@(100));
		}];
	}
	else
	{
		self.cellImageView.image = nil;
		[self.cellImageView updateConstraints:^(MASConstraintMaker *make) {
			make.width.equalTo(@(0));
			make.height.equalTo(@(0));
		}];
	}

}


@end
