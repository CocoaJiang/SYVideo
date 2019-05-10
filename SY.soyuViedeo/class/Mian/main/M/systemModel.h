//
//  systemModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

@class app_version;

NS_ASSUME_NONNULL_BEGIN

@interface systemModel : NSObject


@property(strong,nonatomic)app_version *app_version;//APP版本号
@property(copy,nonatomic)NSString *site_name;//名称
@property(copy,nonatomic)NSString *site_email;// 联系email
@property(copy,nonatomic)NSString *site_status;//是否允许访问
@property(copy,nonatomic)NSString *site_close_tip;//关闭时显示的提示
@property(copy,nonatomic)NSString *copyright_status;//是否开启版权提示
@property(copy,nonatomic)NSString *copyright_notice;// 版权提示消息
@property(copy,nonatomic)NSArray *vod_parse_url;
@property(copy,nonatomic)NSString *coin_name;///金币名称
@property(copy,nonatomic)NSString *shareURL;//分享URL的地址
@property(copy,nonatomic)NSString *inviteCode;//公共的邀请码！！！！




/*
 "copyright_status": "1",
 "copyright_notice": "该视频由于版权限制，暂不提供播放。",
 "coin_name": "搜云币"
 */

@end


@interface app_version : NSObject
@property(copy,nonatomic)NSString *android;
@property(copy,nonatomic)NSString *force;
@property(copy,nonatomic)NSString *content;
@property(copy,nonatomic)NSString *ios;
@property(copy,nonatomic)NSString *version;


@end





NS_ASSUME_NONNULL_END
