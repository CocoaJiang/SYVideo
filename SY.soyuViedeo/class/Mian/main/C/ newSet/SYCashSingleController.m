//
//  SYCashSingleController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/7.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYCashSingleController.h"
#import "SYCashSigleCell.h"
@interface SYCashSingleController ()

@end

@implementation SYCashSingleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"同时缓存个数";
    
    [self.dataSorces addObjectsFromArray:@[@"1个",@"2个",@"3个"]];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor darkTextColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"温馨提示:";
    [view addSubview:label];
    [label sizeToFit];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(10);
        make.top.mas_equalTo(view.mas_top).offset(30);
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.text = @"请根据网络状态,选择同时缓存的视频个数";
    [tipLabel sizeToFit];
    [view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_left);
        make.top.mas_equalTo(label.mas_bottom).offset(30);
    }];
    
    UILabel *oneLabel = [[UILabel alloc]init];
    oneLabel.textColor= tipLabel.textColor;
    oneLabel.font = tipLabel.font;
    [oneLabel sizeToFit];
    oneLabel.text = @"1.网络较好,推荐使用2-3个,享受多个视频\n同时高速缓存。";
    [view addSubview:oneLabel];
    [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipLabel.mas_left);
        make.top.mas_equalTo(tipLabel.mas_bottom).offset(30);
    }];
    
    
    UILabel *twoLabel = [[UILabel alloc]init];
    twoLabel.textColor= tipLabel.textColor;
    twoLabel.font = tipLabel.font;
    [twoLabel sizeToFit];
    twoLabel.text = @"2.网络不佳,推荐选择1个,集中网络帮助单个\n视频更快下完。";
    [view addSubview:twoLabel];
    [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(oneLabel.mas_left);
        make.top.mas_equalTo(oneLabel.mas_bottom).offset(30);
    }];
    
    oneLabel.numberOfLines = twoLabel.numberOfLines = 0;
    
    self.tableView.tableFooterView =  view;
    
    [self.tableView XJRegisCellWithNibWithName:@"SYCashSigleCell"];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYCashSigleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYCashSigleCell"];
    cell.title.text = self.dataSorces[indexPath.row];
    NSString *string = self.dataSorces[indexPath.row];
    string =  [string substringToIndex:1];
    if ([[SYUSERINFO info].userInfo.setting.cacheNum intValue]==[string intValue]) {
        [cell.seletedImageView setHidden:NO];
    }else{
        [cell.seletedImageView setHidden:YES];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.dataSorces[indexPath.row];
    if ([[SYUSERINFO info].userInfo.setting.cacheNum intValue] == [[title substringToIndex:1] intValue]) {
        return;
    }
    [SYUSERINFO info].userInfo.setting.cacheNum = [title substringToIndex:1];
    [self.tableView reloadData];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[title substringToIndex:1] forKey:@"cacheNum"];
    [HttpTool POST:[SY_Set getWholeUrl] param:dict success:^(id responseObject) {
    } error:^(NSString *error) {
    }];
    
    
}


@end
