//
//  SYLoginController.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYLoginController : SYBaseViewController
@property(copy,nonatomic)void(^UserLogin)(NSString *phone,NSString *password);


@end

NS_ASSUME_NONNULL_END
