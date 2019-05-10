//
//  SY_ForScreenController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/5.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SY_ForScreenController.h"
#import "SY_VoiceView.h"
#import "SY_ForScreenBootomView.h"
#import "SY_ForScreen_Controller.h"
#import <MRDLNA/MRDLNA.h>
#import "SYSeletedViewController.h"
#import "VideoPlayInfo.h"
#import <XWDatabase.h>
#import "ZFUtilities.h"
@interface SY_ForScreenController ()<DLNADelegate>
@property(strong,nonatomic)SY_VoiceView *voiceView;
@property(strong,nonatomic)SY_ForScreenBootomView *bootView;
@property(strong,nonatomic)SY_ForScreen_Controller *controllerView;
@property(strong,nonatomic)UILabel *label;
@property(nonatomic,strong) MRDLNA *dlnaManager;
@property(strong,nonatomic)SYSeletedViewController *seletedController;
@property(strong,nonatomic)VideoPlayInfo *videoPlayer;
@property(strong,nonatomic)CADisplayLink *disLink;
///定义开关变量
@property(assign,nonatomic)BOOL isOpen;
///改变位置的开关
@property(assign,nonatomic)BOOL isChange;



@end

@implementation SY_ForScreenController


-(void)viewWillAppear:(BOOL)animated{
    [self timeAction];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addView];
    self.isOpen = NO;
    self.isChange = YES;
    self.dlnaManager = [MRDLNA sharedMRDLNAManager];
    [self.dlnaManager startDLNA];
    self.dlnaManager.delegate = self;
    ////拿到信息。。。 此时一定有信息。。。。。。。。。。。。。。。。....
    [self.dlnaManager addObserver:self forKeyPath:@"currTime" options:NSKeyValueObservingOptionNew context:nil];
    self.videoPlayer = [[VideoPlayInfo alloc] init];
    self.videoPlayer.FLDBID = self.video_id;
    [XWDatabase getModel:self.videoPlayer identifier:self.video_id completion:^(id  _Nullable obj) {
        self.videoPlayer = obj;
        NSString *string = [NSString string];
        switch (self.videoPlayer.playClear) {
            case 1:
                string = @"标清";
                break;
            case 2:
                string = @"高清";
                break;
            case 3:
                string = @"超清";
                break;
            case 4:
                string  = @"1080P";
                break;
            default:string = @"标清";
                break;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.controllerView.clearButton setTitle:string forState:UIControlStateNormal];
        });
    }];
    
    
}
-(void)getInfoWithCurrTime:(CGFloat)currtime andWithTotalTime:(CGFloat)totoaTime{
    if (!self.isOpen) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *currentTimeString = [ZFUtilities convertTimeSecond:currtime];
            NSString *totoaTimeString = [ZFUtilities convertTimeSecond:totoaTime];
            CGFloat progress = 0.0;
            if (currtime!=0 && totoaTime!=0) {
                progress = currtime/totoaTime;
            }
            [self.bootView setCurrTime:currentTimeString andTotal:totoaTimeString andWithProgress:progress];
        });
    }
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if (self.isChange) {
        self.seletedController.view.frame = CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 250);
    }
}
////首先清晰度。。。。。。。。。。。。。。。.......................................................................
-(void)addView{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_airLan_bg"]];
    [imageView sizeToFit];
    UILabel *label  = [[UILabel alloc]init];
    label.textColor = [UIColor whiteColor];
    label.text = self.deviceModel.friendlyName;
    [imageView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.mas_centerX);
        make.centerY.mas_equalTo(imageView.mas_centerY);
    }];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.view addSubview:self.voiceView];
    [self.voiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
        make.size.mas_equalTo(CGSizeMake(40, 120));
    }];
    [self.view addSubview:self.bootView];
    [self.bootView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-40);
        }else{
             make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        }
        make.height.mas_equalTo(@50);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-40);
    }];
    [self.view addSubview:self.controllerView];
    [self.controllerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bootView.mas_top).offset(-10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(270, 40));
    }];
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    [self addChildViewController:self.seletedController];
    [self.view addSubview:self.seletedController.view];
    
    
}
-(SY_VoiceView *)voiceView{
    if (!_voiceView) {
        _voiceView = [[SY_VoiceView alloc]init];
        _voiceView.backgroundColor = RGBA(38, 38, 38, 1);
        __weak typeof(self)weakSelf = self;
        _voiceView.voiceAddOrReduction = ^(BOOL isAdd) {
            if (isAdd) {
                CGFloat voice  = weakSelf.dlnaManager.voice+=0.1;
                [weakSelf.dlnaManager volumeChanged:[NSString stringWithFormat:@"%f",voice]];
            }else{
                CGFloat voice  = weakSelf.dlnaManager.voice-=0.1;
                [weakSelf.dlnaManager volumeChanged:[NSString stringWithFormat:@"%f",voice]];
            }
            
        };
    }
    return _voiceView;
}
-(SY_ForScreenBootomView *)bootView{
    if (!_bootView) {
        _bootView = [[SY_ForScreenBootomView alloc]init];
        __weak typeof(self)weakSelf = self;
        _bootView.playOrPause = ^(BOOL playOrPause) {
            if (playOrPause) {
                [weakSelf.dlnaManager dlnaPlay];
            }else{
                 [weakSelf.dlnaManager dlnaPause];
            }
            
        };
        _bootView.playValue = ^(float playValue) {
            weakSelf.isOpen = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.isOpen = NO;
            });
            NSInteger sec = playValue * 60 * 60;
            [weakSelf.dlnaManager seekChanged:sec];
        };
        
        
    }
    return _bootView;
}
-(SY_ForScreen_Controller *)controllerView{
    if (!_controllerView) {
        _controllerView =  [Tools XJ_XibWithName:@"SY_ForScreen_Controller"];
        _controllerView.backgroundColor = RGBA(38, 38, 38, 1);
        __weak typeof(self)weakSelf  = self;
        _controllerView.exitButton.clickAction = ^(UIButton *button) {
             [weakSelf.dlnaManager endDLNA];
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                if (weakSelf.back) {
                    weakSelf.back();
                }
            }];
        };
        _controllerView.clearButton.clickAction = ^(UIButton *button) {
            self.isChange = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.seletedController.view.frame = CGRectMake(0, SCREENH_HEIGHT-250, SCREEN_WIDTH, SCREENH_HEIGHT);
            }];
        };
        
        _controllerView.changDevicesButton.clickAction = ^(UIButton *button) {
            [weakSelf.dlnaManager endDLNA];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        };
        
        
        
    }
    return _controllerView;
}
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textColor = RGBA(38, 38, 38, 1);
        _label.font = [UIFont systemFontOfSize:14];
        _label.text = @"正在投屏";
    }
    return _label;
}
#pragma mark - 屏幕旋转。。。
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
  return UIInterfaceOrientationLandscapeRight;
}
- (BOOL)shouldAutorotate
{
    return NO;
}
#pragma mark  -  delegte and dataSources





-(SYSeletedViewController *)seletedController{
    if (!_seletedController) {
        _seletedController = [[SYSeletedViewController alloc]init];
        __weak typeof(self)weakSelf =self;
        _seletedController.cancel = ^{
            [weakSelf disMiss];
        };
        
        _seletedController.choseCell = ^(NSString * _Nonnull clearString, NSInteger index) {

            [weakSelf.controllerView.clearButton setTitle:clearString forState:index];
            
            [weakSelf disMiss];
            
            //去绝对值
             NSInteger index_clear =labs(index-4);
            
            //再去请求。。
            
            [weakSelf getPlayUrlWithString:index_clear];
            
            
            
            
        };
        
     
    }
    return _seletedController;
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self disMiss];
}
-(void)disMiss{
    self.isChange = YES;
    if (self.seletedController.view.frame.origin.y==SCREENH_HEIGHT) return;
    [UIView animateWithDuration:0.3 animations:^{
        self.seletedController.view.frame = CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 250);

    }];
}

////创建定时器定时会掉信息
-(void)timeAction{

    // 创建CADisplayLink
    self.disLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkMethod)];
    // 添加至RunLoop中
    [_disLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
   
}

-(void)linkMethod{
    [self.dlnaManager getInfo];
}
-(void)viewWillDisappear:(BOOL)animated{
    // 终止定时器
    [_disLink invalidate];
    // 销毁对象
    _disLink = nil;
}


#pragma mark - 向服务器索要播放地址
-(void)getPlayUrlWithString:(NSInteger) index {
    //简单的对播放器处理
    ///拼装字符串。。
    
    CGFloat value = self.bootView.slider.value;
    
    NSString *setString = self.model.info.url[self.videoPlayer.playTheSource].list[self.videoPlayer.playTheSet].url;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:setString forKey:@"url"];
    [dict setObject:@(index) forKey:@"hd"];
    SYUSERINFO *system = [SYUSERINFO info];
    __weak typeof(self)weakSelf = self;
    [HttpTool POST:system.systemModel.vod_parse_url[0] param:dict success:^(id responseObject) {
        NSString *url = [[responseObject objectForKey:@"data"] objectForKey:@"url"];
        NSString *URLString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [weakSelf.dlnaManager playTheURL:URLString];
        ///然后跳转到指定的位置。。。。。。。。。。。
        NSInteger sec = value * 60 * 60;
        [weakSelf.dlnaManager seekChanged:sec];
        
        
    } error:^(NSString *error) {
        
    }];
}


@end
