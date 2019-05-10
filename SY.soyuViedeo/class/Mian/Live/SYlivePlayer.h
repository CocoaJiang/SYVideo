//
//  SYlivePlayer.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface dayModel : NSObject
@property(copy,nonatomic)NSString *date;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *curr;
@property(assign,nonatomic)BOOL isSeleted;
@end

@interface routeModel : NSObject
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *url;
///s是否选中


/*
 parse    Boolean
 为true则需要调用电视解析接口
 
 param    String
 电视解析接口传的参数
 */

///为true则需要调用电视解析接口
@property(assign,nonatomic)BOOL parse;

@property(copy,nonatomic)NSString *param;




@property(assign,nonatomic)BOOL isSeted;

@end

@interface SYlivePlayer : NSObject
@property(copy,nonatomic)NSString *is_store;
@property(copy,nonatomic)NSArray<dayModel *> *day;
@property(copy,nonatomic)NSArray <routeModel *>*routes;

@end

NS_ASSUME_NONNULL_END
