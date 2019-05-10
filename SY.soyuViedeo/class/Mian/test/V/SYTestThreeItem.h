//
//  SYTestThreeItem.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/20.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYTestThreeItem : UIView
@property (weak, nonatomic) IBOutlet UIButton *invatebutton;
@property (weak, nonatomic) IBOutlet UIButton *monkeyButton;
@property (weak, nonatomic) IBOutlet UIButton *qiandaoButton;
@property(copy,nonatomic)void(^buttonClick)(NSInteger index);
-(void)addDataWithInvateButtonCount:(NSString *)intvateCount andWithMonkey:(NSString *)MonkeyCount andWithQianDaoDays:(NSString *)daysCount;
@end

NS_ASSUME_NONNULL_END
