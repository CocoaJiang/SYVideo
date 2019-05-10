//
//  SYZanViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYZanViewController.h"
#import "SYZanCell.h"


@interface SYZanViewController ()

@end

@implementation SYZanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论消息";
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight=65;
    [self.tableView registerNib:[UINib nibWithNibName:@"SYZanCell" bundle:nil] forCellReuseIdentifier:@"SYZanCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYZanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYZanCell"];

    return cell;
}





@end
