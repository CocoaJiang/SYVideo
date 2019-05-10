//
//  SYLoginController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYLoginController.h"
#import "LoginHeaderView.h"
#import "LoginCell.h"
#import "LoginFootView.h"
#import "SYResginController.h"
@interface SYLoginController ()

@property(strong,nonatomic)LoginFootView *footView;

@property(copy,nonatomic)NSString *phone;
@property(copy,nonatomic)NSString *password;



@end

@implementation SYLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)weakSelf  = self;
    self.UserLogin = ^(NSString * _Nonnull phone, NSString * _Nonnull password) {
        weakSelf.phone=phone;
        weakSelf.password=password;
        [weakSelf.tableView reloadData];
        
    };
    
    self.title = @"登录";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"注册" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonClickToregis) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem= item;
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view).mas_offset(0);
        }
        make.height.mas_equalTo(@130);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.footView.mas_top);
    }];
    LoginHeaderView *headeView= [Tools XJ_XibWithName:@"LoginHeaderView"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    [view addSubview:headeView];
    headeView.bounds = view.bounds;
    self.tableView.tableHeaderView = view;
    [self.tableView registerNib:[UINib nibWithNibName:@"LoginCell" bundle:nil] forCellReuseIdentifier:@"LoginCell"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoginCell"];
        if (self.phone) {
            cell.phoneText.text =  self.phone;
        }
        if (self.password) {
            cell.passWord.text = self.password;
        }
        return cell;
    }
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}


-(LoginFootView *)footView{
    if (!_footView) {
        _footView = [Tools XJ_XibWithName:@"LoginFootView"];
    }
    return _footView;
}

-(void)buttonClickToregis{
    //去注册
    SYResginController *controller = [[SYResginController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end
