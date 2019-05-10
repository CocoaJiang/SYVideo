//
//  SYCustomerFeedback.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYCustomerFeedback.h"
#import "SYSetCell.h"
#import "SYFaceToTeacherController.h"



@interface SYCustomerFeedback ()
@property(strong,nonatomic)UIButton *button;

@end

@implementation SYCustomerFeedback

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客户反馈";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYSetCell" bundle:nil] forCellReuseIdentifier:@"SYSetCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self setNAV];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYSetCell"];
    cell.type = CellTypeText;
    [cell.text setHidden:YES];
    cell.title.text= self.dataSorces[indexPath.row];
    return cell;
}
-(void)setNAV{
    self.title = @"消息中心";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"我要反馈" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button sizeToFit];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem= item;
}
-(void)buttonClick{
    [self.navigationController pushViewController:[SYFaceToTeacherController new] animated:YES];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}





@end
