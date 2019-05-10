//
//  SYResginController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYResginController.h"
#import "LoginHeaderView.h"
#import "RegisAcountCell.h"
#import "UIButton+VerificationCode.h"
@interface SYResginController ()

@end

@implementation SYResginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNAV];
    self.title =@"注册";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    LoginHeaderView *headeView= [Tools XJ_XibWithName:@"LoginHeaderView"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    [view addSubview:headeView];
    headeView.bounds = view.bounds;
    self.tableView.tableHeaderView = view;
    [self.tableView registerNib:[UINib nibWithNibName:@"RegisAcountCell" bundle:nil] forCellReuseIdentifier:@"RegisAcountCell"];
    
    
}
-(void)setNAV{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonClickToregis) forControlEvents:UIControlEventTouchUpInside];
}
-(void)buttonClickToregis{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RegisAcountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegisAcountCell"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}




@end
