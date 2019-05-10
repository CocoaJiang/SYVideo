//
//  RegisAcountCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "RegisAcountCell.h"
#import "UIButton+VerificationCode.h"
#import "SYLoginController.h"


@interface RegisAcountCell ()<UITextFieldDelegate>

@end

@implementation RegisAcountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.regisButton setBackgroundColor:KappBlue];
    [self.regisButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bgView.layer.masksToBounds=YES;
    self.bgView.layer.cornerRadius=5;
    self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.borderWidth = 0.3f;
    self.regisButton.layer.masksToBounds=YES;
    self.regisButton.layer.cornerRadius=5;
    self.sendVerCodeButton.layer.masksToBounds=YES;
    self.sendVerCodeButton.layer.cornerRadius=3;
    [self.sendVerCodeButton setBackgroundColor:KappBlue];
    [self.sendVerCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.readbutton setImage:[UIImage imageNamed:@"多选_未选中"] forState:UIControlStateNormal];
    [self.readbutton setImage:[UIImage imageNamed:@"多选_选中"] forState:UIControlStateSelected];
    [self.xieyibutton setTitleColor:KappBlue forState:UIControlStateNormal];
    self.regisButton.userInteractionEnabled=NO;
    self.regisButton.alpha=0.4;
    self.sendVerCodeButton.enabled=NO;
    self.sendVerCodeButton.alpha=0.4;
    self.vercode.delegate=self;
    [self.phonetextfield addTarget:self action:@selector(textContentChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.vercode addTarget:self action:@selector(textContentChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.passWordTextfield addTarget:self action:@selector(textContentChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.regisButton addTarget:self action:@selector(regis) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (IBAction)readClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.regisButton.userInteractionEnabled=sender.selected;
    if (sender.selected) {
        self.regisButton.alpha=1;
    }else{
        self.regisButton.alpha=0.4;
    }
}
- (IBAction)looktext:(UIButton *)sender {
}

-(void)textContentChanged:(UITextField*)textField{
    if (textField==self.phonetextfield) {
        if ([textField.text length]==11) {
            self.sendVerCodeButton.alpha=1;
            self.sendVerCodeButton.enabled=YES;
            //第一个输入框满足。。
        }else{
            self.sendVerCodeButton.alpha=0.4;
            self.sendVerCodeButton.enabled=NO;
        }
    }
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.vercode) {
        if ([self.phonetextfield.text length]<10) {
            return NO;
        }
        return YES;
    }
    return YES;
}

- (IBAction)senVerCode:(UIButton *)sender {
    
    if (![self.phonetextfield.text isTelephone]) {
        [Tools showErrorWithString:@"手机号有误"];
        return;
    }
    //成为第一响应者。。。
    //开始发送验证码！
    [sender startCountDown];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.phonetextfield.text forKey:@"mobile"];
    [HttpTool POST:[SY_smsCode getWholeUrl] param:dict success:^(id responseObject) {
        [Tools showStatusWithString:@"短信已发出,请注意查收"];
        [self.vercode becomeFirstResponder];
    } error:^(NSString *error) {
        NSLog(@"%@",error.localizedLowercaseString);
    }];
}

-(void)regis{
    //判断
    if ([self.phonetextfield.text isEmpty]) {
        [Tools showErrorWithString:self.phonetextfield.placeholder];
        return;
    }
    if (![self.phonetextfield.text isTelephone]) {
        [Tools showErrorWithString:@"请您填写正确的手机号码"];
        return;
    }
    if ([self.vercode.text isEmpty]) {
        [Tools showErrorWithString:self.vercode.placeholder];
        return;
    }
    if ([self.passWordTextfield.text isEmpty]) {
        [Tools showErrorWithString:self.passWordTextfield.placeholder];
        return;
    }
    if ([self.passWordTextfield.text length]<6) {
        [Tools showErrorWithString:@"密码过短不规范"];
        return;
    }
    if ([self.passWordTextfield.text length]>12) {
        [Tools showErrorWithString:@"密码过长不规范"];
        return;
    }
    //如果都满足的话 去注册！
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.vercode.text forKey:@"code"];
    [dict setObject:self.phonetextfield.text forKey:@"user_name"];
  //  NSString *md5String = [self.phonetextfield.text md5HexDigest];
    [dict setObject:[NSString md5HexDigest:self.passWordTextfield.text] forKey:@"user_pwd"];
    [HttpTool POST:[SY_register getWholeUrl] param:dict success:^(id responseObject) {
        //注册成功跳转到个人中心。。。
        [[Tools viewController:self].navigationController popViewControllerAnimated:YES];
        
        
        
    } error:^(NSString *error) {
        NSLog(@"%@",error.localizedLowercaseString);
    }];
    
    
    
    

    
}


@end
