//
//  SearchViewController.h
//  天气预报城市查询
//
//  Created by 开朗的男子 on 2018/8/14.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置传参代理
@protocol ReturnCityNameDelegate

@required

- (void) getCityName:(NSString *)searchText;

@end

@interface SearchViewController : UIViewController
<UISearchBarDelegate>

@property(nonatomic, strong)UISearchBar *searchBar;
@property(nonatomic, strong)id obj;

@property(nonatomic, assign)BOOL isHaveCity;

@property(nonatomic, weak)NSObject <ReturnCityNameDelegate> *delegate;

@end
