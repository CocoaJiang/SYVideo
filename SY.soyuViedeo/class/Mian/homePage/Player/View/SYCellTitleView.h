//
//  SYCellTitleView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYCellTitleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property(copy,nonatomic)dispatch_block_t rightClick;


@end

NS_ASSUME_NONNULL_END
