//
//  ChoseVideoFrome.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/28.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class videoInfo;

@interface SYChoseVideoFrome : UIView

@property(strong,nonatomic)videoInfo *info;

@property(copy,nonatomic)dispatch_block_t cancelBlock;

@property(copy,nonatomic)void(^choseItem)(NSInteger index);



@end

NS_ASSUME_NONNULL_END
