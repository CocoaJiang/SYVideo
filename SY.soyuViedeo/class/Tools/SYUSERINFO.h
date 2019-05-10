//
//  SYUSERINFO.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userInfo.h"
#import "systemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYUSERINFO : NSObject
@property(strong,nonatomic)userInfo *userInfo;
@property(strong,nonatomic)systemModel *systemModel;
+(instancetype)info;
@end

NS_ASSUME_NONNULL_END
