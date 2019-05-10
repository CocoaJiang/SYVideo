//
//  SYKeyBordInPutView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYKeyBordInPutView : UIView
@property (weak, nonatomic) IBOutlet UIButton *PJButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property(copy,nonatomic)void(^pjWithContent)(NSString *text);


@end

NS_ASSUME_NONNULL_END
