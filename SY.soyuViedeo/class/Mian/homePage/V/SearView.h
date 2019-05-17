//
//  SearView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearView : UIView
@property(copy,nonatomic)dispatch_block_t listenBlock;
@property(copy,nonatomic)dispatch_block_t searchBlock;
@property(strong,nonatomic)UIButton *searButton;

@end

NS_ASSUME_NONNULL_END
