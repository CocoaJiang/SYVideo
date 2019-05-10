//
//  SYHotFootView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/21.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class videoDetail;

@interface SYHotFootView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *SYClass;
@property (weak, nonatomic) IBOutlet UILabel *doctor;
@property (weak, nonatomic) IBOutlet UILabel *actor;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *lookDetail;
@property (weak, nonatomic) IBOutlet UIButton *collectbutton;
@property(strong,nonatomic)videoDetail *detailModel;



@end

NS_ASSUME_NONNULL_END
