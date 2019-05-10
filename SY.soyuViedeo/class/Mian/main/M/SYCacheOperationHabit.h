//
//  SYCacheOperationHabit.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface SYCacheOperationHabit : NSObject
///拿到当前的模型！！！！！
+(USERSET *)getSetting;
///更新模型
+(BOOL)savaModelOperationHabit:(USERSET *)set;
@end

NS_ASSUME_NONNULL_END
