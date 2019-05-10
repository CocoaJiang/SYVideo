//
//  SYChangePassWorldController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYChangePassWorldController.h"
#import "SYChangePassWorld2Controller.h"
#import "SYSetCell.h"

@interface SYChangePassWorldController ()

@end

@implementation SYChangePassWorldController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账号安全中心";
    [self.dataSorces addObject:@"通过手机号验证"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor darkGrayColor];
    label.text = @"修改登录密码需要先进行身份验证\n请选择验证方式";
    label.numberOfLines = 0;
    [view addSubview:label];
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = view.center;
    self.tableView.tableHeaderView = view;
    [self.tableView XJRegisCellWithNibWithName:@"SYSetCell"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYSetCell"];
    cell.type =CellTpyeJiantou;
    cell.title.text = self.dataSorces[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SYChangePassWorld2Controller *controllert = [[SYChangePassWorld2Controller alloc]init];
    [self.navigationController pushViewController:controllert animated:YES];
    
}




@end
