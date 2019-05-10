//
//  SYCoin_log.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/16.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYCoinLogsModel;

NS_ASSUME_NONNULL_BEGIN

@interface SYCoin_log : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLanel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel;
@property(strong,nonatomic)SYCoinLogsModel *model;

@end

NS_ASSUME_NONNULL_END
