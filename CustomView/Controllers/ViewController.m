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
<ReturnCityNameDelegate, UIScrollViewDelegate>

@end

@implementation ViewController

- (id)initWithCityName:(NSString *)name
{
    if (self = [super init]) {
        _cityName = name;
        _cityMutableArray = [NSMutableArray new];
        [_cityMutableArray addObject:@"宝鸡"];
        [_cityMutableArray addObject:_cityName];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (_cityMutableArray == nil) {
        _cityMutableArray = [NSMutableArray new];
        [_cityMutableArray addObject:@"宝鸡"];
    }
    
    
    
    _mainScreenScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _mainScreenScrollerView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * [_cityMutableArray count], [UIScreen mainScreen].bounds.size.height);
    _mainScreenScrollerView.pagingEnabled = YES;
    _mainScreenScrollerView.bounces = NO;
    _mainScreenScrollerView.delegate = self;
    
    for (int i = 0; i < [_cityMutableArray count]; i++) {
        int j = i + 1;
        if (i + 1 > 3) {
            j %= 3;
        }
        NSString *imageStr = [NSString stringWithFormat:@"0%d.jpg", j];
        
        _backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageStr]];
        _backImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [_mainScreenScrollerView addSubview:_backImageView];
        
        WZview *wzview = [[WZview alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) AndName:_cityMutableArray[i]];
        [_mainScreenScrollerView addSubview:wzview];
        
        
    }
    
    _mainScreenScrollerView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_mainScreenScrollerView];
//    WZview *wzview = [[WZview alloc] initWithFrame:self.view.frame AndName:_cityName];
//    wzview.frame = self.view.frame;
//
//    NSLog(@"wz:%@", wzview.cityName);
//
//    [self.view addSubview:wzview];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    _buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    _buttomView.backgroundColor = [UIColor blackColor];
    _buttomView.alpha = 0.5;
    [self.view addSubview:_buttomView];
    
    _buttomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttomButton.frame = CGRectMake(370, 3, 35, 35);
    [_buttomButton setImage:[UIImage imageNamed:@"按钮"] forState:normal
     ];
    [_buttomButton addTarget:self action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];
    [_buttomView addSubview:_buttomButton];
    
    _weatherPageControl = [UIPageControl new];
    _weatherPageControl.alpha = 1.5;
    _weatherPageControl.frame = CGRectMake(60, 5, 280, 30);
    _weatherPageControl.numberOfPages = [_cityMutableArray count];
    _weatherPageControl.currentPage = [_cityMutableArray count];
    _weatherPageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _weatherPageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [_weatherPageControl addTarget:self action:@selector(changeScrollerVIew) forControlEvents:UIControlEventValueChanged];
    [_buttomView addSubview:_weatherPageControl];
    
    
    NSInteger  page = _weatherPageControl.currentPage ;
    _mainScreenScrollerView.contentOffset = CGPointMake(self.view.frame.size.width * page, 0);
}

- (void)clickToSearch
{
    SearchViewController *searchViewController = [[SearchViewController alloc] initWithCityMutableArray:_cityMutableArray];
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

- (id)initWithCityMutableArray:(NSMutableArray *)cityMuArray
{
    if (self = [super init]) {
        _cityMutableArray = [cityMuArray mutableCopy];
    }
    return self;
}

- (void)changeScrollerVIew
{
    NSInteger  page = _weatherPageControl.currentPage ;
    _mainScreenScrollerView.contentOffset = CGPointMake(self.view.frame.size.width * page, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / CGRectGetWidth(self.view.frame);
    _weatherPageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
