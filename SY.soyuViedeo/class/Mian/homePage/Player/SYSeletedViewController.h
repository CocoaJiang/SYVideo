//
//  SYSeletedViewController.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/5.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYSeletedViewController : SYBaseViewController
@property(copy,nonatomic)void(^choseCell)(NSString *clearString,NSInteger index);
@property(copy,nonatomic)dispatch_block_t cancel;



@end

NS_ASSUME_NONNULL_END
