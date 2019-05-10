//
//  SYLeavelHeaderView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYLeavelHeaderView.h"

@implementation SYLeavelHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setSystem];
}

-(void)setSystem{
    _icon.layer.cornerRadius=25;
    _icon.layer.masksToBounds = YES;
    _level.layer.masksToBounds = YES;
    _level.layer.cornerRadius = 2;
    [_level setBackgroundColor:RGBA(248, 200, 13, 1)];
    [_progress setTrackTintColor:[UIColor groupTableViewBackgroundColor]];
    [_progress setProgressTintColor:_level.backgroundColor];
    [_progress setProgress:0.34 animated:YES];
    _bootomView.backgroundColor = RGBA(250, 250, 250, 10);
    [_icon XJ_setImageWithURLString:[SYUSERINFO info].userInfo.user_portrait andWithImageName:@"touxiang"];
}


@end
