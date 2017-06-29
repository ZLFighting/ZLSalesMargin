//
//  YYPSalesMarginCell.h
//  YYPAppointment
//
//  Created by ZL on 2017/6/29.
//  Copyright © 2017年 zhangli. All rights reserved.
//  销售毛利 cell

#import <UIKit/UIKit.h>
@class YYPSalesMarginModel;


#define YYPSalesMarginCellHeight  60.0

@interface YYPSalesMarginCell : UITableViewCell

@property (strong, nonatomic) YYPSalesMarginModel *model;

// 创建并返回cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
