//
//  SY_ForScreenController.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/5.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseViewController.h"
#import "PlayModel.h"
#import <MRDLNA/MRDLNA.h>
NS_ASSUME_NONNULL_BEGIN

@interface SY_ForScreenController : SYBaseViewController
@property(copy,nonatomic)dispatch_block_t back;
@property(strong,nonatomic)PlayModel *model;
@property (nonatomic, strong) CLUPnPDevice *deviceModel;
@property(strong,nonatomic)NSString *video_id;

@end

NS_ASSUME_NONNULL_END

