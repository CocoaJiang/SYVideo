//
//  SYLeveModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

@class experience;

NS_ASSUME_NONNULL_BEGIN

@interface SYLeveModel : NSObject
@property(copy,nonatomic)NSString *level;
@property(copy,nonatomic)NSString *next_level;
@property(copy,nonatomic)NSString *next_exp;
@property(copy,nonatomic)NSArray *task;
@property(strong,nonatomic)NSArray <experience *>*group;




@end

@interface experience : NSObject
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *exp;


@end

NS_ASSUME_NONNULL_END
