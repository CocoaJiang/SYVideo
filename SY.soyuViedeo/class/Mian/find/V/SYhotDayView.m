//
//  SYhotDayView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYhotDayView.h"
@interface SYhotDayView ()
@property(strong,nonatomic)UIButton  *button;

@end
@implementation SYhotDayView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSArray *array = @[@"1天",@"7天",@"30天"];
        CGFloat buttonWidth = 35;
        UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width-(buttonWidth*3)-10, 7.5, buttonWidth*3, 25)];
        buttonView.layer.masksToBounds=YES;
        buttonView.layer.cornerRadius=12.5;
        buttonView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:buttonView];
        for (int i = 0; i<[array count]; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.frame = CGRectMake(35*i, 0, buttonWidth, 25);
            button.layer.cornerRadius=12.5;
            button.layer.masksToBounds=YES;
            button.layer.borderWidth = 0.3f;
            button.layer.borderColor  = [UIColor groupTableViewBackgroundColor].CGColor;
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            if (i==0) {
                button.selected=YES;
                button.layer.borderColor  = [UIColor lightGrayColor].CGColor;
                self.button =button;
            }
            [buttonView addSubview:button];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

-(void)buttonClick:(UIButton *)button{
    if (button.selected) {
        return;
    }
    button.selected = !button.selected;
    self.button.selected =NO;
    self.button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.button = button;
    if (self.buttonClick) {
        self.buttonClick(button.titleLabel.text);
    }
}

@end

