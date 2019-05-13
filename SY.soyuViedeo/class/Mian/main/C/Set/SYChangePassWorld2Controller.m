//
//  SYChangePassWorld2Controller.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYChangePassWorld2Controller.h"
#import "UIButton+VerificationCode.h"
#import "SYLoginPhoneInputView.h"

@interface SYChangePassWorld2Controller ()
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UITextField *verCode;
@property (weak, nonatomic) IBOutlet UIButton *sendVarButton;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButtom;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIView *bootomLine;
@property(strong,nonatomic)SYLoginPhoneInputView *inPutView;
@property (weak, nonatomic) IBOutlet UILabel *titleTipLabel;



@end

@implementation SYChangePassWorld2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type==0) {
        self.title = @"修改密码";
    }else if (self.type==1){
        self.title = @"更换手机号码";
    }else{
        self.title = @"验证手机号";
    }
    [self setSystem];
}

-(void)setSystem{
    NSString *numberString =self.type==2?[Tools returnBankCard:self.phone]:[Tools returnBankCard:USERREAD_object(KUSER_NAME)];
    self.number.text = [NSString stringWithFormat:@"+86  %@",numberString];
    self.sendVarButton.layer.borderColor = KAPPMAINCOLOR.CGColor;
    self.sendVarButton.layer.borderWidth = 0.4f;
    self.nextButtom.backgroundColor = KAPPMAINCOLOR;
    self.nextButtom.layer.cornerRadius = 5;
    self.nextButtom.layer.masksToBounds = YES;
    self.passWordTextField.secureTextEntry = YES;
    [self.sendVarButton setTitleColor:KAPPMAINCOLOR forState:UIControlStateNormal];
    
    if (self.type==changPhone) {
        self.tipLabel.text = @"新手机号码";
        self.showButton.hidden = self.bootomLine.hidden = self.passWordTextField.hidden = YES;
        [self.view addSubview:self.inPutView];
        [self.inPutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.passWordTextField.mas_top);
            make.height.mas_equalTo(@50);
        }];
    }else if (self.type==yanzheng){
        self.showButton.hidden = self.bootomLine.hidden = self.passWordTextField.hidden =self.tipLabel.hidden=YES;
    }
    
    
}


- (IBAction)buttonClick:(UIButton *)sender {
    if (sender==self.showButton) {
        self.showButton.selected = !self.showButton.selected;
        self.passWordTextField.secureTextEntry = !self.showButton.selected;
        return;
    }
    if (sender==self.sendVarButton) {
        [self.sendVarButton startCountDown];
        //发送验证码接口
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:USERREAD_object(KUSER_NAME) forKey:@"mobile"];
        [HttpTool POST:[SY_smsCode getWholeUrl] param:dict success:^(id responseObject) {
            [Tools showErrorWithString:@"短信发送成功,请您注意查收"];
        } error:^(NSString *error) {
        }];
    }else{
        if (self.type==0) {
            if ([self.verCode.text isEmpty]) {
                [Tools showErrorWithString:@"请输入验证码"];
            }
            if ([self.passWordTextField.text isEmpty]) {
                [Tools showErrorWithString:@"请输入密码"];
                return;
            }
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:USERREAD_object(KUSER_NAME) forKey:@"mobile"];
            [dict setObject:[NSString md5HexDigest:self.passWordTextField.text] forKey:@"password"];
            [dict setObject:self.verCode.text forKey:@"code"];
            __weak typeof(self)weakSelf = self;
            [HttpTool POST:[SY_edit getWholeUrl] param:dict success:^(id responseObject) {
                [Tools showSuccess:[responseObject objectForKey:@"message"] andWithDoEveryThingWithBlock:^{
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }];
            } error:^(NSString *error) {
                
            }];
        }else if (self.type==1){
            if ([self.verCode.text isEmpty]) {
                [Tools showErrorWithString:@"请输入验证码"];
            }
            if ([self.inPutView.textField.text isEmpty]) {
                [Tools showErrorWithString:@"请输入新手机号码"];
                return;
            }
            if (![self.inPutView.textField.text isTelephone]) {
                [Tools showErrorWithString:@"输入的手机号不正确"];
                return;
            }
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:self.inPutView.textField.text forKey:@"mobile"];
            [dict setObject:self.verCode.text forKey:@"code"];
            [dict setObject:@(self.type) forKey:@"step"];//第一步旧的手机号 ！第二部新的手机号
            [HttpTool POST:[SY_edit getWholeUrl] param:dict success:^(id responseObject) {
                SYChangePassWorld2Controller *controller = [[SYChangePassWorld2Controller alloc]init];
                controller.phone = self.inPutView.textField.text;
                controller.type = yanzheng;
                [self.navigationController pushViewController:controller animated:YES];
            } error:^(NSString *error) {
                
            }];
            
        }else{
            //第二部的时候
            if ([self.verCode.text isEmpty]) {
                [Tools showErrorWithString:@"请输入验证码"];
            }
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:self.phone forKey:@"mobile"];
            [dict setObject:self.verCode.text forKey:@"code"];
            [dict setObject:@(self.type) forKey:@"step"];//第一步旧的手机号 ！第二部新的手机号
            __weak typeof(self)weakSelf = self;
            [HttpTool POST:[SY_edit getWholeUrl] param:dict success:^(id responseObject) {
                [Tools showSuccess:[responseObject objectForKey:@"message"] andWithDoEveryThingWithBlock:^{
                    USERDEFAULT_SET_value(self.phone, KUSER_NAME);
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }];
            } error:^(NSString *error) {
                
            }];
            
        }
        }

        
    
}
-(SYLoginPhoneInputView *)inPutView{
    if (!_inPutView) {
        _inPutView = [Tools XJ_XibWithName:@"SYLoginPhoneInputView"];
    }
    return _inPutView;
}



@end
