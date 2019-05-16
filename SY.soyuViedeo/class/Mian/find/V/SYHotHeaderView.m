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


-(instancetype)initWithFrame:(CGRect)frame andWithTitle:(NSString *)title andWithContentView:(UIView *)view{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor whiteColor];
        UIFont *font = [UIFont boldSystemFontOfSize:25];
        label.font = font;
        label.numberOfLines = 0;
        label.text = title;
        CGFloat height = [Tools XJCalculateTheSizeWithFont:font andWithText:title andWithWidthMAX:SCREEN_WIDTH-30].height;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.top.mas_equalTo(self.mas_top).offset(20);
            make.height.mas_equalTo(@(height));
        }];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(view);
            make.top.mas_equalTo(label.mas_bottom).offset(10);
        }];
    }
    return self;
}

@end

