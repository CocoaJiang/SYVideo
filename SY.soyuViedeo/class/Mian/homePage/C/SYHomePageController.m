//
//  SYHomePageController.m
//  S.SouyunVideo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYHomePageController.h"
#import "ZJScrollPageView.h"
#import "ZJTestViewController.h"
#import "headerView.h"
#import "HomePageModel.h"
#import "SYNavController.h"
#import "SYseachViewController.h"
#import "SYDetailCollectionController.h"


@interface SYHomePageController()<ZJScrollPageViewDelegate>
@property (weak, nonatomic) ZJScrollPageView *scrollPageView;
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property (strong, nonatomic) headerView *headerView;
@property(assign,nonatomic)NSInteger index;

@end
@implementation SYHomePageController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self getMessage];
    [self addUI];
}

-(void)addUI{
    self.titles = @[@"推荐",
                    @"电影",
                    @"电视剧",
                    @"动漫",
                    @"综艺"
                    ];
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = NO;
    // 颜色渐变
    style.contentViewBounces = NO;

    
    style.gradualChangeTitleColor = YES;
    style.scaleTitle = YES;
    style.normalTitleColor = RGBA(255, 255, 255, 1);
    style.selectedTitleColor = RGBA(255, 255, 255, 1);
    style.titleBigScale = 1.4;
    style.titleFont = [UIFont systemFontOfSize:16];
    style.showLine=YES;
    style.scrollLineColor = RGBA(255, 255, 255, 1);
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc]initWithFrame:CGRectMake(0, 45, self.view.width, SCREENH_HEIGHT-kTopHeight-kTabBarHeight) segmentStyle:style titles:self.titles parentViewController:self andMath:SCREEN_WIDTH-50 delegate:self];
    self.scrollPageView = scrollPageView;
    [self.scrollPageView setSelectedIndex:0 animated:NO];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.scrollPageView];
    UIImageView *imageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [imageView sizeToFit];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:imageView];
    self.navigationItem.leftBarButtonItem = item;
    self.scrollPageView.segmentView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = self.scrollPageView.segmentView;
    self.navigationItem.titleView.bounds  = self.scrollPageView.segmentView.bounds;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
}


- (NSInteger)numberOfChildViewControllers {
    return [self.titles count];
    
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(ZJTestViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    ZJTestViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = [[ZJTestViewController alloc] init];
        if ([self.dataSorces count]>=index+1) {
            childVc.model = self.dataSorces[index];
        }
    }
    
    childVc.refresh = ^{
      
        [self.dataSorces removeAllObjects];
        
        [self getMessage];
        
    };
    
    return childVc;
}
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillAppear:(UIViewController *)childViewController forIndex:(NSInteger)index {
     self.index = index;
    NSLog(@"%ld ---将要出现",index);
}
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidAppear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    //已经出现
    if (index!=0) {
        [self.headerView setSingeleButton];
    }else{
        [self.headerView setTwoButton];
    }
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    NSLog(@"%ld ---将要消失",index);
    
}
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    NSLog(@"%ld ---已经消失",index);
    
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}




//接下来自定义View

-(headerView *)headerView{
    if (!_headerView) {
        _headerView = [[headerView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 45)];
        __weak typeof(self)weakSelf = self;
        _headerView.chose = ^{
            SYDetailCollectionController *controller = [SYDetailCollectionController new];
            HomePageModel *model = weakSelf.dataSorces[weakSelf.index];
            controller.title =model.type_name;
            controller.Idstring = model.type_id;
            [weakSelf.navigationController pushViewController:controller animated:YES];
        };
    }
    return _headerView;
}

-(void)getMessage{
    [HttpTool POST:[SY_index getWholeUrl] param:nil success:^(id responseObject) {
        for (NSDictionary *dict in [responseObject objectForKey:@"data"]) {
            HomePageModel *model = [HomePageModel mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:model];
        }
        [self addData];
    } error:^(NSString *error) {
        
    }];
}
-(void)addData{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (HomePageModel *model in self.dataSorces) {
        [array addObject:model.type_name];
    }
    self.titles = (NSArray *)array;
   [self.scrollPageView reloadWithNewTitles:(NSArray *)array];
}


@end
