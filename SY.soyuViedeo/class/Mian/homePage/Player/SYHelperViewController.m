//
//  SYHelperViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/30.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHelperViewController.h"

#import "SYHelperCell.h"

#import "SYFaceToTeacherController.h"

@implementation SYHelperViewController

-(void)viewDidLoad{
    self.title = @"帮助与反馈";
    
    NSArray *array = @[
                       @{
                           @"title":@"1.无法播放视频",
                           @"content":@"如果出现某些视频无法播放，包含一直缓冲,闪退,网络异常,请尝试多打开几次，如果还是无法播放，请点击”我要反馈“把问题告诉我们，我们会尽快解决，谢谢！"
                           },
                       @{
                           @"title":@"2.有视频下载不了怎么办？",
                           @"content":@"尝试多点击几次或者重启手机，并检查手机空间是否足够，如果还是无法下载，请点击”我要反馈“把问题告诉我们,我们会尽快解决，谢谢！"
                           },
                       @{
                           @"title":@"3.搜索不到想看的视频",
                           @"content":@"由于版权原因,某些视频暂时无法提供，请点击”我要反馈“吐槽"
                           }
                       ];
    
    [self.dataSorces addObjectsFromArray:array];
 
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"我要反馈" forState:UIControlStateNormal];
    [button setBackgroundColor:KAPPMAINCOLOR];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(@45);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
    button.clickAction = ^(UIButton *button) {
      
        [self.navigationController pushViewController:[SYFaceToTeacherController new] animated:YES];
        
    };
    
    
    
    [self.tableView XJRegisCellWithNibWithName:@"SYHelperCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(button.mas_top);
    }];
    
    
}


///
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYHelperCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYHelperCell"];
    cell.title.text = self.dataSorces[indexPath.row][@"title"];
    cell.conten.text = self.dataSorces[indexPath.row][@"content"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [Tools XJCalculateTheSizeWithFont:[UIFont systemFontOfSize:14] andWithText:self.dataSorces[indexPath.row][@"content"] andWithWidthMAX:SCREEN_WIDTH-40].height;
    return height+50+30;
}



@end
