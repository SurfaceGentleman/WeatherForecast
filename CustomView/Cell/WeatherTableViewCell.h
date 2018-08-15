//
//  WeatherTableViewCell.h
//  天气预报
//
//  Created by 开朗的男子 on 2018/8/13.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel * lowTemperatureLabel;
@property(nonatomic, strong)UILabel * highTemperatureLabel;
@property(nonatomic, strong)UILabel * temperatureLabel;
@property(nonatomic, strong)UILabel * weatherLabel;
@property(nonatomic, strong)UILabel * dayLabel;
@property(nonatomic, strong)UILabel * weekLabel;
@property(nonatomic, strong)UILabel * placeLabel;

@end
