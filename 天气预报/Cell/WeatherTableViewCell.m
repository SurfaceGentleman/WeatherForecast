//
//  WeatherTableViewCell.m
//  天气预报
//
//  Created by 开朗的男子 on 2018/8/13.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import "WeatherTableViewCell.h"

@implementation WeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.viewForLastBaselineLayout.frame.size.width / 2 - 0, 100, 160, 80)];
        _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.viewForLastBaselineLayout.frame.size.width / 2 + 20, 10, 160, 80)];
        _weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.viewForLastBaselineLayout.frame.size.width / 2 + 40, 45, 160, 80)];
        _weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.viewForLastBaselineLayout.frame.size.width / 2 - 20, 30, 80, 30)];
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 160, 20)];
        _highTemperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(320, 177, 80, 20)];
        _lowTemperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(370, 177, 80, 20)];
        
        [self.contentView addSubview:_placeLabel];
        [self.contentView addSubview:_weekLabel];
        [self.contentView addSubview:_dayLabel];
        [self.contentView addSubview:_highTemperatureLabel];
        [self.contentView addSubview:_weatherLabel];
        [self.contentView addSubview:_lowTemperatureLabel];
        [self.contentView addSubview:_temperatureLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _lowTemperatureLabel.textColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    _lowTemperatureLabel.font = [UIFont systemFontOfSize:20];
    
    _highTemperatureLabel.textColor = [UIColor whiteColor];
    _highTemperatureLabel.font = [UIFont systemFontOfSize:20];
    
    _placeLabel.textColor = [UIColor whiteColor];
    _placeLabel.font = [UIFont systemFontOfSize:30];
    
    _dayLabel.textColor = [UIColor whiteColor];
    
    _weekLabel.textColor = [UIColor whiteColor];
    _weekLabel.font = [UIFont systemFontOfSize:20];
    
    _weatherLabel.textColor = [UIColor whiteColor];
    _weatherLabel.font = [UIFont systemFontOfSize:17];
    
    _temperatureLabel.textColor = [UIColor whiteColor];
    _temperatureLabel.font = [UIFont systemFontOfSize:90];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
