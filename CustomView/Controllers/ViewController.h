//
//  ViewController.h
//  自定义View
//
//  Created by 开朗的男子 on 2018/8/14.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property(nonatomic, strong)UIView *buttomView;
@property(nonatomic, strong)UIButton *buttomButton;


@property(nonatomic, copy)NSString *cityName;

@property(nonatomic, copy)NSMutableArray *cityMutableArray;

- (id) initWithCityName:(NSString *)name;

@end

