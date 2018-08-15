//
//  ViewController.m
//  自定义View
//
//  Created by 开朗的男子 on 2018/8/14.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import "ViewController.h"
#import "WZview.h"
#import "SearchViewController.h"

@interface ViewController ()
<ReturnCityNameDelegate>

@end

@implementation ViewController

- (id)initWithCityName:(NSString *)name
{
    if (self = [super init]) {
        _cityName = name;
        _cityMutableArray = [NSMutableArray new];
        [_cityMutableArray addObject:@"西安"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (_cityName == nil) {
        _cityName = @"株洲";
    }
    
    WZview *wzview = [[WZview alloc] initWithFrame:self.view.frame AndName:_cityName];
    wzview.frame = self.view.frame;
    
    //[wzview creatCityName:_cityName];
    
    //wzview.cityName = _cityName;
    
    NSLog(@"wz:%@", wzview.cityName);
    
    [self.view addSubview:wzview];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    _buttomView.backgroundColor = [UIColor colorWithRed:0.13 green:0.60 blue:0.79 alpha:1.00];
    _buttomView.alpha = 0.5;
    [self.view addSubview:_buttomView];
    
    _buttomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttomButton.frame = CGRectMake(370, 3, 35, 35);
    [_buttomButton setImage:[UIImage imageNamed:@"按钮"] forState:normal
     ];
    [_buttomButton addTarget:self action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];
    [_buttomView addSubview:_buttomButton];
}

- (void)clickToSearch
{
    SearchViewController *searchViewController = [SearchViewController new];
    searchViewController.delegate = self;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self presentViewController:searchViewController animated:YES completion:nil];
}

- (void)getCityName:(NSString *)searchText
{
    _cityName = [searchText copy];
    NSLog(@"%@", _cityName);
    NSLog(@"代理已执行");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
