//
//  SYGifFoot.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/26.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYGifFoot.h"

@implementation SYGifFoot

-(void)prepare{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSString *string in REFUSHARRAY) {
        UIImage *image = [UIImage imageNamed:string];
        [idleImages addObject:image];
    }
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    
    for (NSString *string in REFUSHARRAY) {
        UIImage *image = [UIImage imageNamed:string];
        [refreshingImages addObject:image];
    }
    
    [self setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

- (void)placeSubviews {
    [super placeSubviews];
    //隐藏状态显示文字
    self.stateLabel.hidden = YES;
    //隐藏更新时间文字
    self.refreshingTitleHidden=YES;
}

@end
