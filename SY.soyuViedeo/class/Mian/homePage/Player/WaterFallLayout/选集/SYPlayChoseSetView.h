//
//  SYPlayChoseSetView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/1.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class videoInfo;
NS_ASSUME_NONNULL_BEGIN

@interface SYPlayChoseSetView : UIView
@property(strong,nonatomic)videoInfo *info;
@property(assign,nonatomic)NSInteger index;
@property(copy,nonatomic)void(^choseItem)(NSInteger index);
-(void)relodData;
@end

NS_ASSUME_NONNULL_END
