//
//  userInfo.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>


@class USERSET;

NS_ASSUME_NONNULL_BEGIN

@interface userInfo : NSObject
@property(copy,nonatomic)NSString *user_id;
@property(copy,nonatomic)NSString *user_name;
@property(copy,nonatomic)NSString *user_nick_name;
@property(copy,nonatomic)NSString *user_sex; // 用户性别0未设置1男2女
@property(copy,nonatomic)NSString *user_points;//用户金币。。。。
@property(copy,nonatomic)NSString *user_code;///邀请码！
@property(copy,nonatomic)NSString *user_portrait;
@property(copy,nonatomic)NSString *level;
@property(copy,nonatomic)NSString *user_cache;//用户是否有缓存权限
@property(copy,nonatomic)NSString *user_screen;// 用户是否有投屏权限
@property(copy,nonatomic)NSString *invitecode;//用户接受的邀请码
@property(copy,nonatomic)NSString *user_exp;//该用户当前等级的经验。。。
@property(strong,nonatomic)USERSET *setting;
@end
@interface USERSET : NSObject
@property(copy,nonatomic)NSString *cacheNum;//  同时缓存个数
@property(copy,nonatomic)NSString *wifi;//  允许2g3g4g网络缓存0表示不允许，1表示允许
@property(copy,nonatomic)NSString *continuity;//  连续播放0 表示不连续，1表示连续
@property(copy,nonatomic)NSString *autoPlay;//  自动跳片头片尾0表示不自动，1表示自动
@property(copy,nonatomic)NSString *hand;//  播放手势0表示不播放，1表示播放
@property(copy,nonatomic)NSString *FLDBID;


@end



NS_ASSUME_NONNULL_END

