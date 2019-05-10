//
//  SYVideoSectionOneHeaderView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYVideoSectionOneHeaderView.h"
#import "PlayModel.h"

@implementation SYVideoSectionOneHeaderView


-(void)awakeFromNib{
    [super awakeFromNib];
    [self addGes];
    [self.feedBackButton setUpImageAndDownLableWithSpace:7];
    [self.shareButton setUpImageAndDownLableWithSpace:7];
    self.tipLanel.layer.masksToBounds=YES;
    self.tipLanel.layer.cornerRadius=1;
    //设置KVO
    [self.choseButton addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"selected"]) {
        if (self.choseButton.selected) {
            [UIView animateWithDuration:0.3 animations:^{
                if (self.downjiantou) {
                    self.downjiantou.transform = CGAffineTransformMakeRotation(M_PI);
                }
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                if (self.downjiantou) {
                    self.downjiantou.transform = CGAffineTransformIdentity;
                }
            }];
        }
    }
}


- (IBAction)buttonClick:(UIButton *)sender {
    if (self.buttonClick) {
        self.buttonClick(sender.titleLabel.text);
    }
}

- (IBAction)zan:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_caiButton.selected) {
         _caiButton.selected = !sender.selected;
    }
}

- (IBAction)cai:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_zanButton.selected) {
        _zanButton.selected = !sender.selected;
    }

}

-(void)setInfo:(videoInfo *)info{
    _info = info;
    _title.text = info.name;
    _playtimes.text = [NSString stringWithFormat:@"%@次播放",info.hits];
    _CollectionsLabl.text = info.Class;
    //0什么都没有1火爆2热播其他则是字符高清度1080P蓝光
    switch ([info.hot intValue]) {
        case 0:
            _tipLanel.text=@"";
             _tipLanel.backgroundColor = [UIColor redColor];
            break;
        case 1:
            _tipLanel.text = @"火爆";
             _tipLanel.backgroundColor = [UIColor redColor];
            break;
        case 2:
            _tipLanel.text = @"热播";
            _tipLanel.backgroundColor = [UIColor redColor];
            break;
        default:_tipLanel.text = @"1080P";
            _tipLanel.backgroundColor = KappBlue;
            break;
    }
    
    _comments.text = [NSString stringWithFormat:@"%@条评论",info.comment_num];
    switch ([info.like intValue]) {
        case 0:
            _zanButton.selected = _caiButton.selected = NO;
            break;
        case 1:
            _zanButton.selected = YES;
            break;
        case 2:
            _caiButton.selected = YES;
            break;
        default:
            break;
    }
    
    
    
    
}

-(void)setChoseIndex:(NSInteger)choseIndex{
    if (choseIndex+1<=[self.info.url count]) {
        [_palyIcon XJ_setImageWithURLString:self.info.url[choseIndex].icon];
        [_choseButton setTitle:self.info.url[choseIndex].player_name forState:UIControlStateNormal];
    }
}


//选择视频源头。。。。
- (IBAction)chosefrome:(UIButton *)sender {
    //只需要旋转180*即可
    sender.selected = !sender.selected;
    if (self.buttonClick) {
        self.buttonClick(@"选择视频");
    }
}

//我只需要箭筒

-(void)dealloc{
    [self.choseButton removeObserver:self forKeyPath:@"selected"];
}



//加上点击事件！！！！

-(void)addGes{
    UITapGestureRecognizer *zer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClicK)];
    UITapGestureRecognizer *zerl = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClicK)];
    self.downjiantou.userInteractionEnabled = self.palyIcon.userInteractionEnabled=YES;
    [self.downjiantou addGestureRecognizer:zerl];
    [self.palyIcon addGestureRecognizer:zer];
    
}
-(void)viewClicK{
    [self chosefrome:self.choseButton];
}


@end
