//
//  DetailTableViewCell.m
//  天气预报
//
//  Created by 开朗的男子 on 2018/8/14.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 90, 20)];
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 0, 90, 20)];
        
        _leftMesssageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 200, 50)];
        _rightMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 15, 200, 50)];
        
        [self.contentView addSubview:_leftLabel];
        [self.contentView addSubview:_rightLabel];
        [self.contentView addSubview:_leftMesssageLabel];
        [self.contentView addSubview:_rightMessageLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _leftLabel.font = [UIFont systemFontOfSize:10];
    _rightLabel.font = [UIFont systemFontOfSize:10];
    _leftMesssageLabel.font = [UIFont systemFontOfSize:30];
    _rightMessageLabel.font = [UIFont systemFontOfSize:30];
    
    _leftLabel.textColor = [UIColor whiteColor];
    _rightLabel.textColor = [UIColor whiteColor];
    _leftMesssageLabel.textColor = [UIColor whiteColor];
    _rightMessageLabel.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
