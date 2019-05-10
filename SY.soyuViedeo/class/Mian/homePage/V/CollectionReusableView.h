//
//  CollectionReusableView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomePageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionReusableView : UICollectionReusableView


@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *morebutton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@property (weak, nonatomic) IBOutlet UIView *upBgView;

@property (weak, nonatomic) IBOutlet UIView *downBgView;

@property (weak, nonatomic) IBOutlet UIImageView *cover;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *subName;

@property(strong,nonatomic)data *model;


@end

NS_ASSUME_NONNULL_END
