//
//  SYSearTipView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSearTipView.h"
#import "SYSearTiptitleView.h"

@interface SYSearTipView()
@property(strong,nonatomic)SYSearTiptitleView *searchView;
@end



@implementation SYSearTipView
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self addSubview:self.searchView];
        [self addSubview:self.contentView];
    }
    return self;
}

-(SYSearTiptitleView *)searchView{
    if (!_searchView) {
        _searchView = [Tools XJ_XibWithName:@"SYSearTiptitleView"];
        __weak typeof(self)weakSelf = self;
        _searchView.removerAllHistory = ^{
            if (weakSelf.removeAllhistory) {
                weakSelf.removeAllhistory();
            }
        };
    }
    return _searchView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(@40);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.searchView.mas_bottom);
    }];
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}

@end
