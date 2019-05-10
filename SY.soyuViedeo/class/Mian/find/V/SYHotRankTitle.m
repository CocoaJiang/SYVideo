//
//  SYHotRankTitle.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHotRankTitle.h"
@interface SYHotRankTitle()
@property(strong,nonatomic)UIButton *button;
@end


@implementation SYHotRankTitle

-(instancetype)initWithFrame:(CGRect)frame andWithArray:(NSArray *)array{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.array = array;
        CGFloat buttonWidth  = (frame.size.width-([array count]+1) *20)/[array count];
        for (int i = 0; i<[self.array count]; i++) {
            UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setBackgroundColor:RGBA(0, 0, 0, 0.4) forState:UIControlStateSelected];
            [button setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
            button.frame = CGRectMake(20+(20*i)+(i*buttonWidth),self.centerY-15 , buttonWidth, 30);
            button.layer.cornerRadius=15;
            button.layer.masksToBounds=YES;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitle:array[i] forState:UIControlStateNormal];
            if (i==0) {
                button.selected = YES;
                self.button = button;
            }
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
        }
    }
    return self;
}

-(void)buttonClick:(UIButton *)button{
    if (button.selected) {
        return;
    }
    button.selected = !button.selected;
    self.button.selected = NO;
    //取消选中
    self.button = button;
    if (self.buttonClick) {
        self.buttonClick(button.titleLabel.text, [self.array indexOfObject:button.titleLabel.text] );
    }
    
}



@end
