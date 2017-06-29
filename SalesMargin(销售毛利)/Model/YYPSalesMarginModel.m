//
//  YYPSalesMarginModel.m
//  YYPAppointment
//
//  Created by ZL on 2017/6/29.
//  Copyright © 2017年 zhangli. All rights reserved.
//

#import "YYPSalesMarginModel.h"

@implementation YYPSalesMarginModel

+ (NSArray *)loadSalesMarginInfoFromJson:(NSArray *)array{
    
    return [self objectArrayWithKeyValuesArray:array].copy;
}

@end
