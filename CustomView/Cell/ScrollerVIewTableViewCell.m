//
//  ScrollerVIewTableViewCell.m
//  天气预报
//
//  Created by 开朗的男子 on 2018/8/14.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import "ScrollerVIewTableViewCell.h"

@implementation ScrollerVIewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _weatherScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
        _weatherScrollerView.showsHorizontalScrollIndicator = YES;
        
        [self.contentView addSubview:_weatherScrollerView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _weatherScrollerView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, 120) ;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
