//
//  SYTableViewHeader.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYTableViewHeader : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property(copy,nonatomic)dispatch_block_t click;

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

NS_ASSUME_NONNULL_END
