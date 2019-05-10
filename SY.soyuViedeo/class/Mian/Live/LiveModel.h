//
//  LiveModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveModel : NSObject
@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *name;
@property(assign,nonatomic)BOOL isSeted;
@property(copy,nonatomic)NSString *info;
@property(strong,nonatomic)NSMutableArray *array;

@end

NS_ASSUME_NONNULL_END
