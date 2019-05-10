//
//  SYhotDayView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYhotDayView : UIView
@property(copy,nonatomic)void(^buttonClick)(NSString *buttonTitle);
@end

NS_ASSUME_NONNULL_END
