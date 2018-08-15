//
//  DetailTableViewCell.h
//  天气预报
//
//  Created by 开朗的男子 on 2018/8/14.
//  Copyright © 2018年 开朗的男子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *leftLabel;
@property(nonatomic, strong)UILabel *rightLabel;
@property(nonatomic, strong)UILabel *leftMesssageLabel;
@property(nonatomic, strong)UILabel *rightMessageLabel;

@end
