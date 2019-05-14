//
//  SYPersonHeader.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYPersonHeader.h"
#import "SYEditViewController.h"

@implementation SYPersonHeader
-(void)awakeFromNib{
    [super awakeFromNib];
    self.headerImage.layer.cornerRadius=30;
    self.headerImage.layer.masksToBounds=YES;
    self.loadImage.highlighted = self.forFullImage.highlighted = YES;
    self.lever.backgroundColor = [UIColor redColor];
    self.lever.layer.masksToBounds = YES;
    self.lever.layer.cornerRadius=3;
    self.nickName.font = [UIFont boldSystemFontOfSize:15];

    
}
- (IBAction)editbuttonClick:(UIButton *)sender {
    [[Tools viewController:self].navigationController pushViewController:[SYEditViewController new] animated:YES];
}
@end
