//
//  SYHotHeaderView.m
//  SY.souyunVideo
//
//  Created by 搜云 on 2019/5/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHotHeaderView.h"

#import <WebKit/WKWebView.h>


@interface SYHotHeaderView ()

@end

@implementation SYHotHeaderView




////自己写
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.title];
        [self addSubview:self.timeLanel];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self).offset(10);
            make.right.mas_equalTo(self.mas_right).offset(-10);
        }];
        [self.timeLanel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.title.mas_left);
            make.top.mas_equalTo(self.title.mas_bottom).offset(10);
            
        }];
        
    }
    return self;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont boldSystemFontOfSize:25];
        _title.numberOfLines = 0;
        _title.textColor = [UIColor whiteColor];
        [_title sizeToFit];
    }
    return _title;
}


-(UILabel *)timeLanel{
    if (!_timeLanel) {
        _timeLanel = [[UILabel alloc]init];
        _timeLanel.font = [UIFont systemFontOfSize:13];
        _timeLanel.textColor = [UIColor whiteColor];
        [_timeLanel sizeToFit];
    }
    return _timeLanel;
}


@end

