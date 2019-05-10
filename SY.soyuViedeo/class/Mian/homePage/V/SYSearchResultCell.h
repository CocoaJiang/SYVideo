//
//  SYSearchResultCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/25.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

@class item;

NS_ASSUME_NONNULL_BEGIN
@interface SYSearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *cleanFloat;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *playtimes;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property(strong,nonatomic)item *model;



@end

NS_ASSUME_NONNULL_END
