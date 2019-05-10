//
//  SYIntroductionView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class videoInfo;


typedef NS_ENUM(NSInteger,SYViewType){
    TV=0,//选集
    Introduction=1,//介绍
    Otehers=2,//其他
};


@interface SYIntroductionView : UIView
@property(copy,nonatomic)dispatch_block_t close;
@property(assign,nonatomic)SYViewType viewtype;
@property(strong,nonatomic)videoInfo *info;
@property(assign,nonatomic)NSInteger index;
@property(copy,nonatomic)void(^itemClick)(NSInteger index);


@end

NS_ASSUME_NONNULL_END
