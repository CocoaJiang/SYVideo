//
//  LoginCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "LoginCell.h"
#import "userInfo.h"

@implementation LoginCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.forgetButton setTitleColor:KappBlue forState:UIControlStateNormal];
    [self.loginButton setBackgroundColor:KappBlue];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bgView.layer.masksToBounds=YES;
    self.bgView.layer.cornerRadius=5;
    self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.borderWidth = 0.3f;
    self.loginButton.layer.masksToBounds=YES;
    self.loginButton.layer.cornerRadius=5;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)buttonClick:(UIButton *)sender {
    
    if ([self.phoneText.text isEmpty]) {
        [Tools showErrorWithString:self.phoneText.placeholder];
        return;
    }
    if (![self.phoneText.text isTelephone]) {
        [Tools showErrorWithString:@"请您填写正确的手机号码"];
        return;
    }
    if ([self.passWord.text isEmpty]) {
        [Tools showStatusWithString:self.passWord.placeholder];
        return;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.phoneText.text forKey:@"user_name"];
    [dict setObject:[NSString md5HexDigest:self.passWord.text] forKey:@"user_pwd"];
    [HttpTool POST:[SY_login getWholeUrl] param:dict success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        userInfo *info = [userInfo mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        SYUSERINFO *sy = [SYUSERINFO info];
        sy.userInfo = info;
        USERDEFAULT_SET_value(info.user_name, KUSER_NAME);
        USERDEFAULT_SET_value(info.user_code, KUSER_CODE);
        [[Tools viewController:self].navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
    } error:^(NSString *error) {
        
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}





@end
