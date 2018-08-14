//
//  NextTableViewCell.h
//  天气预报
//
//  Created by 开朗的男子 on 2018/8/14.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)UILabel * lowTemperatureLabel;
@property(nonatomic, strong)UILabel * highTemperatureLabel;
@property(nonatomic, strong)UIImageView * weatherImage;

@property(nonatomic, strong)UILabel * timeLabel2;
@property(nonatomic, strong)UILabel * lowTemperatureLabel2;
@property(nonatomic, strong)UILabel * highTemperatureLabel2;
@property(nonatomic, strong)UIImageView * weatherImage2;

@end
