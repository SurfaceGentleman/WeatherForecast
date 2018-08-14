//
//  ViewController.h
//  天气预报
//
//  Created by 开朗的男子 on 2018/8/13.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

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

@property(nonatomic, copy)NSArray *detailLeftArray;
@property(nonatomic, copy)NSArray *detailRightArray;
@property(nonatomic, copy)NSArray *detailMessageLeftArray;
@property(nonatomic, copy)NSArray *detailMessageRightArray;

@property(nonatomic, strong)UIView *backView;

@end

