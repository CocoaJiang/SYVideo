//
//  SYContentCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYContentCell.h"
#import "PlayModel.h"
@implementation SYContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    _douban_sources.backgroundColor = KAPPMAINCOLOR;
    _douban_sources.layer.cornerRadius=2;
    _douban_sources.layer.masksToBounds=YES;
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.font = [UIFont systemFontOfSize:13];
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setInfo:(videoInfo *)info{
    _info = info;
    _playtimes.text = [NSString stringWithFormat:@"%@次",info.hits];
    _classes.text = info.Class;
    _dictory.text = info.director;
    _ators.text = info.actor;
    _douban_sources.text = [NSString stringWithFormat:@"  豆瓣:%@  ",info.douban_score];
}

@end
