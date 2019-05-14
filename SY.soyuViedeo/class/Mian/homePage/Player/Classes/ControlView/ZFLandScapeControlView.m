//
//  ZFLandScapeControlView.m
//  ZFPlayer
//
// Copyright (c) 2016年 任子丰 ( http://github.com/renzifeng )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ZFLandScapeControlView.h"
#import "UIView+ZFFrame.h"
#import "ZFUtilities.h"
#import "ZFPlayer.h"

#define buttontag 100861100


@interface ZFLandScapeControlView () <ZFSliderViewDelegate,UIGestureRecognizerDelegate>

/// 顶部工具栏
@property (nonatomic, strong) UIView *topToolView;
/// 返回按钮
@property (nonatomic, strong) UIButton *backBtn;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 底部工具栏
@property (nonatomic, strong) UIView *bottomToolView;
/// 播放或暂停按钮
@property (nonatomic, strong) UIButton *playOrPauseBtn;
/// 播放的当前时间 
@property (nonatomic, strong) UILabel *currentTimeLabel;
/// 滑杆
@property (nonatomic, strong) ZFSliderView *slider;
/// 视频总时间
@property (nonatomic, strong) UILabel *totalTimeLabel;
/// 锁定屏幕按钮
@property (nonatomic, strong) UIButton *lockBtn;

@property (nonatomic, assign) BOOL isShow;


@end

@implementation ZFLandScapeControlView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KVEYSTRING object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.topToolView];
        [self.topToolView addSubview:self.backBtn];
        [self.topToolView addSubview:self.titleLabel];
        [self.topToolView addSubview:self.playerVideoSetBtn];
        [self.topToolView addSubview:self.shareButton];
        [self.topToolView addSubview:self.forScreenBtn];
        [self addSubview:self.bottomToolView];
        [self.bottomToolView addSubview:self.currentTimeLabel];
        [self.bottomToolView addSubview:self.slider];
        [self.bottomToolView addSubview:self.totalTimeLabel];
        [self.bottomToolView addSubview:self.playOrPauseBtn];
        [self.bottomToolView addSubview:self.nextSetBtn];
        [self.bottomToolView addSubview:self.danShowOrHindeBtn];
        [self.bottomToolView addSubview:self.danSettingBtn];
        [self.bottomToolView addSubview:self.choseSet];
        [self.bottomToolView addSubview:self.clearfloat];
        [self.bottomToolView addSubview:self.playTimes];
        [self.bottomToolView addSubview:self.textField];
        [self addSubview:self.lockBtn];
        [self makeSubViewsAction];
        [self resetControlView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layOutControllerViews) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afNetworkStatusChanged:) name:KVEYSTRING object:nil];

        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.bounds.size.width;
    CGFloat min_view_h = self.bounds.size.height;
    
    CGFloat min_margin = 9; 
    
    
    //上面的按钮
    min_x = 0;
    min_y = 0;
    min_w = min_view_w;
    min_h = iPhoneX ? 110 : 80;
    self.topToolView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    //上面的返回按钮
    min_x = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 44: 15;
    min_y = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 15: (iPhoneX ? 40 : 20);
    min_w = 40;
    min_h = 40;
    self.backBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    //上面三个按钮的设置
    min_x = self.topToolView.zf_width - min_w - ((iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 44: min_margin);
    self.playerVideoSetBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.playerVideoSetBtn.centerY = self.backBtn.centerY;
    
    min_x = self.playerVideoSetBtn.left-min_w-5;
    self.shareButton.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.shareButton.centerY = self.backBtn.centerY;
    
    min_x = self.shareButton.left-min_w-5;
    self.forScreenBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.forScreenBtn.centerY = self.backBtn.centerY;
    
    
    //返回右边的标题
    min_x = self.backBtn.zf_right + 5;
    min_y = 0;
    min_w = self.width-self.backBtn.right - self.forScreenBtn.width;
    min_h = 30;
    self.titleLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.titleLabel.zf_centerY = self.backBtn.zf_centerY;
    
    min_h = 73;
    min_h = iPhoneX ? 100 : 73;
    min_x = 0;
    min_y = min_view_h - min_h;
    min_w = min_view_w;
    self.bottomToolView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    //分行显示
    min_x = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 44: 15;
    min_y = 5;
    min_w = 62;
    min_h = 30;
    self.currentTimeLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
    min_w = 70;
    min_x = self.bottomToolView.zf_width - min_w - ((iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 44: min_margin);
    min_y = 0;
    min_h = 30;
    self.totalTimeLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.totalTimeLabel.zf_centerY = self.currentTimeLabel.zf_centerY;
    min_x = self.currentTimeLabel.zf_right + 4;
    min_y = 0;
    min_w = self.totalTimeLabel.zf_left - min_x - 4;
    min_h = 30;
    self.slider.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.slider.zf_centerY = self.currentTimeLabel.zf_centerY;
    //需要向上调整
    min_x = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 44: 15;
    min_y = self.currentTimeLabel.bottom+4;
    min_w = 30;
    min_h = 30;
    self.playOrPauseBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    //下一集
    min_w = 50;
    min_x = self.playOrPauseBtn.right+5;
    self.nextSetBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    //弹幕开关
    min_x = self.nextSetBtn.right+5;
    self.danShowOrHindeBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    //弹幕设置
    min_x = self.danShowOrHindeBtn.right+5;
    self.danSettingBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    if (self.isMoive) {
        min_x = self.totalTimeLabel.right;
        self.choseSet.frame = CGRectMake(min_x, min_y, min_w, min_h);
    }else{
        min_x = self.totalTimeLabel.right-5-min_w;
        self.choseSet.frame = CGRectMake(min_x, min_y, min_w, min_h);
    }
    //清晰度
    min_x = self.choseSet.left-5-min_w;
    self.clearfloat.frame = CGRectMake(min_x, min_y, min_w, min_h);
    //倍速
    min_x = self.clearfloat.left-5-min_w;
    self.playTimes.frame = CGRectMake(min_x, min_y, min_w, min_h);
    //输入框
    min_x = self.danSettingBtn.right+5;
    min_w = self.playTimes.left-5-self.danSettingBtn.right-5;
    self.textField.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = (iPhoneX && self.player.orientationObserver.fullScreenMode == ZFFullScreenModeLandscape) ? 50: 18;
    min_y = 0;
    min_w = 40;
    min_h = 40;
    self.lockBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.lockBtn.zf_centerY = self.zf_centerY;
    

    //布置这个选集的试图
    min_x = self.width;
    min_y = 0;
    min_w = self.width;
    min_h  = self.height;
 //   self.videoPlayerController.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    
    

    if (!self.isShow) {
        //意思就是向下移动了！
        self.topToolView.zf_y = -self.topToolView.zf_height;
        self.bottomToolView.zf_y = self.zf_height;
    } else {
        if (self.player.isLockedScreen) { //锁屏
            self.topToolView.zf_y = -self.topToolView.zf_height;
            self.bottomToolView.zf_y = self.zf_height;
        } else { //回归正常位置
            self.topToolView.zf_y = 0;
            self.bottomToolView.zf_y = self.zf_height - self.bottomToolView.zf_height;
        }
    }
    
    
    
    
}

- (void)makeSubViewsAction {
    [self.backBtn addTarget:self action:@selector(backBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playOrPauseBtn addTarget:self action:@selector(playPauseButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.lockBtn addTarget:self action:@selector(lockButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    //个人写的Button的点击事件
    [self.danShowOrHindeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.clearfloat addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.playTimes addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.playerVideoSetBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.forScreenBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.danSettingBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.choseSet addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    /*
     choseClear=0, //选择清晰度
     chosePlaytimes=1,//选择播放速度
     playset=2,//展开设置
     playShare=3,//展开分享
     choseSet=4,//选集
     */
    self.clearfloat.tag   = buttontag+0;
    self.playTimes.tag = buttontag+1;
    self.playerVideoSetBtn.tag = buttontag+2;
    self.shareButton.tag = buttontag+3;
    self.choseSet.tag = buttontag+4;
    

    

}




-(void)buttonClick:(UIButton *)button{
    if (self.type==ZFLandScapeControlViewVideo) {
        if (button==self.danShowOrHindeBtn) {
            button.selected = !button.selected;
        }else if (button==self.choseSet||button==self.clearfloat||button==self.playTimes||button==self.playerVideoSetBtn||button==self.shareButton){
            [self hideControlView];
            if (self.buttonClick) {
                self.buttonClick(button.tag-buttontag);
            }
        }else if (button == _forScreenBtn){
            [self backBtnClickAction:self.backBtn];
            if (self.forsecreen) {
                self.forsecreen();
            }
            
        }
    }else{
        if (self.doController) {
            self.doController(button.titleLabel.text);
        }
    }
}

- (void)layOutControllerViews {
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

#pragma mark - ZFSliderViewDelegate

- (void)sliderTouchBegan:(float)value {
    self.slider.isdragging = YES;
}

- (void)sliderTouchEnded:(float)value {
    if (self.player.totalTime > 0) {
        @weakify(self)
        [self.player seekToTime:self.player.totalTime*value completionHandler:^(BOOL finished) {
            @strongify(self)
            if (finished) {
                self.slider.isdragging = NO;
            }
        }];
        if (self.seekToPlay) {
            [self.player.currentPlayerManager play];
        }
    } else {
        self.slider.isdragging = NO;
    }
    if (self.sliderValueChanged) self.sliderValueChanged(value);
}

- (void)sliderValueChanged:(float)value {
    if (self.player.totalTime == 0) {
        self.slider.value = 0;
        return;
    }
    self.slider.isdragging = YES;
    NSString *currentTimeString = [ZFUtilities convertTimeSecond:self.player.totalTime*value];
    self.currentTimeLabel.text = currentTimeString;
    
    if (self.sliderValueChanging) self.sliderValueChanging(value,self.slider.isForward);
}

- (void)sliderTapped:(float)value {
    if (self.player.totalTime > 0) {
        self.slider.isdragging = YES;
        @weakify(self)
        [self.player seekToTime:self.player.totalTime*value completionHandler:^(BOOL finished) {
            @strongify(self)
            if (finished) {
                self.slider.isdragging = NO;
                [self.player.currentPlayerManager play];
            }
        }];
    } else {
        self.slider.isdragging = NO;
        self.slider.value = 0;
    }
}

#pragma mark -

/// 重置ControlView
- (void)resetControlView {
    self.slider.value                = 0;
    self.slider.bufferValue          = 0;
    self.currentTimeLabel.text       = @"00:00";
    self.totalTimeLabel.text         = @"00:00";
    self.backgroundColor             = [UIColor clearColor];
    self.playOrPauseBtn.selected     = YES;
    self.titleLabel.text             = @"";
    self.topToolView.alpha           = 1;
    self.bottomToolView.alpha        = 1;
    self.isShow                      = NO;
}

- (void)showControlView {
    self.lockBtn.alpha               = 1;
    self.isShow                      = YES;
    if (self.player.isLockedScreen) {
        self.topToolView.zf_y        = -self.topToolView.zf_height;
        self.bottomToolView.zf_y     = self.zf_height;
    } else {
        self.topToolView.zf_y        = 0;
        self.bottomToolView.zf_y     = self.zf_height - self.bottomToolView.zf_height;
    }
    self.lockBtn.zf_left             = iPhoneX ? 50: 18;
    self.player.statusBarHidden      = NO;
    if (self.player.isLockedScreen) {
        self.topToolView.alpha       = 0;
        self.bottomToolView.alpha    = 0;
    } else {
        self.topToolView.alpha       = 1;
        self.bottomToolView.alpha    = 1;
    }
}

- (void)hideControlView {
    self.isShow                      = NO;
    self.topToolView.zf_y            = -self.topToolView.zf_height;
    self.bottomToolView.zf_y         = self.zf_height;
    self.lockBtn.zf_left             = iPhoneX ? -82: -47;
    self.player.statusBarHidden      = YES;
    self.topToolView.alpha           = 0;
    self.bottomToolView.alpha        = 0;
    self.lockBtn.alpha               = 0;
}

- (BOOL)shouldResponseGestureWithPoint:(CGPoint)point withGestureType:(ZFPlayerGestureType)type touch:(nonnull UITouch *)touch {
    CGRect sliderRect = [self.bottomToolView convertRect:self.slider.frame toView:self];
    if (CGRectContainsPoint(sliderRect, point)) {
        return NO;
    }
    if (self.player.isLockedScreen && type != ZFPlayerGestureTypeSingleTap) { // 锁定屏幕方向后只相应tap手势
        return NO;
    }
    return YES;

}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer presentationSizeChanged:(CGSize)size {
    self.lockBtn.hidden = self.player.orientationObserver.fullScreenMode == ZFFullScreenModePortrait;
}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime {
    if (!self.slider.isdragging) {
        NSString *currentTimeString = [ZFUtilities convertTimeSecond:currentTime];
        self.currentTimeLabel.text = currentTimeString;
        NSString *totalTimeString = [ZFUtilities convertTimeSecond:totalTime];
        self.totalTimeLabel.text = totalTimeString;
        self.slider.value = videoPlayer.progress;
    }
}

- (void)videoPlayer:(ZFPlayerController *)videoPlayer bufferTime:(NSTimeInterval)bufferTime {
    self.slider.bufferValue = videoPlayer.bufferProgress;
}

- (void)showTitle:(NSString *)title fullScreenMode:(ZFFullScreenMode)fullScreenMode {
    self.titleLabel.text = title;
    self.player.orientationObserver.fullScreenMode = fullScreenMode;
    self.lockBtn.hidden = fullScreenMode == ZFFullScreenModePortrait;
}

/// 调节播放进度slider和当前时间更新
- (void)sliderValueChanged:(CGFloat)value currentTimeString:(NSString *)timeString {
    self.slider.value = value;
    self.currentTimeLabel.text = timeString;
    self.slider.isdragging = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.sliderBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
}

/// 滑杆结束滑动
- (void)sliderChangeEnded {
    self.slider.isdragging = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.slider.sliderBtn.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - action

- (void)backBtnClickAction:(UIButton *)sender {
    self.lockBtn.selected = NO;
    self.player.lockedScreen = NO;
    self.lockBtn.selected = NO;
    if (self.player.orientationObserver.supportInterfaceOrientation & ZFInterfaceOrientationMaskPortrait) {
        [self.player enterFullScreen:NO animated:YES];
    }
    if (self.backBtnClickCallback) {
        self.backBtnClickCallback();
    }
}

- (void)playPauseButtonClickAction:(UIButton *)sender {
    [self playOrPause];
}

/// 根据当前播放状态取反
- (void)playOrPause {
    self.playOrPauseBtn.selected = !self.playOrPauseBtn.isSelected;
    self.playOrPauseBtn.isSelected? [self.player.currentPlayerManager play]: [self.player.currentPlayerManager pause];
}

- (void)playBtnSelectedState:(BOOL)selected {
    self.playOrPauseBtn.selected = selected;
}

- (void)lockButtonClickAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.player.lockedScreen = sender.selected;
}

#pragma mark - getter

- (UIView *)topToolView {
    if (!_topToolView) {
        _topToolView = [[UIView alloc] init];
        UIImage *image = ZFPlayer_Image(@"ZFPlayer_top_shadow");
        _topToolView.layer.contents = (id)image.CGImage;
    }
    return _topToolView;
}


//上面的返回按钮
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:ZFPlayer_Image(@"ZFPlayer_back_full") forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _titleLabel;
}

- (UIView *)bottomToolView {
    if (!_bottomToolView) {
        _bottomToolView = [[UIView alloc] init];
        UIImage *image = ZFPlayer_Image(@"ZFPlayer_bottom_shadow");
        _bottomToolView.layer.contents = (id)image.CGImage;
    }
    return _bottomToolView;
}


//暂停按钮
- (UIButton *)playOrPauseBtn {
    if (!_playOrPauseBtn) {
        _playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playOrPauseBtn setImage:ZFPlayer_Image(@"ZFPlayer_play") forState:UIControlStateNormal];
        [_playOrPauseBtn setImage:ZFPlayer_Image(@"ZFPlayer_pause") forState:UIControlStateSelected];
    }
    return _playOrPauseBtn;
}


//当前时长
- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.font = [UIFont systemFontOfSize:14.0f];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}


//滑动模块
- (ZFSliderView *)slider {
    if (!_slider) {
        _slider = [[ZFSliderView alloc] init];
        _slider.delegate = self;
        _slider.maximumTrackTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.8];
        _slider.bufferTrackTintColor  = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        _slider.minimumTrackTintColor = KAPPMAINCOLOR;
        [_slider setThumbImage:ZFPlayer_Image(@"ZFPlayer_slider") forState:UIControlStateNormal];
        _slider.sliderHeight = 2;
    }
    return _slider;
}


//视频的总时长
- (UILabel *)totalTimeLabel {
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc] init];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.font = [UIFont systemFontOfSize:14.0f];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}



//锁屏的锁
- (UIButton *)lockBtn {
    if (!_lockBtn) {
        _lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lockBtn setImage:ZFPlayer_Image(@"ZFPlayer_unlock-nor") forState:UIControlStateNormal];
        [_lockBtn setImage:ZFPlayer_Image(@"ZFPlayer_lock-nor") forState:UIControlStateSelected];
    }
    return _lockBtn;
}
//下一集视频
-(UIButton *)nextSetBtn{
    if (!_nextSetBtn) {
        _nextSetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextSetBtn setImage:[UIImage imageNamed:@"播放_前进_白"] forState:UIControlStateNormal];
    }
    return _nextSetBtn;
}
///弹幕的开关。。。
-(UIButton *)danShowOrHindeBtn{
    if (!_danShowOrHindeBtn) {
        _danShowOrHindeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_danShowOrHindeBtn setImage:[UIImage imageNamed:@"弹幕关"] forState:UIControlStateNormal];
        [_danShowOrHindeBtn setImage:[UIImage imageNamed:@"弹幕开"] forState:UIControlStateSelected];
    }
    return _danShowOrHindeBtn;
}
//弹幕设置按钮
-(UIButton *)danSettingBtn{
    if (!_danSettingBtn) {
        _danSettingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_danSettingBtn setImage:[UIImage imageNamed:@"弹幕设置"] forState:UIControlStateNormal];
    }
    return _danSettingBtn;
}
//弹幕输入框！！！！
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.placeholder = @"发个弹幕吐槽一下~";
        _textField.layer.borderColor = [UIColor whiteColor].CGColor;
        _textField.layer.borderWidth = 0.5f;
        _textField.layer.masksToBounds=YES;
        _textField.layer.cornerRadius=5;
        _textField.font = [UIFont systemFontOfSize:13];
    }
    return _textField;
}

-(UIButton *)choseSet{
    if (!_choseSet) {
        _choseSet = [UIButton buttonWithType:UIButtonTypeCustom];
        [_choseSet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _choseSet.titleLabel.font = [UIFont systemFontOfSize:14];
        [_choseSet setTitle:@"选集" forState:UIControlStateNormal];
    }
    return _choseSet;
}
//清晰度
-(UIButton *)clearfloat{
    if (!_clearfloat) {
        _clearfloat = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearfloat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _clearfloat.titleLabel.font = [UIFont systemFontOfSize:14];
        [_clearfloat setTitle:@"标清" forState:UIControlStateNormal];
    }
    return _clearfloat;
}
-(UIButton *)playTimes{
    if (!_playTimes) {
        _playTimes = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playTimes setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _playTimes.titleLabel.font = [UIFont systemFontOfSize:14];
        [_playTimes setTitle:@"倍速" forState:UIControlStateNormal];
    }
    return _playTimes;
}
-(UIButton *)playerVideoSetBtn{
    if (!_playerVideoSetBtn) {
        _playerVideoSetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playerVideoSetBtn setImage:[UIImage imageNamed:@"竖点"] forState:UIControlStateNormal];
    }
    return _playerVideoSetBtn;
}

-(UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"video_share"] forState:UIControlStateNormal];
    }
    return _shareButton;
}

-(UIButton *)forScreenBtn{
    if (!_forScreenBtn) {
        _forScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forScreenBtn setImage:[UIImage imageNamed:@"video_TV"] forState:UIControlStateNormal];
    }
    return _forScreenBtn;
}

-(void)setType:(ZFLandScapeControlViewType)type{
    _type = type;
    if (type==0) {
        return;
    }else{
        [self.playerVideoSetBtn setImage:[UIImage new] forState:UIControlStateNormal];
        [self.playerVideoSetBtn setTitle:@"换台" forState:UIControlStateNormal];
        self.playerVideoSetBtn.titleLabel.font = self.shareButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.shareButton setImage:[UIImage new] forState:UIControlStateNormal];
        [self.shareButton setTitle:@"切源" forState:UIControlStateNormal];
    }
}
-(void)afNetworkStatusChanged:(NSNotification *)noti{
    NSString *status =noti.userInfo[KWIFI];
    if ([status intValue]==2) {
        [self.forScreenBtn setHidden:NO];
    }else{
        [self.forScreenBtn setHidden:YES];
    }
}

-(void)setIsMoive:(BOOL)isMoive{
    _isMoive = isMoive;
    if (isMoive) {
        [self.choseSet setHidden:YES];
    }else{
        [self.choseSet setHidden:NO];
    }
    [self layoutIfNeeded];
    [self setNeedsLayout];
}


@end
