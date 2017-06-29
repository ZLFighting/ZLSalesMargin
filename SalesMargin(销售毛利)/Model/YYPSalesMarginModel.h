//
//  YYPSalesMarginModel.h
//  YYPAppointment
//
//  Created by ZL on 2017/6/29.
//  Copyright © 2017年 zhangli. All rights reserved.
//  销售毛利

#import <Foundation/Foundation.h>

@interface YYPSalesMarginModel : NSObject

// id标识
@property (nonatomic, copy) NSString *id;

// 商品系列名称
@property (nonatomic, copy) NSString *name;

// 销售额
@property (nonatomic, assign) float sale;

// 毛利
@property (nonatomic, assign) float grossProfit;

// 毛利率
@property (nonatomic, assign) float percent;


+ (NSArray *)loadSalesMarginInfoFromJson:(NSArray *)array;

@end
