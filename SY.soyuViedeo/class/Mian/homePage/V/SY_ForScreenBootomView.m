//
//  SY_ForScreenBootomView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/5.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SY_ForScreenBootomView.h"

#import "ZFSliderView.h"

#define ZFPlayer_SrcName(file)               [@"ZFPlayer.bundle" stringByAppendingPathComponent:file]

#define ZFPlayer_FrameworkSrcName(file)      [@"Frameworks/ZFPlayer.framework/ZFPlayer.bundle" stringByAppendingPathComponent:file]

#define ZFPlayer_Image(file)                 [UIImage imageNamed:ZFPlayer_SrcName(file)] ? :[UIImage imageNamed:ZFPlayer_FrameworkSrcName(file)]


@interface SY_ForScreenBootomView()<ZFSliderViewDelegate>

@property(strong,nonatomic)UIButton *playOrPauseBtn;

@property(strong,nonatomic)UILabel *currentTimeLabel;

@property(strong,nonatomic)UILabel *totalTimeLabel;

@end



@implementation SY_ForScreenBootomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    
        [self addSubview:self.playOrPauseBtn];
        [self.playOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
            make.left.mas_equalTo(self.mas_left).offset(20);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self addSubview:self.currentTimeLabel];
        [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.playOrPauseBtn.mas_centerY);
            make.left.mas_equalTo(self.playOrPauseBtn.mas_right).offset(10);
            make.width.mas_equalTo(@80);
        }];
        [self addSubview:self.totalTimeLabel];
        [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-20);
            make.centerY.mas_equalTo(self.playOrPauseBtn.mas_centerY);
             make.width.mas_equalTo(@80);
        }];
        [self addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.playOrPauseBtn.mas_centerY);
            make.height.mas_equalTo(@30);
            make.left.mas_equalTo(self.currentTimeLabel.mas_right).offset(10);
            make.right.mas_equalTo(self.totalTimeLabel.mas_left).offset(-10);
        }];
    }
    return self;
}




//暂停按钮
- (UIButton *)playOrPauseBtn {
    if (!_playOrPauseBtn) {
        _playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playOrPauseBtn.selected = YES;
        [_playOrPauseBtn setImage:ZFPlayer_Image(@"ZFPlayer_play") forState:UIControlStateNormal];
        [_playOrPauseBtn setImage:ZFPlayer_Image(@"ZFPlayer_pause") forState:UIControlStateSelected];
        __weak typeof(self)weakSelf = self;
        _playOrPauseBtn.clickAction = ^(UIButton *button) {
            button.selected = !button.selected;
            if (weakSelf.playOrPause) {
                weakSelf.playOrPause(button.selected);
            }
        };
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
        [_currentTimeLabel sizeToFit];
        _currentTimeLabel.text = @"33:33:33";
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
        _slider.minimumTrackTintColor = KappBlue;
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
        [_totalTimeLabel sizeToFit];
        _totalTimeLabel.text = @"66:66:66";
    }
    return _totalTimeLabel;
}


/*
 // 滑块滑动开始
 - (void)sliderTouchBegan:(float)value;
 // 滑块滑动中
 
 // 滑块滑动结束
 - (void)sliderTouchEnded:(float)value;
 // 滑杆点击
 - (void)sliderTapped:(float)value;
 
 */


- (void)sliderValueChanged:(float)value{
    if (self.playValue) {
        self.playValue(value);
    }
}

-(void)sliderTouchEnded:(float)value{
    if (self.playValue) {
        self.playValue(value);
    }
}

-(void)sliderTapped:(float)value{
    if (self.playValue) {
        self.playValue(value);
    }
}

-(void)setCurrTime:(NSString *)currtimeString andTotal:(NSString *)totoaTinmeString andWithProgress:(CGFloat)progress{
    self.currentTimeLabel.text  = currtimeString;
    self.totalTimeLabel.text = totoaTinmeString;
    self.slider.value = progress;
}

@end
