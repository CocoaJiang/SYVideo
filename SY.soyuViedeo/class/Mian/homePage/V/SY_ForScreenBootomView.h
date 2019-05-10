//
//  SY_ForScreenBootomView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/5.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFSliderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SY_ForScreenBootomView : UIView
@property(strong,nonatomic)ZFSliderView *slider;
@property(copy,nonatomic)void(^playOrPause) (BOOL playOrPause);
@property(copy,nonatomic)void(^playValue) (float playValue);
-(void)setCurrTime:(NSString *)currtimeString andTotal:(NSString *)totoaTinmeString andWithProgress:(CGFloat)progress;
@end

NS_ASSUME_NONNULL_END
