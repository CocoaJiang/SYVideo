//
//  SYHotTableViewHeader.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/21.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHotTableViewHeader.h"
#import "SYHotHeader.h"
#import "SYHotFootView.h"
#import "SYHotScrollView.h"

@interface SYHotTableViewHeader ()
@property(strong,nonatomic)SYHotHeader *headr;
@property(strong,nonatomic)SYHotFootView *footView;
@property(strong,nonatomic)SYHotScrollView *scrollView;

@end



@implementation SYHotTableViewHeader

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headr];
        [self addSubview:self.scrollView];
        [self addSubview:self.footView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.headr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(@(160+kStatusBarHeight));
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.headr.mas_bottom);
        make.height.mas_equalTo(@220);//201+220
    }];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.scrollView.mas_bottom);
    }];
}


-(SYHotHeader *)headr{
    if (!_headr) {
        _headr = [Tools XJ_XibWithName:@"SYHotHeader"];
        [_headr sizeToFit];
    }
    return _headr;
}

-(SYHotFootView *)footView{
    if (!_footView) {
        _footView = [Tools XJ_XibWithName:@"SYHotFootView"];
        [_footView sizeToFit];
    }
    return _footView;
}

-(SYHotScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[SYHotScrollView alloc]init];
    }
    return _scrollView;
}




@end
