//
//  VideoPlayInfo.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/29.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XWDatabase.h>
NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayInfo : NSObject<XWDatabaseModelProtocol>
@property(copy,nonatomic)NSString *FLDBID; //主键
@property(assign,nonatomic)NSTimeInterval lasttime; //最后的播放时间
@property(assign,nonatomic)NSInteger playTheSource; //播放源
@property(assign,nonatomic)NSInteger playTheSet; //播放到第几集
@property(assign,nonatomic)NSInteger playClear; //缓存清晰度、。
@end

NS_ASSUME_NONNULL_END
