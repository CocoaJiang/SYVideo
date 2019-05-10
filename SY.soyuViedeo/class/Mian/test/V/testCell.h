//
//  testCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class task_ist;
@interface testCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *dislabel;
@property (weak, nonatomic) IBOutlet UILabel *maflowerlabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property(strong,nonatomic) task_ist   *model;
@property(copy,nonatomic)dispatch_block_t refush;
@property (weak, nonatomic) IBOutlet UILabel *finshLabel;






@end

NS_ASSUME_NONNULL_END
