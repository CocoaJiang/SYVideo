//
//  VideoTypeModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/25.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomePageModel.h"
@class SY_Class;

NS_ASSUME_NONNULL_BEGIN

@interface VideoTypeModel : NSObject
@property(copy,nonatomic)NSArray<SY_Class *>*extends;
@property(strong,nonatomic)NSMutableArray< item*>*list;
@property(copy,nonatomic)NSString * pageSize;
@property(copy,nonatomic)NSString * page;
@end



@interface SY_Class : NSObject
@property(copy,nonatomic)NSString * item;
@property(copy,nonatomic)NSArray<NSString*>*item_list;
@end






NS_ASSUME_NONNULL_END
