//
//  SYClarityController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYClarityController.h"
#import "SYSetCell.h"

@interface SYClarityController ()

@end

@implementation SYClarityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"缓存清晰度";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYSetCell" bundle:nil] forCellReuseIdentifier:@"SYSetCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    NSArray *array = @[@"蓝光1080P",@"超清729P",@"高清540P",@"标清360P"];
    [self.dataSorces addObjectsFromArray:array];
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor darkGrayColor];
    label.text = @"优先为您下载所选清晰度,若无则自动匹配最近清晰度";
    label.font = [UIFont systemFontOfSize:11];
    label.frame = CGRectMake(20, 0, SCREEN_WIDTH-40, 50);
    self.tableView.tableFooterView = label;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYSetCell"];
    cell.title.text =self.dataSorces[indexPath.row];
    cell.type = CellTypeSwitch;
    return cell;
}


@end
