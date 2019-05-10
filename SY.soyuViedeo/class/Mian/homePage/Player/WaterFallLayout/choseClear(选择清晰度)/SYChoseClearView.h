//
//  SYChoseClearView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/3.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYChoseClearView : UIView
@property(copy,nonatomic)void(^choseItem)(NSInteger index,NSString *content);
@end

NS_ASSUME_NONNULL_END
