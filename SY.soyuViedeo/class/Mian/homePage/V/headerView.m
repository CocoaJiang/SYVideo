//
//  headerView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "headerView.h"
#import "SearView.h"
#import "SYseachViewController.h"
#import "HistoryDetailViewController.h"
#import "SYNewLoginViewController.h"



@interface headerView ()
@property(strong,nonatomic)UIButton *historyButton;
@property(strong,nonatomic)UIButton *loadButton;
@property(strong,nonatomic)SearView *searchView;
@end


@implementation headerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KAPPMAINCOLOR;
        [self addSubview:self.historyButton];
      //  [self addSubview:self.loadButton];
        [self addSubview:self.searchView];
    }
    return self;
}

-(UIButton *)historyButton{
    if (!_historyButton) {
        _historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_historyButton setImage:[UIImage imageNamed:@"历史"] forState:UIControlStateNormal];
        _historyButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_historyButton sizeToFit];
        _historyButton.frame = CGRectMake(SCREEN_WIDTH-20-_historyButton.width,(self.height-_historyButton.height)/2,_historyButton.width, _historyButton.height);
         _historyButton.centerY= self.centerY;
        __weak typeof(self)weakSelf = self;
        _historyButton.clickAction = ^(UIButton *button) {
            if ([Tools isNeedLogin]) {
                [[Tools viewController:weakSelf].navigationController pushViewController:[SYNewLoginViewController new] animated:YES];
                return ;
            }
            if ([weakSelf.historyButton.imageView.image isEqual:[UIImage imageNamed:@"历史"]]) {
                [[Tools viewController:weakSelf].navigationController pushViewController:[HistoryDetailViewController new] animated:YES];
            }else{
                if (weakSelf.chose) {
                    weakSelf.chose();
                }
            }
        };
    }
    return _historyButton;
}

-(UIButton *)loadButton{
    if (!_loadButton) {
        _loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loadButton setImage:[UIImage imageNamed:@"下载白色"] forState:UIControlStateNormal];
        [_loadButton sizeToFit];
        _loadButton.frame = CGRectMake(SCREEN_WIDTH-40-_historyButton.width-_loadButton.width, _historyButton.top, _loadButton.width, _loadButton.height);
         _loadButton.centerY= self.centerY;
    }
    return _loadButton;
}

-(SearView *)searchView{
    if (!_searchView) {
        _searchView = [[SearView alloc]initWithFrame:CGRectZero];
        _searchView.userInteractionEnabled=YES;
        _searchView.listenBlock = ^{
          //听写回掉
        };
        UITapGestureRecognizer *zer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchClick)];
        [_searchView addGestureRecognizer:zer];
        _searchView.userInteractionEnabled=YES;
        
        __weak typeof(self)weakSelf = self;
        _searchView.searchBlock = ^{
            [weakSelf searchClick];
        };
        
          _searchView.frame = CGRectMake(10, 7.5, _historyButton.left-20, 30);
        _searchView.centerY= self.centerY;
    }
    return _searchView;
}

-(void)searchClick{
    //跳转页面的填写，，
    [[Tools viewController:self].navigationController pushViewController:[SYseachViewController new] animated:YES];
}
//筛选跳转
-(void)buttonClick:(UIButton *)button{
    if ([button.imageView.image isEqual:[UIImage imageNamed:@"筛选"]]) {
        if (self.chose) {
            self.chose();
        }
    }else{
      //  [[Tools viewController:self].navigationController pushViewController:[ new] animated:YES];
    }
}
-(void)setSingeleButton{
    [self.loadButton setHidden:YES];
    [self.historyButton setTitle:@"全部" forState:UIControlStateNormal];
    [self.historyButton setImage:[UIImage imageNamed:@"筛选"] forState:UIControlStateNormal];
    [self.historyButton sizeToFit];
    _historyButton.frame = CGRectMake(SCREEN_WIDTH-20-_historyButton.width,(self.height-_historyButton.height)/2,_historyButton.width, _historyButton.height);
    _historyButton.centerY= self.centerY;
    [UIView animateWithDuration:0.3 animations:^{
       //这样就有动画了
        self->_searchView.frame = CGRectMake(10, 7.5, self->_historyButton.left-20, 30);
    }];
}
-(void)setTwoButton{
    [self.loadButton setHidden:NO];
    [_historyButton setImage:[UIImage imageNamed:@"历史"] forState:UIControlStateNormal];
    [_historyButton setTitle:nil forState:UIControlStateNormal];
    [_historyButton sizeToFit];
    _historyButton.frame = CGRectMake(SCREEN_WIDTH-20-_historyButton.width,(self.height-_historyButton.height)/2,_historyButton.width, _historyButton.height);
     _historyButton.centerY= self.centerY;
    [UIView animateWithDuration:0.3 animations:^{
        //这样就有动画了
        self->_searchView.frame = CGRectMake(10, 7.5, self->_historyButton.left-20, 30);
    }];


}

@end
