//
//  SYExchangeCenter.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/20.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SY_changItem;

NS_ASSUME_NONNULL_BEGIN

@interface SYExchangeCenter : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *monkeyLbal;
@property (weak, nonatomic) IBOutlet UILabel *timeLanel;
@property (weak, nonatomic) IBOutlet UIButton *exchangeButton;
@property(strong,nonatomic)SY_changItem *item;
@property(copy,nonatomic)void(^buttonClick)(NSString *idString);



@end

NS_ASSUME_NONNULL_END
