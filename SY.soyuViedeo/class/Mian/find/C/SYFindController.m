//
//  SYFindController.m
//  S.SouyunVideo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYFindController.h"
#import <HMSegmentedControl.h>
#import "SYHotViewController.h"
#import "SYRankingViewController.h"
@interface SYFindController()<UIScrollViewDelegate>
@property(strong,nonatomic)HMSegmentedControl *segmentedControl;
@property(strong,nonatomic)UIScrollView *scrollView;
@end

@implementation SYFindController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = nil;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = YES;
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UINavigationBar appearance].shadowImage = [UIImage new];
    [[UINavigationBar appearance] setBarTintColor:KappBlue];
    [UINavigationBar appearance].translucent = NO;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNAV];
    [self.view addSubview:self.scrollView];
    //添加子控制器
    SYHotViewController *nowController = [[SYHotViewController alloc]init];
    nowController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.size.height);
    [self.scrollView addSubview:nowController.view];
    [self addChildViewController:nowController];
    SYRankingViewController *finshController = [[SYRankingViewController alloc]init];
    finshController.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.size.height);
    [self.scrollView addSubview:finshController.view];
    [self addChildViewController:finshController];
}

-(void)setNAV{
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"热门专题",@"观影排行"]];
    [segmentedControl setFrame:CGRectMake(0, 0, 200, 40)];
    __weak typeof(self)weakSelf = self;
    [segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*index, 0);
        }];
    }];
    segmentedControl.selectionIndicatorHeight = 4.0f;
    segmentedControl.backgroundColor = [UIColor clearColor];
    segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName :[UIColor lightGrayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : KappBlue,NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    segmentedControl.selectionIndicatorColor = [UIColor clearColor];
    segmentedControl.selectionIndicatorBoxColor = [UIColor clearColor];
    segmentedControl.selectionIndicatorBoxOpacity = 1;
    segmentedControl.verticalDividerWidth=0.5f;
    segmentedControl.selectionIndicatorHeight=1.5f;
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.shouldAnimateUserSelection = YES;
    self.navigationController.navigationItem.titleView = segmentedControl;
    self.navigationItem.titleView = segmentedControl;
    self.navigationController.navigationItem.titleView.bounds = segmentedControl.bounds;
    [segmentedControl setSelectedSegmentIndex:0 animated:YES];
    self.segmentedControl = segmentedControl;
}
-(void)segmentedControlChangedValue:(HMSegmentedControl *)controller{
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT-kTopHeight-kTabBarHeight)];
        _scrollView.pagingEnabled=YES;
        _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*2, 0);
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x>0) {
        [self.segmentedControl setSelectedSegmentIndex:1 animated:YES];
    }else{
        [self.segmentedControl setSelectedSegmentIndex:0 animated:YES];
    }
}



@end
