//
//  SYRankingChildVc.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYRankingChildVc.h"

@interface SYRankingChildVc ()

@end

@implementation SYRankingChildVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUI];
}

-(void)addUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
}

@end
