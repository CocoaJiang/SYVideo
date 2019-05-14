//
//  SYSeletQuestionView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSeletQuestionView.h"

@interface SYSeletQuestionView  ()

@end


@implementation SYSeletQuestionView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.induce.font = [UIFont systemFontOfSize:14];
    
    NSArray *array = @[@"无法投屏",@"无法播放",@"播放卡顿",@"标签错误",@"分类错误",@"搜索不准",@"推荐不准",@"无法下载",@"其他"];
    ///先定义button的宽 为90
    CGFloat buttonWidth = 90;
    //在定义间隔的宽度、
    CGFloat kagain =(SCREEN_WIDTH-90*3)/4;
    for (int i = 0; i<[array count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor ] forState:UIControlStateSelected];
        [button setBackgroundColor:KAPPMAINCOLOR forState:UIControlStateSelected];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15;
        button.layer.borderColor =[UIColor grayColor].CGColor;
        button.layer.borderWidth = 0.4f;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.frame = CGRectMake(kagain*(i%3+1)+(i%3)*buttonWidth, (i/3+1)*10+(i/3*30), buttonWidth, 30);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
}
-(void)buttonClick:(UIButton *)button{
    button.selected = !button.selected;
    if (!button.selected) {
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.borderWidth = 0.4f;
    }else{
        button.layer.borderColor =KAPPMAINCOLOR.CGColor;
        button.layer.borderWidth = 0.4f;
    }
    if (button.selected) {
        [self.seleArray addObject:button.titleLabel.text];
    }else{
        if ([self.seleArray containsObject:button.titleLabel.text]) {
            [self.seleArray removeObject:button.titleLabel.text];
        }
    }
}

-(NSMutableArray *)seleArray{
    if (!_seleArray) {
        _seleArray = [[NSMutableArray alloc]init];
    }
    return _seleArray;
}

@end
