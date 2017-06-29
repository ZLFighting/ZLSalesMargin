//
//  YYPSalesMarginController.m
//  YYPAppointment
//
//  Created by ZL on 2017/6/28.
//  Copyright © 2017年 zhangli. All rights reserved.
//

#import "YYPSalesMarginController.h"
#import "YYPSalesMarginCell.h"
#import "YYPSalesMarginModel.h"
#import "YYPTimeView.h"

@interface YYPSalesMarginController () <YYPTimeViewDelegate>

@property (nonatomic, strong) YYPTimeView *timeView;

// 列表数组
@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation YYPSalesMarginController

#pragma mark - 懒加载

- (YYPTimeView *)timeView {
    if (!_timeView) {
        YYPTimeView *timeView = [[YYPTimeView alloc] initWithFrame:CGRectMake(50, 0, UI_View_Width - 100, 80)];
        timeView.delegate = self;
        _timeView = timeView;
    }
    return _timeView;
}


- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
        
        // TODO:假数据
        for (int i = 0; i < 14; i++) {
            YYPSalesMarginModel *model = [[YYPSalesMarginModel alloc] init];
            
            model.name = [NSString stringWithFormat:@"主粮系列%d", i];
            model.sale = 1000 + i;
            model.grossProfit = 100 + i;
            model.percent = model.grossProfit / model.sale;
            
            [_list addObject:model];
        }
    }
    return _list;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YYPBackgroundColor;
    self.navigationItem.title = @"销售毛利";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    
    // 设置tableView的headerView
    [self.tableView setTableHeaderView:[self setupTableHeaderView]];
    
//    [self loadData];
}

- (void)loadData{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableHeaderView

- (UIView *)setupTableHeaderView {
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_View_Width, 50)];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    
    // 起始时间选择器控件
    [tableHeaderView addSubview:self.timeView];
    
    return tableHeaderView;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        // 当数据没有了，则隐藏footer上拉加载刷新控件
        self.tableView.mj_footer.hidden = self.list.count == 0;
        return self.list.count;
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
        
        YYPSalesMarginCell *cell = [YYPSalesMarginCell cellWithTableView:tableView];
        if (self.list.count) { //
            YYPSalesMarginModel *model = self.list[indexPath.row];
            cell.model = model;
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
        return YYPSalesMarginCellHeight;
    }
    return 100;
}

#pragma mark - YYPTimeViewDelegate

- (void)timeView:(YYPTimeView *)timeView seletedDateBegin:(NSString *)beginTime end:(NSString *)endTime {
    //    [self loadNewNetDataWithBegintime:beginTime endtime:endTime];
}



@end
