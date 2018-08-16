//
//  NextTableViewCell.m
//  天气预报
//
//  Created by 开朗的男子 on 2018/8/14.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import "NextTableViewCell.h"

@implementation NextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 160, 20)];
        _highTemperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(320, 10, 80, 20)];
        _lowTemperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(370, 10, 80, 20)];
        _weatherImage = [[UIImageView alloc] initWithFrame:CGRectMake(180, 10, 25, 25)];
        
        _timeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 160, 20)];
        _highTemperatureLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(320, 40, 80, 20)];
        _lowTemperatureLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(370, 40, 80, 20)];
        _weatherImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(180, 40, 25, 25)];
        
//        _timeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 180, 160, 20)];
//        _highTemperatureLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(320, 177, 80, 20)];
//        _lowTemperatureLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(370, 177, 80, 20)];
        [self.contentView addSubview:_highTemperatureLabel];
        [self.contentView addSubview:_lowTemperatureLabel];
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_weatherImage];
        
        [self.contentView addSubview:_highTemperatureLabel2];
        [self.contentView addSubview:_lowTemperatureLabel2];
        [self.contentView addSubview:_timeLabel2];
        [self.contentView addSubview:_weatherImage2];
        
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _lowTemperatureLabel.textColor = [UIColor whiteColor];
    _lowTemperatureLabel.font = [UIFont systemFontOfSize:20];
    
    _highTemperatureLabel.textColor = [UIColor whiteColor];
    _highTemperatureLabel.font = [UIFont systemFontOfSize:20];
    
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = [UIFont systemFontOfSize:20];
    
    _lowTemperatureLabel2.textColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    _lowTemperatureLabel2.font = [UIFont systemFontOfSize:20];
    
    _highTemperatureLabel2.textColor = [UIColor whiteColor];
    _highTemperatureLabel2.font = [UIFont systemFontOfSize:20];
    
    _timeLabel2.textColor = [UIColor whiteColor];
    _timeLabel2.font = [UIFont systemFontOfSize:20];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
