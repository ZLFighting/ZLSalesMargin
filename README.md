# ZLSalesMargin
快速展示布局


![](https://github.com/ZLFighting/ZLSalesMargin/blob/master/截图1.png)
看到这个界面,是不是觉得不像那种比较有规律的, 可以用 单独 tableViewCell 或者 xib 来实现方便些的,现在我直接在 C里快速实现展示布局.
建议像这种死的分区可以这么来,但是多数据需要后台传数据的那种最好用 MVC来实现. 

先看布局, 可以分成两个分区:在数据源方法里去处理展现
这两个方法, 第一个布局用的较多, 第二个可以在商品介绍里用上富文本去修改色系. 

>1. 第一种的C文件可以直接拖进你的项目里使用的.
2. 第二种是采取 MVC 形式所写(单独把 label 的富文本方法抽取出来).

**先看布局, 可以分成两个分区:在数据源方法里去处理展现**

```
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
// 处理第一分区
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
// 处理第二分区
return cell;
}
return nil;
}
```

**第一部分可以用两个标签去处理展示:**
```
NSArray *nameArr = @[@"商品销售额",@"商品销售毛利",@"毛利率"];
NSArray *valueArr = @[@"￥311.00",@"￥143.00",@"46.11%"];
NSInteger count = nameArr.count;

for (int i=0; i<count; i++) { // 循环创建两个标签
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

if (i > 0) { // 添加间隔竖线
UIView *line = [[UIView alloc] init];
line.frame = CGRectMake(0, 0, 0.5, 40);
line.backgroundColor = YYPColor(200, 200, 200);
[backView addSubview:line];
}
}

```

**第二部分可以利用一个标签创建通过富文本去修改布局:**
```
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

for (int i=0; i<3; i++) { // 循环创建一个标签

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
// 创建通过富文本去修改色系
NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@", titleStr, valueStr]];
[string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(titleStr.length+1, valueStr.length)];
[string addAttribute:NSForegroundColorAttributeName value:YYPColor(170, 170, 170) range:NSMakeRange(titleStr.length+1, valueStr.length)];

NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
paragraphStyle.alignment = NSTextAlignmentCenter;//居中
paragraphStyle.lineSpacing = 3; // 调整行间距
[string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
crossLabel.attributedText = string;
[cell.contentView addSubview:crossLabel];

if (i > 0) { // 循环添加间隔横线
UIView *line = [[UIView alloc] init];
line.frame = CGRectMake(15, 59, UI_View_Width - 15, 0.5);
line.backgroundColor = YYPColor(200, 200, 200);
[cell.contentView addSubview:line];
}
}
```

这两个方法, 第一个布局用的较多, 第二个可以在商品介绍里用上富文本去修改色系.

**PS:建议像这种死的分区可以这么来,但是多数据需要后台传数据的那种最好用 MVC来实现. **
个人感觉后期维护修改界面布局的情况下, 直接在 cell 里修改会比较清晰方便.

第二种方法这里测试一下:
**当以 MVC 形式来写的话, 标签我在 Cell 里还是用一个来先创建, 只不过多写一个label 的富文本布局方法.**
```
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
```
**然后在 Model 赋值里调用这个方法**
```
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
```
![MVC 创建效果图](https://github.com/ZLFighting/ZLSalesMargin/blob/master/截图2.png)


您的支持是作为程序媛的我最大的动力, 如果觉得对你有帮助请送个Star吧,谢谢啦

创建了一个群,
可以在群里互相讨论学习
如果需要可以加群:619216102 
群名称备注: 职业|所在城市|姓名或昵称

