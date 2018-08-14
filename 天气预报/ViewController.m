//
//  ViewController.m
//  天气预报
//
//  Created by 开朗的男子 on 2018/8/13.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import "ViewController.h"
#import "WeatherTableViewCell.h"
#import "NextTableViewCell.h"
#import "DetailTableViewCell.h"
#import "ScrollerVIewTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _backView = [[UIView alloc] initWithFrame:self.view.frame];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    
//    //添加标签
//
//    _temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 60, 95, 160, 80)];
//    //_temperatureLabel.text = _ojbc[@"HeWeather6"][0][@"now"][@"fl"];
//    _temperatureLabel.textColor = [UIColor whiteColor];
//    _temperatureLabel.font = [UIFont systemFontOfSize:90];
//    [self.view addSubview:_temperatureLabel];
//
//    _weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 120, 30)];
//    _weekLabel.textColor = [UIColor whiteColor];
//    _weekLabel.text = @"星期一";
//    _weekLabel.font = [UIFont systemFontOfSize:20];
//    //[self.view addSubview:_weekLabel];
//
//    _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 45, 10, 160, 80)];
//    _placeLabel.textColor = [UIColor whiteColor];
//    _placeLabel.text = @"北京市";
//    _placeLabel.font = [UIFont systemFontOfSize:30];
//    [self.view addSubview:_placeLabel];
//
//    _weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 20, 45, 160, 80)];
//    _weatherLabel.text = @"晴天";
//    _weatherLabel.textColor = [UIColor whiteColor];
//    _weatherLabel.font = [UIFont systemFontOfSize:17];
//    [self.view addSubview:_weatherLabel];
//
//    _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 180, 160, 20)];
//    _dayLabel.textColor = [UIColor whiteColor];
//    [self.view addSubview:_dayLabel];
//
//    _highTemperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(320, 177, 80, 20)];
//    _highTemperatureLabel.textColor = [UIColor whiteColor];
//    _highTemperatureLabel.text = @"36";
//    _highTemperatureLabel.font = [UIFont systemFontOfSize:20];
//    [self.view addSubview:_highTemperatureLabel];
//
//    _lowTemperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(370, 177, 80, 20)];
//    _lowTemperatureLabel.textColor = [UIColor colorWithRed:0.57 green:0.76 blue:0.94 alpha:1.00];
//    _lowTemperatureLabel.text = @"26";
//    _lowTemperatureLabel.font = [UIFont systemFontOfSize:20];
//    [self.view addSubview:_lowTemperatureLabel];
//
    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.60 blue:0.79 alpha:1.00];
    
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3fe28f8bd934629a8f7f968727261aed.jpg"]];
    backgroundImageView.frame = self.view.frame;
    [_backView addSubview:backgroundImageView];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[WeatherTableViewCell class] forCellReuseIdentifier:@"ID"];
    
    [_backView addSubview:_tableView];
    
    //获取网络请求
    NSURL *urlToday = [NSURL URLWithString:@"https://free-api.heweather.com/s6/weather/now?location=CN101110906&key=4c4d76a4cec84fd5a743c46746cd3ca9"];
    NSURL *urlTomorrow = [NSURL URLWithString:@"https://free-api.heweather.com/s6/weather/forecast?location=CN101110906&key=4c4d76a4cec84fd5a743c46746cd3ca9"];
    //创建请求
    NSURLRequest *todayRequest = [NSURLRequest requestWithURL:urlToday];
    NSURLRequest *tomorrowRequest = [NSURLRequest requestWithURL:urlTomorrow];
    
    NSURLSessionDataTask *dataTask1 = [[NSURLSession sharedSession] dataTaskWithRequest:todayRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 最简单的错误处理机制:
        if (data && !error) {
            
            // JSON格式转换成字典，IOS5中自带解析类NSJSONSerialization从response中解析出数据放到字典中
            self->_ojbc = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];

        });
        
        NSLog(@"%@", self->_ojbc[@"HeWeather6"][0][@"now"][@"fl"]);
    }];
    [dataTask1 resume];
    
    NSURLSessionDataTask *dataTask2 = [[NSURLSession sharedSession] dataTaskWithRequest:tomorrowRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 最简单的错误处理机制:
        if (data && !error) {
            
            // JSON格式转换成字典，IOS5中自带解析类NSJSONSerialization从response中解析出数据放到字典中
            self->_ojbc2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self creatDetailLabelTextAndMessageText];
        });
        
        NSLog(@"%@", self->_ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_min"]);
        NSLog(@"%@", self->_ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"sr"]);
    }];
    [dataTask2 resume];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 208;
    }
    else if (indexPath.section == 1) {
        return 120;
    }
    else if (indexPath.section == 2) {
        return 70;
    }
    else if (indexPath.section == 3) {
        return 50;
    }
    else {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WeatherTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    ScrollerVIewTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
    NextTableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"ID2"];
    UITableViewCell * cell3 = [tableView dequeueReusableCellWithIdentifier:@"ID3"];
    DetailTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"ID4"];
    
    
    if (indexPath.section == 0) {
        if (cell == nil) {
            cell = [[WeatherTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
        }
        cell.temperatureLabel.text = self->_ojbc[@"HeWeather6"][0][@"now"][@"tmp"];
        cell.weatherLabel.text = self->_ojbc[@"HeWeather6"][0][@"now"][@"cond_txt"];
        cell.placeLabel.text = self->_ojbc[@"HeWeather6"][0][@"basic"][@"location"];
        cell.dayLabel.text = self->_ojbc[@"HeWeather6"][0][@"update"][@"loc"];
        cell.highTemperatureLabel.text = _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_max"];
        cell.lowTemperatureLabel.text = _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_min"];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else if (indexPath.section == 1) {
        if (cell1 == nil) {
            cell1 = [[ScrollerVIewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID1"];
        }
        cell1.backgroundColor = [UIColor clearColor];
        return cell1;
    }
    else if (indexPath.section == 2) {
        if (cell2 == nil) {
            cell2 = [[NextTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID2"];
        }
        cell2.timeLabel.text = @"明天";
        cell2.highTemperatureLabel.text = _ojbc2[@"HeWeather6"][0][@"daily_forecast"][1][@"tmp_max"];
        cell2.lowTemperatureLabel.text = _ojbc2[@"HeWeather6"][0][@"daily_forecast"][1][@"tmp_min"];
        cell2.weatherImage.image = [UIImage imageNamed:_ojbc2[@"HeWeather6"][0][@"daily_forecast"][1][@"cond_code_d"]];
        cell2.timeLabel2.text = @"后天";
        cell2.highTemperatureLabel2.text = _ojbc2[@"HeWeather6"][0][@"daily_forecast"][2][@"tmp_max"];
        cell2.lowTemperatureLabel2.text = _ojbc2[@"HeWeather6"][0][@"daily_forecast"][2][@"tmp_min"];
        cell2.weatherImage2.image = [UIImage imageNamed:_ojbc2[@"HeWeather6"][0][@"daily_forecast"][2][@"cond_code_d"]];
        cell2.backgroundColor = [UIColor clearColor];
        
        return cell2;
    }
    else if (indexPath.section == 3) {
        NSString *datail = [NSString stringWithFormat:@"今天:当前%@。气温%@度；最高气温 %@度", self->_ojbc[@"HeWeather6"][0][@"now"][@"cond_txt"], self->_ojbc[@"HeWeather6"][0][@"now"][@"fl"], _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_max"]];
        if(cell3 == nil) {
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID3"];
        }
        cell3.textLabel.text = datail;
        cell3.textLabel.textColor = [UIColor whiteColor];
        cell3.textLabel.font = [UIFont systemFontOfSize:18];
        cell3.backgroundColor = [UIColor clearColor];
        return cell3;
    }
    else {
        if (cell4 == nil) {
            cell4 = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID4"];
        }
        cell4.leftLabel.text = _detailLeftArray[indexPath.section - 0];
        cell4.rightLabel.text = _detailRightArray[indexPath.section - 0];
        cell4.leftMesssageLabel.text = _detailMessageLeftArray[indexPath.section - 0];
        cell4.rightMessageLabel.text = _detailMessageRightArray[indexPath.section - 0];
        
        cell4.backgroundColor = [UIColor clearColor];
        return cell4;
    }
    //cell.dayLabel.text = @"1";
    //return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)creatDetailLabelTextAndMessageText
{
    _detailLeftArray = @[@" ", @" ", @" ", @" ", @"日出", @"降雨概率", @"风速", @"降水量", @"能见度", @"空气质量指数"];
    _detailRightArray = @[@" ", @" ", @" ", @" ", @"日落", @"湿度", @"体感温度", @"气压", @"紫外线指数", @"空气质量"];
    
    
    _detailMessageLeftArray = @[@" ", @" ", @" ", @" ", _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"sr"], _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"pop"], _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"wind_spd"], _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"pcpn"], _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"vis"], @" "];
    _detailMessageRightArray = @[@" ", @" ", @" ", @" ", _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"ss"], _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"hum"], _ojbc[@"HeWeather6"][0][@"now"][@"fl"], _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"pres"], _ojbc2[@"HeWeather6"][0][@"daily_forecast"][0][@"uv_index"], @" "];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
