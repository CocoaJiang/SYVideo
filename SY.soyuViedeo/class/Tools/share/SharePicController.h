//
//  SharePicController.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/29.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseViewController.h"


@class videoInfo;
NS_ASSUME_NONNULL_BEGIN

@interface SharePicController : SYBaseViewController

@property(strong,nonatomic)videoInfo *info;
@property(strong,nonatomic)UIImage *image;

@end

NS_ASSUME_NONNULL_END
