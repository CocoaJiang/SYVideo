//
//  SYMonkeyTopView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/16.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYMonkeyTopView : UIView
@property (weak, nonatomic) IBOutlet UILabel *disLanel;
@property (weak, nonatomic) IBOutlet UILabel *monkeyLabel;
@property (weak, nonatomic) IBOutlet UIButton *makeMonkeyButton;
-(void)setCoinsWithCoins:(NSString *)coins;

@end

NS_ASSUME_NONNULL_END
