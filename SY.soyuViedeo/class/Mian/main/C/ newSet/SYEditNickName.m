//
//  SYEditNickName.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/6.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYEditNickName.h"

@interface SYEditNickName ()

@end

@implementation SYEditNickName

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    self.title = @"昵称";
    
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"确认" forState:UIControlStateNormal];
    
    button.size = CGSizeMake(50, 50);
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = item;
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 60)];
    
    textField.borderStyle = UITextBorderStyleNone;
    
    textField.placeholder =  @"昵称最多12位";
    
    textField.font = [UIFont systemFontOfSize:14];
    
    textField.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:textField];
    
    [self.view addSubview:view];
    
    
    __weak typeof(self)weakSelf = self;
    
    button.clickAction = ^(UIButton *button) {
      
        if ([textField.text isEmpty]) {
            
            [Tools showErrorWithString:@"请输入有效字符"];
            
            return ;
        }
        
        if ([textField.text length]>12) {
            
            [Tools showErrorWithString:@"超出有效长度"];
            
            return;
            
        }
        
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        
        [dict setObject:textField.text forKey:@"nickName"];
        
        [HttpTool POST:[SY_edit getWholeUrl] param:dict success:^(id responseObject) {
            
            [SYUSERINFO info].userInfo.user_nick_name = textField.text;
            
            [Tools showSuccess:[responseObject objectForKey:@"message"] andWithDoEveryThingWithBlock:^{
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        } error:^(NSString *error) {
            
        }];
        
    };
    

    
}



@end
