//
//  SYPrivacyController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYPrivacyController.h"

@interface SYPrivacyController ()

@end

@implementation SYPrivacyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYSetCell" bundle:nil] forCellReuseIdentifier:@"SYSetCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    NSArray *array = @[@"允许搜云视频访问地理位置信息",@"允许搜云视频访问相机",@"允许搜云视频访问相册",@"允许搜云视频访问麦克风"];
    [self.dataSorces addObjectsFromArray:array];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYSetCell"];
    cell.title.text =self.dataSorces[indexPath.row];
    cell.type = CellTypeJiantouAndText;
    cell.text.text = @"去设置";
    return cell;

}



@end
