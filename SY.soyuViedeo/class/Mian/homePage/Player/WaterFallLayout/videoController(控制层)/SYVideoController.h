//
//  SYChoseClearFloat.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/2.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class videoInfo;

typedef NS_ENUM(NSInteger,viewType){
    choseClear=0, //选择清晰度
    chosePlaytimes=1,//选择播放速度
    playset=2,//展开设置
    playShare=3,//展开分享
    choseSet=4,//选集
};


@interface SYVideoController : UIView;
///Block回调内容+类型+行为
@property(copy,nonatomic)void(^choseTypeAnditemindexAndContent)(viewType type,NSInteger index,NSString *content);
///回调让自己消失
@property(copy,nonatomic)dispatch_block_t dismissBlock;
///view 展开的类型
@property(assign,nonatomic)viewType type;
///view 个别控制器的数据源。。。
-(void)setSeleIndex:(NSInteger)index andWithModel:(videoInfo *)model;
///控制控制器的画面的的Block
@property(copy,nonatomic)void(^changVideoPlayerSizeType)(BOOL isFullScreen);
///定时关闭的播放器的Block
@property(copy,nonatomic)void(^timerClosePlayerWtihTime)(NSString *timeString);

@end

NS_ASSUME_NONNULL_END
