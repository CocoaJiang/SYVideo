//
//  SYSearchTVController.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/30.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseViewController.h"
#import <MRDLNA/MRDLNA.h>
NS_ASSUME_NONNULL_BEGIN

@class PlayModel;

@interface SYSearchTVController : SYBaseViewController
@property(strong,nonatomic)PlayModel *model;
@property(strong,nonatomic)NSString *url;
///存储的播放信息的ID
@property(copy,nonatomic)NSString *video_id;
///是不是搜索
@property(assign,nonatomic)BOOL isForSeenTtype;






@end

NS_ASSUME_NONNULL_END
