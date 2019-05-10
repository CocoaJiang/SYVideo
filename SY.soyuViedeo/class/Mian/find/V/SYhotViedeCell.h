//
//  SYhotViedeCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYhotViedeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *leveMessage;
@property (weak, nonatomic) IBOutlet UIButton *giveaLiker;
@property (weak, nonatomic) IBOutlet UIButton *share;
@property(strong,nonatomic)hotModel *model;


@end

NS_ASSUME_NONNULL_END
