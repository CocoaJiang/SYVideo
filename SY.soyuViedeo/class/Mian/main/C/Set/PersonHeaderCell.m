//
//  PersonHeaderCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/6.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "PersonHeaderCell.h"

@implementation PersonHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius  = 65/2;
    self.icon.layer.masksToBounds = YES;
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [_icon XJ_setImageWithURLString:[SYUSERINFO info].userInfo.user_portrait andWithImageName:@"touxiang"];
    self.title.font = [UIFont systemFontOfSize:14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
