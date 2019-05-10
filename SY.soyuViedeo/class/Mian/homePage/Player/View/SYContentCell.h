//
//  SYContentCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class videoInfo;

@interface SYContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *playtimes;
@property (weak, nonatomic) IBOutlet UILabel *classes;
@property (weak, nonatomic) IBOutlet UILabel *dictory;
@property (weak, nonatomic) IBOutlet UILabel *ators;
@property(strong,nonatomic)videoInfo *info;
@property (weak, nonatomic) IBOutlet UILabel *douban_sources;


@end

NS_ASSUME_NONNULL_END
