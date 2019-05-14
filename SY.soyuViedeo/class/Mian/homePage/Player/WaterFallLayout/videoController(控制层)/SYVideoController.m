//
//  SYChoseClearFloat.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/2.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYVideoController.h"
#import "SYPlaySetView.h"// 播放设置
#import "SYPlayerShareView.h"//分享
#import "SYPlayChoseSetView.h"//选集
#import "SYChoseClearView.h"//选择清晰度
#import "SYChosePlayerTimes.h"//选择播放速度


@interface SYVideoController ()<UIGestureRecognizerDelegate>
@property(strong,nonatomic)SYPlaySetView *playsetView;
@property(strong,nonatomic)SYPlayerShareView *shareView;
@property(strong,nonatomic)SYPlayChoseSetView *choseSetView;
@property(strong,nonatomic)SYChoseClearView *choseClearView;
@property(strong,nonatomic)SYChosePlayerTimes *chosePlayerTimes;

@end



@implementation SYVideoController


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =RGBA(0, 0, 0, 0.5);
        
        [self addSubview:self.playsetView];
        [self.playsetView setHidden:YES];
        [self.playsetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        
        
        [self addSubview:self.shareView];
        [self.shareView setHidden:YES];
        [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        
        [self addSubview:self.choseSetView];
        [self.choseSetView setHidden:YES];
        [self.choseSetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        
        [self addSubview:self.choseClearView];
        [self.choseClearView setHidden:YES];
        [self.choseClearView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        
        [self addSubview:self.chosePlayerTimes];
        [self.chosePlayerTimes setHidden:YES];
        [self.chosePlayerTimes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *zer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewdismissForClearFloat)];
        zer.delegate =self;
        [self addGestureRecognizer:zer];
    }
    return self;
}



-(void)setType:(viewType)type{
    _type = type;
    if (self.type==choseClear) {
        self.choseClearView.hidden=NO;
        self.playsetView.hidden=YES;
        self.chosePlayerTimes.hidden =YES;
        self.choseSetView.hidden=YES;
        self.shareView.hidden=YES;
    }else if (self.type==playset){
        self.choseClearView.hidden=YES;
        self.playsetView.hidden=NO;
        self.chosePlayerTimes.hidden =YES;
        self.choseSetView.hidden=YES;
        self.shareView.hidden=YES;
    }else if (self.type==playShare){
        self.choseClearView.hidden=YES;
        self.playsetView.hidden=YES;
        self.chosePlayerTimes.hidden =YES;
        self.choseSetView.hidden=YES;
        self.shareView.hidden=NO;
    }else if (self.type==choseSet){
        self.choseClearView.hidden=YES;
        self.playsetView.hidden=YES;
        self.chosePlayerTimes.hidden =YES;
        self.choseSetView.hidden=NO;
        self.shareView.hidden=YES;
    }else if (self.type ==chosePlaytimes){
        self.choseClearView.hidden=YES;
        self.playsetView.hidden=YES;
        self.chosePlayerTimes.hidden =NO;
        self.choseSetView.hidden=YES;
        self.shareView.hidden=YES;
    }
    
    [self layoutSubviews];
}





//播放设置视图
-(SYPlaySetView *)playsetView{
    if (!_playsetView) {
        _playsetView = [[SYPlaySetView alloc]initWithFrame:CGRectZero];
        __weak typeof(self)weakSelf = self;
        _playsetView.changVideoViewType = ^(BOOL isFuScreen) {
            if (weakSelf.changVideoPlayerSizeType) {
                weakSelf.changVideoPlayerSizeType(isFuScreen);
            }
        };
        _playsetView.closeVideoPlayer = ^(NSString * _Nonnull timeString) {
            if (weakSelf.timerClosePlayerWtihTime) {
                weakSelf.timerClosePlayerWtihTime(timeString);
            }
        };
    }
    return _playsetView;
}
//分享视图。。
-(SYPlayerShareView *)shareView{
    if (!_shareView) {
        _shareView = [Tools XJ_XibWithName:@"SYPlayerShareView"];
    }
    return _shareView;
}
//选集的视图
-(SYPlayChoseSetView *)choseSetView{
    if (!_choseSetView) {
        _choseSetView = [[SYPlayChoseSetView alloc]init];
        __weak typeof(self)weakSelf = self;
        _choseSetView.choseItem = ^(NSInteger index) {
            if (weakSelf.choseTypeAnditemindexAndContent) {
                weakSelf.choseTypeAnditemindexAndContent(weakSelf.type, index, @"");
            }
        };
    }
    return _choseSetView;
}

//选择清晰度的视图

-(SYChoseClearView *)choseClearView{
    if (!_choseClearView) {
        _choseClearView = [Tools XJ_XibWithName:@"SYChoseClearView"];
        __weak typeof(self)weakSelf = self;
        _choseClearView.choseItem = ^(NSInteger index, NSString * _Nonnull content) {
            if (weakSelf.choseTypeAnditemindexAndContent) {
                weakSelf.choseTypeAnditemindexAndContent(weakSelf.type, index, content);
            }
        };
      
    }
    return _choseClearView;
}

-(SYChosePlayerTimes *)chosePlayerTimes{
    if (!_chosePlayerTimes) {
        _chosePlayerTimes = [Tools XJ_XibWithName:@"SYChosePlayerTimes"];
        __weak typeof(self)weakSelf = self;
        _chosePlayerTimes.choseItem = ^(NSInteger index, NSString * _Nonnull content) {
            if (weakSelf.choseTypeAnditemindexAndContent) {
                weakSelf.choseTypeAnditemindexAndContent(weakSelf.type, index, content);
            }
        };
    }
    return _chosePlayerTimes;
}

-(void)setSeleIndex:(NSInteger)index andWithModel:(videoInfo *)model{
    self.choseSetView.info = model;
    self.choseSetView.index = index;
}

//设置代理进行监听
- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{

    if (touch.view.size.width<self.frame.size.width && ![touch.view isKindOfClass:[UICollectionView class]]) {
        return NO; //让其相应collectionView的点击事件！！！
    }
    if ([touch.view isKindOfClass:[UICollectionView class]]) {
        return YES;
    }
      return YES;
}

-(void)viewdismissForClearFloat{
    
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    
}

@end
