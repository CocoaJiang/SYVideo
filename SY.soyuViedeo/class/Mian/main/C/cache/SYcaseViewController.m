//
//  SYcaseViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYcaseViewController.h"
#import "Selegetem.h"
#import "SYCaseNowController.h"
#import "SYFinshViewController.h"


@interface SYcaseViewController ()<UIScrollViewDelegate>
@property(strong,nonatomic)Selegetem *selegetem;
@property(strong,nonatomic)UIScrollView *scrollView;


@end

@implementation SYcaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"离线缓存";
    [self.view addSubview:self.selegetem];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.selegetem.mas_bottom);
    }];
    
    [self tz_addPopGestureToView:self.scrollView];
    
    //添加l控制器。。。
    SYCaseNowController *nowController = [[SYCaseNowController alloc]init];
    nowController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.size.height);
    [self.scrollView addSubview:nowController.view];
    [self addChildViewController:nowController];
    SYFinshViewController *finshController = [[SYFinshViewController alloc]init];
    finshController.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.size.height);
    [self.scrollView addSubview:finshController.view];
    [self addChildViewController:finshController];
    [self setNAv];
    
    
    
}

-(void)setNAv{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem= item;
}
-(void)edit{
    
}

-(Selegetem *)selegetem{
    if (!_selegetem) {
        _selegetem = [[Selegetem alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [_selegetem setTtile:@"正在缓存" andRightTitle:@"已缓存"];
        __weak typeof(self)weakSelf = self;
        _selegetem.buttonClick = ^(NSInteger index) {
            [UIView animateWithDuration:0.3 animations:^{
                 weakSelf.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*index, 0);
            }];
        };
    }
    return _selegetem;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _scrollView.pagingEnabled=YES;
        _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*2, 0);
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x>0) {
        [self.selegetem turnRight];
    }else{
        [self.selegetem turnLeft];
    }
}


@end
