//
//  SYVideoPlayerController.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYVideoPlayerController : SYBaseViewController
@property(copy,nonatomic)NSString *linkerURL;
@property(copy,nonatomic)NSString *video_id;

@end

NS_ASSUME_NONNULL_END
