//
//  SYMainBootomCell.m
//  SY.souyunVideo
//
//  Created by 搜云 on 2019/5/16.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYMainBootomCell.h"
#import "SYHelperViewController.h"
#import "SYSearchTVController.h"



@implementation SYMainBootomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.forScreenButton.titleLabel.font = self.helperButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.forScreenButton setUpImageAndDownLableWithSpace:10];
    [self.helperButton setUpImageAndDownLableWithSpace:10];
    __weak typeof(self)weakSelf = self;
    self.helperButton.clickAction = ^(UIButton *button) {
        [[Tools viewController:weakSelf].navigationController pushViewController:[SYHelperViewController new] animated:YES];
    };
    self.forScreenButton.clickAction = ^(UIButton *button) {
        SYSearchTVController *controller = [[SYSearchTVController alloc]init];
        controller.isForSeenTtype = YES;
        [[Tools viewController:weakSelf].navigationController pushViewController:controller animated:YES];
    };
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
