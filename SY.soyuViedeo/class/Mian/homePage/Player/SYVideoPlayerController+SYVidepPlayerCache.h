//
//  SYVideoPlayerController+SYVidepPlayerCache.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/10.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYVideoPlayerController.h"
#import "VideoPlayInfo.h"
@class PlayModel;
NS_ASSUME_NONNULL_BEGIN

@interface SYVideoPlayerController (SYVidepPlayerCache)
///取出数据  如果没有数据则创建数据.....
-(VideoPlayInfo *)getCache;
///更新数据
-(void)saveDataWithModel:(VideoPlayInfo *)videoPlayer;
///调起h雷达进行搜索。。。
-(void)searchTVWithModel:(PlayModel *)model andWithURL:(NSString *)urlString;
@end

NS_ASSUME_NONNULL_END
