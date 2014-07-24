//
//  CustomTableViewCell.m
//  tableviewDemo
//
//  Created by billy.ho on 7/15/14.
//  Copyright (c) 2014 BILLYHO. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        [self addSubview:_label];
        
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)configCell:(NSString *)content
{
    _label.text = content;
}

@end
