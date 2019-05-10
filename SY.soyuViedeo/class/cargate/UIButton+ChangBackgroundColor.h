//
//  UIButton+ChangBackgroundColor.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ChangBackgroundColor)
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState )state;
@end

NS_ASSUME_NONNULL_END
