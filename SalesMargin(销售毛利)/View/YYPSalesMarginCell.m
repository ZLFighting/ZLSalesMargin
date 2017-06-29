//
//  YYPSalesMarginCell.m
//  YYPAppointment
//
//  Created by ZL on 2017/6/29.
//  Copyright © 2017年 zhangli. All rights reserved.
//

#import "YYPSalesMarginCell.h"
#import "YYPSalesMarginModel.h"

@interface YYPSalesMarginCell ()

// cell分割线条 高1
@property (nonatomic, weak) UIView *marginView;

// 背景整体
@property (nonatomic, weak) UIView *bgView;

// 商品系列名称
@property (nonatomic, weak) UILabel *name;

// 销售额
@property (nonatomic, weak) UILabel *sale;

// 毛利
@property (nonatomic, weak) UILabel *grossProfit;

// 毛利率
@property (nonatomic, weak) UILabel *percent;

@end

@implementation YYPSalesMarginCell

// 创建并返回cell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"YYPStaffOutcomes_cell";
    
    YYPSalesMarginCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[YYPSalesMarginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
    
}

// 重写init方法 设置子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        // cell分割线
        UIView *marginView = [[UIView alloc] init];
        marginView.backgroundColor = YYPBackgroundColor;
        [self.contentView addSubview:marginView];
        self.marginView = marginView;
        
        // 背景整体
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        self.bgView = bgView;
        
        // 商品系列名称
        UILabel *name = [[UILabel alloc] init];
        name.backgroundColor = [UIColor clearColor];
        name.font = [UIFont systemFontOfSize:14];
        name.textColor = YYPColor(52, 53, 54);
        [self.bgView addSubview:name];
        self.name = name;
        
        // 销售额
        UILabel *sale = [[UILabel alloc] init];
        sale.backgroundColor = [UIColor clearColor];
        sale.font = [UIFont systemFontOfSize:14];
        sale.textColor = YYPColor(52, 53, 54);
        sale.textAlignment = NSTextAlignmentCenter;
        sale.numberOfLines = 0;
        [self.bgView addSubview:sale];
        self.sale = sale;
        
        // 毛利
        UILabel *grossProfit = [[UILabel alloc] init];
        grossProfit.backgroundColor = [UIColor clearColor];
        grossProfit.font = [UIFont systemFontOfSize:14];
        grossProfit.textColor = YYPColor(52, 53, 54);
        grossProfit.textAlignment = NSTextAlignmentCenter;
        grossProfit.numberOfLines = 0;
        [self.bgView addSubview:grossProfit];
        self.grossProfit = grossProfit;
        
        // 毛利率
        UILabel *percent = [[UILabel alloc] init];
        percent.backgroundColor = [UIColor clearColor];
        percent.font = [UIFont systemFontOfSize:14];
        percent.textColor = YYPColor(52, 53, 54);
        percent.textAlignment = NSTextAlignmentCenter;
        percent.numberOfLines = 0;
        [self.bgView addSubview:percent];
        self.percent = percent;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置子控件位置
    [self setupFrame];
}

// 设置子控件位置
- (void)setupFrame {
    
    // 顶部cell分割线条 高1
    CGFloat marginViewH = 1;
    // 左右的间隔
    CGFloat marginL = 12;
    
    CGFloat height = YYPSalesMarginCellHeight - marginViewH;
    
    self.bgView.frame = CGRectMake(marginL, 0, UI_View_Width - marginL, height);
    
    self.name.frame = CGRectMake(0, 0, 90, height);
    
    // 内部控件宽度
    CGFloat width = (self.bgView.width - self.name.width) / 3;
    
    self.sale.frame = CGRectMake(CGRectGetMaxX(self.name.frame), 0, width, height);
    
    self.grossProfit.frame = CGRectMake(CGRectGetMaxX(self.sale.frame), 0, width, height);
    
    self.percent.frame = CGRectMake(CGRectGetMaxX(self.grossProfit.frame), 0, width, height);
    
    self.marginView.frame = CGRectMake(marginL, CGRectGetMaxY(self.bgView.frame), UI_View_Width - marginL, marginViewH);
}

// model赋值
- (void)setModel:(YYPSalesMarginModel *)model {
    
    _model = model;
    
    // 商品系列名称
    self.name.text = [NSString stringWithFormat:@"%@", model.name];
    
    // 销售额
    self.sale.attributedText = [self setupAttriLabelWithTitleStr:@"销售额" ValueStr:[NSString stringWithFormat:@"￥%.2f", model.sale]];
    
    // 毛利
    self.grossProfit.attributedText = [self setupAttriLabelWithTitleStr:@"毛利" ValueStr:[NSString stringWithFormat:@"￥%.2f", model.grossProfit]];
    
    // 毛利率
    self.percent.attributedText = [self setupAttriLabelWithTitleStr:@"毛利率" ValueStr:[NSString stringWithFormat:@"%.2f%%", model.percent]];
}

/**
 * label 的富文本布局
 * 
 * titleStr 标题
 * ValueStr 值
 */
- (NSMutableAttributedString *)setupAttriLabelWithTitleStr:(NSString *)titleStr ValueStr:(NSString *)valueStr {
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@", titleStr, valueStr]];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(titleStr.length+1, valueStr.length)];
    [string addAttribute:NSForegroundColorAttributeName value:YYPColor(170, 170, 170) range:NSMakeRange(titleStr.length+1, valueStr.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter; // 居中
    paragraphStyle.lineSpacing = 3; // 调整行间距
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    
    return string;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
