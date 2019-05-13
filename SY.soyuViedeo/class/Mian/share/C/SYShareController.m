//
//  SYShareController.m
//  S.SouyunVideo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYShareController.h"
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>

@interface SYShareController()<UMSocialSharePageScrollViewDelegate>

@property(strong,nonatomic)UILabel *label;
@property(strong,nonatomic)UIButton *button;

@end



@implementation SYShareController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNAV];
    [self addUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inteverCodeChange) name:@"loginSuccess" object:nil];
}
-(void)setNAV{
    self.navigationItem.title = @"推广";
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
 return UIStatusBarStyleLightContent;
}
-(void)addUI{
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.text = @"推广";
    [titleLabel sizeToFit];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
        } else {
            make.top.mas_equalTo(self.view.mas_top).offset(10);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"erweimabg"]];
    imageView.frame = self.view.frame;
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    
    
    
    UILabel *label  = [[UILabel alloc]init];
    label.attributedText = [Tools ReturnWithString:@"邀请码:" andWithColor:RGBA(204, 204, 204, 1) andWithFont:14 andWithString:[Tools isNeedLogin]?[SYUSERINFO info].systemModel.inviteCode:USERREAD_object(KUSER_CODE) andWithColor:KAPPMAINCOLOR andWithFont:28];
    label.origin = CGPointMake(60, 150);
    [label sizeToFit];
    self.label = label;
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"复 制" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(label.right+10, 0, 70, 30);
    button.centerY = label.centerY;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 0.8f;
    button.backgroundColor = RGBA(255, 255, 255, 0.4);
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,button.bottom+20, SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
    [view makeBounsWithScrle:10];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    view.centerX = self.view.centerX;
    
    UIImageView *codeImageView = [[UIImageView alloc]init];
    [view addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(view).offset(5);
        make.bottom.right.mas_equalTo(view).offset(-5);
    }];
    codeImageView.image = [Tools imageWithUrl:[SYUSERINFO info].systemModel.shareURL imageSize:SCREEN_WIDTH/2-10];
    
    UILabel *loadLabel = [[UILabel alloc]init];
    loadLabel.textColor = [UIColor whiteColor];
    loadLabel.numberOfLines = 0;
    loadLabel.textAlignment  = NSTextAlignmentCenter;
    loadLabel.text = [NSString stringWithFormat:@"扫描上面二维码,下载APP\n官网地址%@",[SYUSERINFO info].systemModel.shareURL];
    loadLabel.font = [UIFont systemFontOfSize:12];
    loadLabel.frame = CGRectMake(view.left,view.bottom+5 ,view.width,0);
    [loadLabel sizeToFit];
    loadLabel.centerX = self.view.centerX;
    [self.view addSubview:loadLabel];
    
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame =  CGRectMake(30, loadLabel.bottom+30, SCREEN_WIDTH-60, 40);
    [saveButton setTitle:@"保存二维码" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton makeYuanWithScle:15];
    saveButton.backgroundColor = RGBA(24, 148, 235, 1);
    [saveButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.numberOfLines = 0;
    tipLabel.textAlignment  = NSTextAlignmentCenter;
    tipLabel.text = @"保存这张图到本地,如果遇到APP无法打开的情况下请扫描二维码或者输入官网地址重新下载APP即可";
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.frame = CGRectMake(saveButton.left,saveButton.bottom+2 ,saveButton.width,0);
    [tipLabel sizeToFit];
    tipLabel.centerX = self.view.centerX;
    [self.view addSubview:tipLabel];
    
    UIButton *invitationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    invitationButton.frame =  CGRectMake(30, saveButton.bottom+70, SCREEN_WIDTH-60, 40);
    [invitationButton setTitle:@"邀请好友注册" forState:UIControlStateNormal];
    invitationButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [invitationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [invitationButton makeYuanWithScle:15];
    invitationButton.backgroundColor = KAPPMAINCOLOR;
    [invitationButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:invitationButton];
    
    UILabel *pointLabel = [[UILabel alloc]init];
    pointLabel.textColor = [UIColor whiteColor];
    pointLabel.text = @"邀请好友双方都可以获得奖励哟!";
    pointLabel.font = [UIFont systemFontOfSize:12];
    pointLabel.frame = CGRectMake(invitationButton.left,invitationButton.bottom+2 ,0,0);
    [pointLabel sizeToFit];
    pointLabel.centerX = self.view.centerX;
    [self.view addSubview:pointLabel];
    
    
}
-(void)buttonClick:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"复 制"]) {
        UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
        pastboard.string = [Tools isNeedLogin]?[SYUSERINFO info].systemModel.inviteCode:USERREAD_object(KUSER_CODE);
        [Tools showSuccessWithString:@"复制成功"];
        return;
    }else if ([button.titleLabel.text isEqualToString:@"保存二维码"]){
        UIImage *image = [self captureImageFromView:self.view];
        [Tools saveImaheWihtImage:image];
        [self hideOrShowsomeSubViews:NO];
    }else{
        [self shareBtnClick];
    }
}

///通知这里发生改变。。。
-(void)inteverCodeChange{
     _label.attributedText = [Tools ReturnWithString:@"邀请码:" andWithColor:RGBA(204, 204, 204, 1) andWithFont:14 andWithString:[Tools isNeedLogin]?[SYUSERINFO info].systemModel.inviteCode:USERREAD_object(KUSER_CODE) andWithColor:KAPPMAINCOLOR andWithFont:28];
}


-(UIImage *)captureImageFromView:(UIView *)view{
    [self hideOrShowsomeSubViews:YES];
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size,NO, 0);
    [[UIColor clearColor] setFill];
    [[UIBezierPath bezierPathWithRect:self.view.bounds] fill];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)hideOrShowsomeSubViews:(BOOL)ishiden{
    for (id object in [self.view subviews]) {
        if ([object isKindOfClass:[UIButton class]]) {
            UIButton * button = (UIButton *)object;
            button.hidden=ishiden;
        }
        if ([object isKindOfClass:[UILabel class]]) {
            UILabel * label = (UILabel *)object;
            if ([label.text isEqualToString:@"推广"]) {
                label.hidden = ishiden;
            }
        }
    }
}

- (void)shareBtnClick
{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareToPlatformType:platformType dic:nil];
    }];
}




//分享到指定平台
- (void)shareToPlatformType:(UMSocialPlatformType)platformType dic:(NSDictionary *)dic {
    
    
    //创建分享消息对象
    
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建图片内容对象
   UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:@"白猫视频,全网免费" descr:@"立即下载,热门影视随心看" thumImage:[UIImage imageNamed:@"ic_logo4"]];
    webObject.webpageUrl = [SYUSERINFO info].systemModel.shareURL;
    messageObject.shareObject = webObject;
    
    if (![self isInstall:platformType]) {
        return ;
    }
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        ;
        //分享失败
        if (error) {
            
   //         [ZQHelper showErrorHint:error.localizedDescription];
            
        }else{
            
        }
    }];
}

#pragma mark 判断是否安装分享平台
- (BOOL)isInstall:(UMSocialPlatformType)platformType {
    
    return [[UMSocialManager defaultManager] isInstall:platformType];
}



@end
