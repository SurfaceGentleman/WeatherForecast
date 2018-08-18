//
//  WZview.h
//  自定义View
//
//  Created by 开朗的男子 on 2018/8/14.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherTableViewCell.h"
#import "NextTableViewCell.h"
#import "DetailTableViewCell.h"
#import "SearchViewController.h"


@interface WZview : UIView
<UITableViewDelegate, UITableViewDataSource, ReturnCityNameDelegate>

@property(nonatomic, strong)UIView * squareView;



@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UILabel * lowTemperatureLabel;
@property(nonatomic, strong)UILabel * highTemperatureLabel;
@property(nonatomic, strong)UILabel * temperatureLabel;
@property(nonatomic, strong)UILabel * weatherLabel;
@property(nonatomic, strong)UILabel * dayLabel;
@property(nonatomic, strong)UILabel * weekLabel;
@property(nonatomic, strong)UILabel * placeLabel;

@property(nonatomic, strong)id ojbc;
@property(nonatomic, strong)id ojbc2;

@property(nonatomic, strong)id objcJSON;

@property(nonatomic, copy)NSArray *detailLeftArray;
@property(nonatomic, copy)NSArray *detailRightArray;
@property(nonatomic, copy)NSArray *detailMessageLeftArray;
@property(nonatomic, copy)NSArray *detailMessageRightArray;

@property(nonatomic, strong)UIView *backView;

@property(nonatomic, strong)UIImageView *backImageView;

@property(nonatomic, copy)NSString *cityName;

@property(nonatomic, strong)UIScrollView * weatherScrollerView;

- (instancetype)initWithFrame:(CGRect)frame AndName:(NSString *)name;

@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UILabel *temperatureLl;
@property(nonatomic, strong)UIImageView *weatherImageView;

@property(nonatomic, strong)NSMutableArray *timeMutableArray;

@end
