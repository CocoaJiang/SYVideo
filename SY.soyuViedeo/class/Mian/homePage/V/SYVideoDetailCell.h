//
//  SYVideoDetailCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SYVideoDetailCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *dislabel;
@property(strong,nonatomic)item *model;
@property (weak, nonatomic) IBOutlet UIImageView *hotimageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLanel;

@end

NS_ASSUME_NONNULL_END
