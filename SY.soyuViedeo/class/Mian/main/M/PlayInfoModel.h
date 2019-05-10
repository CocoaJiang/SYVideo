//
//  PlayInfoModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayInfoModel : NSObject

 /*
 "id": 2,
 "name": "西游记",
 "player_key": 1,
 "serlize_key": 2,
 "serlize": "第2集",
 "pic": "http://192.168.10.192/upload/vod/20190222-1/bc42e99a4bab3331108632dbc313558c.jpg",
 "playTime": 1
 */

@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *player_key;
@property(copy,nonatomic)NSString *serlize_key;
@property(copy,nonatomic)NSString *serlize;
@property(copy,nonatomic)NSString *pic;
@property(copy,nonatomic)NSString *playTime;
@property(assign,nonatomic)BOOL isSeted;
@end

NS_ASSUME_NONNULL_END
