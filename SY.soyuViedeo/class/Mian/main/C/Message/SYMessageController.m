//
//  SYMessageController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYMessageController.h"
#import "SYSetCell.h"
#import "SYSystemMessageController.h"
#import "SYZanViewController.h"
#import "SYCustomerFeedback.h"

@interface SYMessageController ()

@end

@implementation SYMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNAV];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYSetCell" bundle:nil] forCellReuseIdentifier:@"SYSetCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    NSArray *array = @[@"系统消息",@"评论消息",@"客服反馈"];
    [self.dataSorces addObjectsFromArray:array];
    self.tableView.rowHeight = 55;
}

-(void)setNAV{
    self.title = @"消息中心";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"全部已读" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button sizeToFit];
    button.hidden = YES;
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem= item;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYSetCell"];
    cell.title.text =self.dataSorces[indexPath.row];
    if (indexPath.row==0) {
        cell.type = CellTpyeJiantou;
    }else{
        cell.type = CellTpyeJiantou;
        cell.title.text = self.dataSorces[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idString = self.dataSorces[indexPath.row];
    if ([idString isEqualToString:@"系统消息"]) {
        SYSystemMessageController *controller = [[SYSystemMessageController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }else if ([idString isEqualToString:@"评论消息"]){
        SYZanViewController *controller = [[SYZanViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }else if ([idString isEqualToString:@"客服反馈"]){
        SYCustomerFeedback *controller = [[SYCustomerFeedback alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
}


@end
