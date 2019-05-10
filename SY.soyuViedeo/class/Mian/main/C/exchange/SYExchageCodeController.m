//
//  SYExchageCodeController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYExchageCodeController.h"
#import "SearView.h"

@interface SYExchageCodeController ()
@property(strong,nonatomic)SearView *search;


@end

@implementation SYExchageCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换码";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [view addSubview:self.search];
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
    self.tableView.tableHeaderView = view;
    
}
-(SearView *)search{
    if (!_search) {
        _search = [Tools XJ_XibWithName:@"SeachView"];
    }
    return _search;
}



@end
