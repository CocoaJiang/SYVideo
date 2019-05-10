//
//  SYSeletedViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/5.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSeletedViewController.h"
#import "NSString+Seleted.h"

@interface SYSeletedViewController ()

@end

@implementation SYSeletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.dataSorces addObjectsFromArray:@[@"1080P",@"高清",@"超清",@"标清"]];
    for (NSString *string in self.dataSorces) {
        if ([string isEqualToString:@"标清"]) {
            string.isSeleted = YES;
        }
    }
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    __weak typeof(self)weakSelf = self;
    button.clickAction = ^(UIButton *button) {
        if (weakSelf.cancel) {
            weakSelf.cancel();
        }
    };
    UIView *lineView  = [Tools retunLineView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [view addSubview:lineView];
    lineView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.8);
    [view addSubview:button];
    button.frame = CGRectMake(0, lineView.bottom, view.width, view.height-lineView.height);
    self.tableView.tableFooterView = view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *Idstring =  @"IDString";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Idstring];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Idstring];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSString *string = self.dataSorces[indexPath.row];
    if (string.isSeleted) {
        cell.textLabel.textColor = KappBlue;
    }else{
        cell.textLabel.textColor = [UIColor darkTextColor];
    }
    cell.textLabel.text = self.dataSorces[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *string =  self.dataSorces[indexPath.row];
    if (string.isSeleted) {
        return;
    }
    for (NSString *string in self.dataSorces) {
        string.isSeleted = NO;
        if ([string isEqualToString:self.dataSorces[indexPath.row]]) {
            string.isSeleted = YES;
        }
    }

    [self.tableView reloadData];
    
    if (self.choseCell) {
        self.choseCell(self.dataSorces[indexPath.row],indexPath.row);
    }
    
}

////设置选中状态。。。。






@end
