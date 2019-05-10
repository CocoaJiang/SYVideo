//
//  UIButton+button_Rect.h
//  直播购物APP
//
//  Created by seekmac002 on 2018/7/27.
//  Copyright © 2018年 buySomthing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (button_Rect)


/**
  + 上部分是图片，下部分是文字
  +
  + @param space 间距
  + */
- (void)setUpImageAndDownLableWithSpace:(CGFloat)space;
/**
  + 左边是文字，右边是图片（和原来的样式翻过来）
  +
  + @param space 间距
  + */
- (void)setLeftTitleAndRightImageWithSpace:(CGFloat)space;

/**
  + 设置角标的个数（右上角）
  +
  + @param badgeValue badgeValue description
  + */
- (void)setBadgeValue:(NSInteger)badgeValue;



/*
 + 设置圆角
 +
 + @param badgeValue badgeValue description
 +
 */

-(void)makeYuanWithScle:(CGFloat)scle;

 @property (nonatomic, copy) void(^clickAction)(UIButton *button);

@end
