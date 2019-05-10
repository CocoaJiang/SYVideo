//
//  SYTheSkinViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYTheSkinViewController.h"
#import "SDCycleScrollView.h"

@interface SYTheSkinViewController ()<SDCycleScrollViewDelegate>
@property(strong,nonatomic)SDCycleScrollView *cycleScrollView;

@end

@implementation SYTheSkinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNAV];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.collectionView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
    [self.collectionView addSubview:self.cycleScrollView];
   
}
-(void)setNAV{
    self.title = @"主题皮肤";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"恢复默认" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button sizeToFit];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem= item;
}
-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView  = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -120, self.view.bounds.size.width, 120) delegate:self placeholderImage:[UIImage imageNamed:@"矩形 8 拷贝 2"]];
        _cycleScrollView.localizationImageNamesGroup  = @[[UIImage imageNamed:@"矩形 8 拷贝 2"],[UIImage imageNamed:@"矩形 8 拷贝 2"]];
        _cycleScrollView.showPageControl=YES;
        _cycleScrollView.pageControlAliment=SDCycleScrollViewPageContolAlimentRight;
    }
    return _cycleScrollView;
}
@end
