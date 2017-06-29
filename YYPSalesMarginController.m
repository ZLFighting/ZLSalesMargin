//
//  YYPSalesMarginController.m
//  YYPAppointment
//
//  Created by ZL on 2017/6/28.
//  Copyright © 2017年 zhangli. All rights reserved.
//

#import "YYPSalesMarginController.h"

#define YYPColor(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define UI_View_Width [UIScreen mainScreen].bounds.size.width//屏幕宽度

@interface YYPSalesMarginController ()

@end

@implementation YYPSalesMarginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YYPBackgroundColor;
    self.navigationItem.title = @"销售毛利";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    
//    [self loadData];
}

- (void)loadData{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *CellIdentifier = @"cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        } else {
            for(UIView *view in cell.contentView.subviews) {
                [view removeFromSuperview];
            }
        }
        NSArray *nameArr = @[@"商品销售额",@"商品销售毛利",@"毛利率"];
        NSArray *valueArr = @[@"￥311.00",@"￥143.00",@"46.11%"];
        NSInteger count = nameArr.count;
        
        for (int i=0; i<count; i++) { // 利用两个标签创建
            UIView *backView = [[UIView alloc] init];
            backView.frame = CGRectMake(i*UI_View_Width/count, 30, UI_View_Width/count, 40);
            [cell.contentView addSubview:backView];
            
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.frame = CGRectMake(0, 0, UI_View_Width/count, 20);
            nameLabel.font = [UIFont systemFontOfSize:14];
            nameLabel.textColor = YYPColor(52, 53, 54);
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.text = nameArr[i];
            [backView addSubview:nameLabel];
            
            UILabel *valueLabel = [[UILabel alloc] init];
            valueLabel.frame = CGRectMake(0, 20, UI_View_Width/count, 20);
            valueLabel.font = [UIFont systemFontOfSize:16];
            valueLabel.textColor = YYPColor(255, 45, 77);
            valueLabel.textAlignment = NSTextAlignmentCenter;
            valueLabel.text = valueArr[i];
            [backView addSubview:valueLabel];
            
            if (i > 0) {
                UIView *line = [[UIView alloc] init];
                line.frame = CGRectMake(0, 0, 0.5, 40);
                line.backgroundColor = YYPColor(200, 200, 200);
                [backView addSubview:line];
            }
        }
        return cell;
        
    } else if (indexPath.section == 1) {
        
        static NSString *CellIdentifier = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        } else {
            for(UIView *view in cell.contentView.subviews) {
                [view removeFromSuperview];
            }
        }
        NSArray *dataSource = @[
                                @{@"name":@"主粮系列", @"price1":@"85", @"price2":@"83", @"percent":@"4166"},
                                @{@"name":@"零食大全", @"price1":@"85", @"price2":@"83", @"percent":@"4166"},
                                ];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(12, 0, 90, 60);
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textColor = YYPColor(52, 53, 54);
        nameLabel.text = dataSource[indexPath.row][@"name"];
        [cell.contentView addSubview:nameLabel];
        
        for (int i=0; i<3; i++) { // 利用一个标签创建通过富文本去修改布局
            
            CGFloat magrinL = 12;
            
            UILabel *crossLabel = [[UILabel alloc]init];
            crossLabel.frame = CGRectMake(magrinL+90+i*(UI_View_Width-magrinL-90)/3.0, 0, (UI_View_Width-magrinL-90)/3.0, 60);
            crossLabel.font = [UIFont systemFontOfSize:14];
            crossLabel.textColor = YYPColor(52, 53, 54);
            crossLabel.numberOfLines = 0;
            crossLabel.textAlignment = NSTextAlignmentCenter;
            NSString *titleStr; // 标题
            NSString *valueStr; // 值
            if (i == 0) {
                titleStr = @"销售额";
                valueStr = [NSString stringWithFormat:@"￥%@", dataSource[indexPath.row][@"price1"]];
            } else if (i == 1) {
                titleStr = @"毛利";
                valueStr = [NSString stringWithFormat:@"￥%@", dataSource[indexPath.row][@"price2"]];
            } else if (i == 2) {
                titleStr = @"毛利率";
                valueStr = [NSString stringWithFormat:@"%@%%", dataSource[indexPath.row][@"percent"]];
            }
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@", titleStr, valueStr]];
            [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(titleStr.length+1, valueStr.length)];
            [string addAttribute:NSForegroundColorAttributeName value:YYPColor(170, 170, 170) range:NSMakeRange(titleStr.length+1, valueStr.length)];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.alignment = NSTextAlignmentCenter;//居中
            paragraphStyle.lineSpacing = 3; // 调整行间距
            [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
            crossLabel.attributedText = string;
            [cell.contentView addSubview:crossLabel];
            
            if (i > 0) {
                UIView *line = [[UIView alloc] init];
                line.frame = CGRectMake(15, 59, UI_View_Width - 15, 0.5);
                line.backgroundColor = YYPColor(200, 200, 200);
                [cell.contentView addSubview:line];
            }
        }
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor clearColor];
    
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor clearColor];
    
    return footView;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.00;
    }
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==1) {
        return 60;
    }
    return 100;
}


@end
