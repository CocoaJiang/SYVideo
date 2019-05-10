//
//  SYNewPassWorldORVerCodeInPutView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYNewPassWorldORVerCodeInPutView.h"
@implementation SYNewPassWorldORVerCodeInPutView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setsystem];
}

-(void)setsystem{
    self.vercodeButton.layer.borderColor = KappBlue.CGColor;
    self.vercodeButton.layer.borderWidth = 0.5f;
    [self.vercodeButton setTitleColor:KappBlue forState:UIControlStateNormal];
    self.textField.secureTextEntry=YES;
}

-(void)setType:(SYInputType)type{
    self.textField.text = @"";
    _type = type;
    if (_type==0) {
        _iconImageView.image = [UIImage imageNamed:@"mima"];
        self.isShowButton.hidden =NO;
        self.vercodeButton.hidden = YES;
        self.textField.placeholder = @"请输入密码";
    }else{
        _iconImageView.image = [UIImage imageNamed:@"yanzhma"];
        self.isShowButton.hidden =YES;
        self.vercodeButton.hidden = NO;
        self.textField.placeholder = @"请输入验证码";
    }
  
}
- (IBAction)buttonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.textField.secureTextEntry = !self.textField.isSecureTextEntry;
    
}
- (IBAction)sendCode:(UIButton *)sender {
    
    if (self.sendVerCode) {
        self.sendVerCode();
    }
}

@end
