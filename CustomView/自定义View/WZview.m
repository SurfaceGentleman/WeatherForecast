//
//  WZview.m
//  自定义View
//
//  Created by 开朗的男子 on 2018/8/14.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import "WZview.h"

@implementation WZview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame AndName:(NSString *)name
{
    _cityName = name;
    
    if (_cityName == nil) {
        _cityName = @"北京";
    }
    
    NSLog(@"VIew:%@", _cityName);
    
    
    
    
    if (self = [super initWithFrame:frame]) {
        //_squareView = [UIView new];
        //_squareView.backgroundColor = [UIColor redColor];
        //[self addSubview:_squareView];
        
        //_backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3fe28f8bd934629a8f7f968727261aed.jpg"]];
        
        //[self addSubview:_backImageView];
        
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        //[_tableView registerClass:[WeatherTableViewCell class] forCellReuseIdentifier:@"ID"];
        
        
        _weatherScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
        _weatherScrollerView.showsHorizontalScrollIndicator = YES;
        _weatherScrollerView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, 120) ;
        for (int i = 0; i < 24; i++) {
//            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake((1/8.0 *i* [UIScreen mainScreen].bounds.size.width +8), 4, [UIScreen mainScreen].bounds.size.width * 1/8, 20)];
//            //NSLog(@"%@", _timeArray[i]);
//
////           dispatch_sync(dispatch_get_main_queue(), ^{
//                _timeLabel.text = _ojbc[@"hourly"][i][@"time"];
////            });
//
//
//            _timeLabel.textColor = [UIColor whiteColor];
//            [_weatherScrollerView addSubview:_timeLabel];
//
//            _temperatureLl = [[UILabel alloc] initWithFrame:CGRectMake((1/8.0 *i* [UIScreen mainScreen].bounds.size.width +8), 90, [UIScreen mainScreen].bounds.size.width * 1/8, 20)];
//
//            _temperatureLl.text = _ojbc[@"hourly"][i][@"time"];
//            [_weatherScrollerView addSubview:_temperatureLl];
//
//            _temperatureLl.textColor = [UIColor whiteColor];
//
//
//            _weatherImageView = [[UIImageView alloc] initWithFrame:CGRectMake((1/8.0 *i* [UIScreen mainScreen].bounds.size.width ), 35, [UIScreen mainScreen].bounds.size.width * 1/8, 45)];
//            _weatherImageView.image = [UIImage imageNamed:@"100"];
//            [_weatherScrollerView addSubview:_weatherImageView];
        }
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 处理耗时操作的代码块...
            
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *urlAllStr = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=4c4d76a4cec84fd5a743c46746cd3ca9", self->_cityName];
                
                NSURL *allArl = [NSURL URLWithString:[urlAllStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                //创建请求
                NSURLRequest *allRequest = [NSURLRequest requestWithURL:allArl];
                
                NSURLSessionDataTask *dataTaskMain = [[NSURLSession sharedSession] dataTaskWithRequest:allRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    // 最简单的错误处理机制:
                    if (data && !error) {
                        
                        // JSON格式转换成字典，IOS5中自带解析类NSJSONSerialization从response中解析出数据放到字典中
                        self->_objcJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                        //[self.tableView reloadData];
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                            [self creatDetailLabelTextAndMessageText];
                        });
                        
                    }
                    
                    
                    NSLog(@"%@", self->_objcJSON[@"HeWeather6"][0][@"now"][@"fl"]);
                }];
                [dataTaskMain resume];
                
                NSString *urlStr = [NSString stringWithFormat:@"http://api.jisuapi.com/weather/query?appkey=42a1b7d9c0d97c88&city=安顺"];
                NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    
                    // 在网络完成的 Block 回调中,要增加错误机制.
                    // 失败机制处理: 错误的状态码!
                    
                    // 最简单的错误处理机制:
                    if (data && !error) {
                        
                        // JSON格式转换成字典，IOS5中自带解析类NSJSONSerialization从response中解析出数据放到字典中
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            self->_ojbc = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                            self->_timeMutableArray = [NSMutableArray new];
                            for (int i = 0; i < 24; i++) {
                                self->_timeLabel = [[UILabel alloc] initWithFrame:CGRectMake((1/8.0 *i* [UIScreen mainScreen].bounds.size.width +8), 4, [UIScreen mainScreen].bounds.size.width * 1/8, 20)];
                                //NSLog(@"%@", _timeArray[i]);
                                
                                //           dispatch_sync(dispatch_get_main_queue(), ^{
                                self->_timeLabel.text = self->_ojbc[@"result"][@"hourly"][i][@"time"];
                                //            });
                                
                                
                                self->_timeLabel.textColor = [UIColor whiteColor];
                                [self->_weatherScrollerView addSubview:self->_timeLabel];
                                
                                self->_temperatureLl = [[UILabel alloc] initWithFrame:CGRectMake((1/8.0 *i* [UIScreen mainScreen].bounds.size.width +17), 90, [UIScreen mainScreen].bounds.size.width * 1/8, 20)];
                                
                                self->_temperatureLl.text = self->_ojbc[@"result"][@"hourly"][i][@"temp"];
                                [self->_weatherScrollerView addSubview:self->_temperatureLl];
                                
                                self->_temperatureLl.textColor = [UIColor whiteColor];
                                
                                
                                self->_weatherImageView = [[UIImageView alloc] initWithFrame:CGRectMake((1/8.0 *i* [UIScreen mainScreen].bounds.size.width + 15), 40, 30, 30)];
                                self->_weatherImageView.image = [UIImage imageNamed:self->_ojbc[@"result"][@"hourly"][i][@"img"]];
                                [self->_weatherScrollerView addSubview:self->_weatherImageView];
                            }
                            NSLog(@"%@", self->_ojbc);
                        });
                        
                        //NSLog(@"%@", obj[@"HeWeather6"][0][@"status"]);
                        
                        //NSLog(@"%@---%@", dict, dict[@"njd"]);
                    }
                    
                }];
                [dataTask resume];

            });
            
        });
        
        
        _squareView.frame = CGRectMake(0, 0, 100, 100);
        
        _backImageView.frame = self.frame;
        
        
        [self addSubview:_tableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    _squareView.frame = CGRectMake(0, 0, 100, 100);
//    
    _backImageView.frame = self.frame;
//    
    _tableView.frame = [UIScreen mainScreen].bounds;

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        WeatherTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (cell == nil) {
            cell = [[WeatherTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
        }
        cell.temperatureLabel.text = self->_objcJSON[@"HeWeather6"][0][@"now"][@"tmp"];
        cell.weatherLabel.text = self->_objcJSON[@"HeWeather6"][0][@"now"][@"cond_txt"];
        cell.placeLabel.text = self->_objcJSON[@"HeWeather6"][0][@"basic"][@"location"];
        cell.dayLabel.text = self->_ojbc[@"result"][@"daily"][0][@"date"];
        cell.highTemperatureLabel.text = _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_max"];
        cell.lowTemperatureLabel.text = _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_min"];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else if (indexPath.section == 1) {
//        ScrollerVIewTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID1"];
            //NSLog(@"_ojbc = %@", _ojbc);
        }
        [cell1.contentView addSubview:_weatherScrollerView];
        cell1.backgroundColor = [UIColor clearColor];
        return cell1;
    }
    else if (indexPath.section == 2) {
        NextTableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"ID2"];
        if (cell2 == nil) {
            cell2 = [[NextTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID2"];
        }
        cell2.timeLabel.text = self->_ojbc[@"result"][@"daily"][1][@"week"];
        cell2.highTemperatureLabel.text = _objcJSON[@"HeWeather6"][0][@"daily_forecast"][1][@"tmp_max"];
        cell2.lowTemperatureLabel.text = _objcJSON[@"HeWeather6"][0][@"daily_forecast"][1][@"tmp_min"];
        cell2.weatherImage.image = [UIImage imageNamed:_objcJSON[@"HeWeather6"][0][@"daily_forecast"][1][@"cond_code_d"]];
        cell2.timeLabel2.text = self->_ojbc[@"result"][@"daily"][2][@"week"];
        cell2.highTemperatureLabel2.text = _objcJSON[@"HeWeather6"][0][@"daily_forecast"][2][@"tmp_max"];
        cell2.lowTemperatureLabel2.text = _objcJSON[@"HeWeather6"][0][@"daily_forecast"][2][@"tmp_min"];
        cell2.weatherImage2.image = [UIImage imageNamed:_objcJSON[@"HeWeather6"][0][@"daily_forecast"][2][@"cond_code_d"]];
        cell2.backgroundColor = [UIColor clearColor];
        
        return cell2;
    }
    else if (indexPath.section == 3) {
        UITableViewCell * cell3 = [tableView dequeueReusableCellWithIdentifier:@"ID3"];
        NSString *datail = [NSString stringWithFormat:@"今天:当前%@。气温%@度；最高气温 %@度", self->_objcJSON[@"HeWeather6"][0][@"now"][@"cond_txt"], self->_objcJSON[@"HeWeather6"][0][@"now"][@"fl"], _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_max"]];
        if(cell3 == nil) {
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID3"];
        }
        cell3.textLabel.text = datail;
        cell3.textLabel.textColor = [UIColor whiteColor];
        cell3.textLabel.font = [UIFont systemFontOfSize:18];
        cell3.backgroundColor = [UIColor clearColor];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell3;
    }
    else {
        DetailTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"ID4"];
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

- (void)creatDetailLabelTextAndMessageText
{
    _detailLeftArray = @[@" ", @" ", @" ", @" ", @"日出", @"降雨概率", @"风速", @"降水量", @"能见度", @"空气质量指数"];
    _detailRightArray = @[@" ", @" ", @" ", @" ", @"日落", @"湿度", @"体感温度", @"气压", @"紫外线指数", @"空气质量"];
    
    if (_objcJSON[@"HeWeather6"][0][@"daily_forecast"][0]) {
        _detailMessageLeftArray = @[@" ", @" ", @" ", @" ", _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"sr"], _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"pop"], _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"wind_spd"], _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"pcpn"], _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"vis"], @" "];
        _detailMessageRightArray = @[@" ", @" ", @" ", @" ", _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"ss"], _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"hum"], _objcJSON[@"HeWeather6"][0][@"now"][@"fl"], _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"pres"], _objcJSON[@"HeWeather6"][0][@"daily_forecast"][0][@"uv_index"], @" "];
    }
    else {
        _detailMessageLeftArray = @[@" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" "];
        _detailMessageRightArray = @[@" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" ", @" "];
    }
    
    
}

- (void)getCityName:(NSString *)searchText
{
    self.cityName = searchText;
    NSLog(@"wzView代理");
}

@end
