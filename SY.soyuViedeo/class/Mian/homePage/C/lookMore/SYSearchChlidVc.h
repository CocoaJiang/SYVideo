//
//  ChlidVc.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseViewController.h"
#import "ZJScrollPageViewDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface SYSearchChlidVc : SYBaseViewController<ZJScrollPageViewChildVcDelegate>
@property(strong,nonatomic)NSArray *array;
@property(copy,nonatomic)void(^saveItem)(NSString *historyString);



@end

NS_ASSUME_NONNULL_END
