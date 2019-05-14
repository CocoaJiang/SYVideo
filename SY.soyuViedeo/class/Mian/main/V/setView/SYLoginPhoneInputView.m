//
//  SYLoginPhoneInputView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYLoginPhoneInputView.h"

@implementation SYLoginPhoneInputView

-(void)awakeFromNib{
    [super awakeFromNib];
    _buttton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _textField.font = [UIFont systemFontOfSize:14];
}

@end
