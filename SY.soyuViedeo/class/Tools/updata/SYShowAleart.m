//
//  SYShowAleart.m
//  SY.souyunVideo
//
//  Created by 搜云 on 2019/5/21.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYShowAleart.h"
#import "SYupdataView.h"


@interface SYShowAleart ()

@property(strong,nonatomic)SYupdataView *updataView;

@end

@implementation SYShowAleart


-(instancetype)initWithFrame:(CGRect)frame andWithType:(AlearType)type{
    self.type = type;
    return [self initWithFrame:frame];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
        
        [self addSubview:self.updataView];
        
        [self.updataView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.size.mas_equalTo(CGSizeMake(299, 404));
            
            make.centerY.mas_equalTo(self.mas_centerY);
            
            make.centerX.mas_equalTo(self.mas_centerX);
            
        }];
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        
        [window addSubview:self];

    }
    return self;
}

-(SYupdataView *)updataView{
    if (!_updataView) {
        _updataView = [Tools XJ_XibWithName:@"SYupdataView"];
        __weak typeof(self)weakSelf  = self;
        _updataView.cancelButton.clickAction = ^(UIButton *button) {
            [weakSelf dissMiss];
        };
         SYUSERINFO *system = [SYUSERINFO info];
        _updataView.sureButton.clickAction = ^(UIButton *button) {
            [weakSelf dissMiss];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:system.systemModel.app_version[@"url"]] options:@{} completionHandler:^(BOOL success) {
            }];
        };
        _updataView.textField.text =system.systemModel.app_version[@"content"];
        
        
    }
    return _updataView;
}

-(void)dissMiss{
    [self.updataView removeFromSuperview];
    [self removeFromSuperview];
}


@end
