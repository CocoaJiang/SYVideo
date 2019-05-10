//
//  SYSearTipView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYSearTipView : UIView
//暴露视图接口
@property(strong,nonatomic)UIView *contentView;

@property(copy,nonatomic)dispatch_block_t removeAllhistory;



@end

NS_ASSUME_NONNULL_END
