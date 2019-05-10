//
//  SYSearchModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/25.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>
@class searchDetailModel;
NS_ASSUME_NONNULL_BEGIN

@interface SYSearchModel : NSObject
@property(copy,nonatomic)NSString *type_name;
@property(copy,nonatomic)NSArray <searchDetailModel*>*list;
@end

@interface searchDetailModel : NSObject
@property(copy,nonatomic)NSString *keyword;
@property(copy,nonatomic)NSString *trend;
@property(copy,nonatomic)NSString *rank;//排行名词
@property(copy,nonatomic)NSString *hot;
/*
 data->hot    mix    0什么都没有1火爆2热播其他则是字符高清度1080P蓝光
 data->trend    number    0不变1上升2下降
 */
@end

NS_ASSUME_NONNULL_END

