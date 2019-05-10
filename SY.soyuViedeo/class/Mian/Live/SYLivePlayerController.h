//
//  SYLivePlayerController.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseViewController.h"
#import "LiveListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYLivePlayerController : SYBaseViewController
@property(copy,nonatomic)NSString *idString;
@property(strong,nonatomic)LiveListModel *savemodel;


@end

NS_ASSUME_NONNULL_END
