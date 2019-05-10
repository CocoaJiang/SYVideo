//
//  SYNewPassWorldORVerCodeInPutView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SYInputType){
    PassWorld=0,
    VerCode=1,
};


NS_ASSUME_NONNULL_BEGIN

@interface SYNewPassWorldORVerCodeInPutView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *isShowButton;
@property (weak, nonatomic) IBOutlet UIButton *vercodeButton;
@property(assign,nonatomic)SYInputType type;
@property(copy,nonatomic)dispatch_block_t sendVerCode;


@end

NS_ASSUME_NONNULL_END
