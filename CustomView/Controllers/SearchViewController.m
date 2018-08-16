//
//  SearchViewController.m
//  天气预报城市查询
//
//  Created by 开朗的男子 on 2018/8/14.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import "SearchViewController.h"
#import "ViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [_searchBar showsCancelButton];
}

//当search按钮被点击的时候
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 从中国天气预报网请求数据
    NSString *urlStr = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather/now?location=%@&key=4c4d76a4cec84fd5a743c46746cd3ca9", _searchBar.text];
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 在网络完成的 Block 回调中,要增加错误机制.
        // 失败机制处理: 错误的状态码!
        
        // 最简单的错误处理机制:
        if (data && !error) {
            
            // JSON格式转换成字典，IOS5中自带解析类NSJSONSerialization从response中解析出数据放到字典中
            self->_obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            NSLog(@"%@", self->_obj);
            NSLog(@"%@", self->_obj[@"HeWeather6"][0][@"status"]);
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (NO == [self->_obj[@"HeWeather6"][0][@"status"] isEqualToString:@"ok"]) {
                    //显示提示框
                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"您所查询的城市不存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction: defaultAction];
                    [self presentViewController: alert animated: YES completion:nil];
                }
                else {
                    [self.delegate getCityName:self->_searchBar.text];
                    
                    for(NSString * cityStr in self->_cityMutableArray) {
                        if (YES == [cityStr isEqualToString:self->_searchBar.text]) {
                            self->_isHaveCity = YES;
                            break;
                        }
                        else {
                            self->_isHaveCity = NO;
                        }
                    }
                    if (self->_isHaveCity == NO) {
                        [self.cityMutableArray addObject:self->_searchBar.text];
                    }
                    
                    ViewController *viewController = [[ViewController alloc] initWithCityMutableArray:self->_cityMutableArray];
                    [self presentViewController:viewController animated:YES completion:nil];
                }
            });
        }
        
    }];
    [dataTask resume];
    
//    NSLog(@"%@", _isHaveCity);
    
//    if (_isHaveCity) {
//        //显示提示框
//        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"您所查询的城市不存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
//        [alert addAction: defaultAction];
//        [self presentViewController: alert animated: YES completion:nil];
//    }
    //[self dismissViewControllerAnimated:YES completion:nil];
}


- (id)initWithCityMutableArray:(NSMutableArray *)cityMuArray
{
    if (self = [super init]) {
        _cityMutableArray = [cityMuArray mutableCopy];
    }
    return self;
}


//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self.textName resignFirstResponder];
    //[self.textSummary resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
