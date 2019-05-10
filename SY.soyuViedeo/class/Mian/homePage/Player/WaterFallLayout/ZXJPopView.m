//
//  ZXJPopView.m
//  乐氏同仁APP
//
//  Created by 张孝江 on 2018/9/13.
//  Copyright © 2018年 双木科技张晓红. All rights reserved.
//

#import "ZXJPopView.h"

@interface ZXJPopView()
@property (nonatomic, strong) UIView *btnBack;
@end
@implementation ZXJPopView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.2;
    }
    return self;
}
- (void)addElement {
    _btnBack = [[UIView alloc]init];
}

- (void)showAlert {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlert)]];
    //遮罩
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.5;
    }];
    [window addSubview:_contentview];

    [_btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(@(self.contentview.frame.size.height));
    }];

    self.btnBack.transform = CGAffineTransformMakeTranslation(0.01, SCREENH_HEIGHT);
    [UIView animateWithDuration:0.3 animations:^{
        self.btnBack.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
    }];
}

- (void)dismissAlert {
    if (self.canDisMiss) {
        return;
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            self.btnBack.transform = CGAffineTransformMakeTranslation(0.01, SCREEN_WIDTH);
            self.btnBack.alpha = 0.2;
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.btnBack removeFromSuperview];
        }];
        
        if (self.dismisBlock) {
            self.dismisBlock();
        }
        
    }
}

-(void)setContentview:(UIView *)contentview{
    _contentview = contentview;
    _btnBack = contentview;
    [self addSubview:contentview];
}


@end

