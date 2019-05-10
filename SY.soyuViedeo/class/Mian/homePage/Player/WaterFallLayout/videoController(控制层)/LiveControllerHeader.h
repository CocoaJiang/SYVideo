//
//  LiveControllerHeader.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/24.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveControllerHeader : UIView
@property (weak, nonatomic) IBOutlet UIButton *leftbutton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property(copy,nonatomic)void(^buttonClick)(NSString *title);



@end

NS_ASSUME_NONNULL_END
