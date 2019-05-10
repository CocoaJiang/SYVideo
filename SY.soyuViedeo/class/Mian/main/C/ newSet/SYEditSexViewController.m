//
//  SYEditSexViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/6.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYEditSexViewController.h"

#import "SYEditSexViewView.h"

@interface SYEditSexViewController ()

@property(strong,nonatomic)SYEditSexViewView *boyView;

@property(strong,nonatomic)SYEditSexViewView *girlView;



@end

@implementation SYEditSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"性别";
    
    
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"确认" forState:UIControlStateNormal];
    
    button.size = CGSizeMake(50, 50);
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.boyView];
    
    [self.boyView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.mas_equalTo(self.view);
        
        make.height.mas_equalTo(@55);
        
    }];
    
    [self.view addSubview:self.girlView];
    
    [self.girlView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(self.view);
        
        make.height.mas_equalTo(@55);
        
        make.top.mas_equalTo(self.boyView.mas_bottom).offset(1);
        
    }];
    
    UILabel *label = [[UILabel alloc]init];
    
    label.font = [UIFont systemFontOfSize:12];
    
    label.text = @"性别只可设置一次,设置后不可修改";
    
    label.textColor = [UIColor darkGrayColor];
    
    [self.view addSubview:label];
    
    [label sizeToFit];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        
        make.top.mas_equalTo(self.girlView.mas_bottom).offset(10);
        
    }];
    
    self.boyView.seletedButton.clickAction = ^(UIButton *button) {
        if (button.selected) {
            return ;
        }else{
            if (self.girlView.seletedButton.selected) {
                self.girlView.seletedButton.selected = NO;
            }
            button.selected = YES;
        }
    };
    
    self.girlView.seletedButton.clickAction = ^(UIButton *button) {
        if (button.selected) {
            return ;
        }else{
            if (self.boyView.seletedButton.selected) {
                self.boyView.seletedButton.selected = NO;
            }
             button.selected = YES;
        }
    };
    
    
    if ([[SYUSERINFO info].userInfo.user_sex intValue]==1) {
        
        self.boyView.seletedButton.selected = YES;
        
    }else if([[SYUSERINFO info].userInfo.user_sex intValue]==2){
        
        self.girlView.seletedButton.selected = YES;
        
    }else{
        
        self.boyView.seletedButton.selected = self.girlView.seletedButton.selected = NO;
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    __weak typeof(self)weakSelf = self;
    
    button.clickAction = ^(UIButton *button) {
      
        SYUSERINFO *USER = [SYUSERINFO info];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        
        if (weakSelf.boyView.seletedButton.selected) {
            [dict setObject:@(1) forKey:@"sex"];
            USER.userInfo.user_sex = @"1";
        }else{
            [dict setObject:@(2) forKey:@"sex"];
            USER.userInfo.user_sex = @"2";
        }
        
        [HttpTool POST:[SY_edit getWholeUrl] param:dict success:^(id responseObject) {
            
            [Tools showSuccess:[responseObject objectForKey:@"message"] andWithDoEveryThingWithBlock:^{
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        } error:^(NSString *error) {
            
        }];
        
        
    };
    

}


-(SYEditSexViewView *)boyView{
    if (!_boyView) {
        _boyView = [Tools XJ_XibWithName:@"SYEditSexViewView"];
        _boyView.sexLabel.text = @"男";
    }
    return _boyView;
}

-(SYEditSexViewView *)girlView{
    if (!_girlView) {
        _girlView = [Tools XJ_XibWithName:@"SYEditSexViewView"];
        _girlView.sexLabel.text = @"女";
    }
    return _girlView;
}


@end
