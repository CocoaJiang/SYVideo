//
//  SYPlaySetView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/3.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYPlaySetView : UIView
///改变当前填充的方式！
@property(copy,nonatomic)void(^changVideoViewType)(BOOL isFuScreen);
///定时关闭的BLock
@property(copy,nonatomic)void(^closeVideoPlayer)(NSString *timeString);

@end

NS_ASSUME_NONNULL_END
