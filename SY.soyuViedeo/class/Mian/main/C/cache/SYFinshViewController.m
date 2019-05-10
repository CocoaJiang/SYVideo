//
//  SYFinshViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYFinshViewController.h"

@interface SYFinshViewController ()

@end

@implementation SYFinshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    [view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
}
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [Tools returnWithString:@"暂无缓存任务赶紧去缓存吧!"];
}

@end
