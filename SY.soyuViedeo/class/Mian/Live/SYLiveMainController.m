//
//  SYLiveMainController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYLiveMainController.h"
#import "ZJScrollPageView.h"
#import "SYLiveChildController.h"
#import "SYMianLiveController.h"
#import "SYliveAddressController.h"
///模型文件
#import "LiveModel.h"

@interface SYLiveMainController ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSMutableArray<NSString *> *titles;
@property (weak, nonatomic) ZJScrollPageView *scrollPageView;
@end

@implementation SYLiveMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMessage];
    self.scrollPageView.contentView.collectionView.emptyDataSetSource = self;
    self.scrollPageView.contentView.collectionView.emptyDataSetDelegate  = self;
    
}

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
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBarTintColor:KAPPMAINCOLOR];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:KAPPMAINCOLOR];
    self.navigationController.navigationBar.translucent = YES;
}


-(void)addUI{
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = NO;
    style.showLine = YES;
    style.contentViewBounces = NO;
    style.scrollLineColor = KAPPMAINCOLOR;
    style.gradualChangeTitleColor = YES;
    style.adjustCoverOrLineWidth = YES;
    style.scrollTitle = NO;
    style.segmentHeight = 35;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    style.scaleTitle = YES;
    style.normalTitleColor = RGBA(10, 10, 10, 1);
    style.selectedTitleColor = KAPPMAINCOLOR;
    style.titleBigScale = 1.2;
    style.titleFont = [UIFont systemFontOfSize:14];
    style.scrollLineColor =KAPPMAINCOLOR;
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 35, self.view.frame.size.width,self.view.bounds.size.height) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    self.scrollPageView = scrollPageView;
    [self.view addSubview:scrollPageView];
    [self.scrollPageView setSelectedIndex:1 animated:NO];
    self.scrollPageView.segmentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35);
    [self.view addSubview:self.scrollPageView.segmentView];
    
    

    
}

- (NSInteger)numberOfChildViewControllers {
    return [self.titles count];
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (index==0) {
        if (!childVc) {
            childVc = [[SYMianLiveController alloc]init];
        }
        return childVc;
    }
    LiveModel *model = self.dataSorces[index-1];
    if ([model.info isEqualToString:@"local"]) {
        if (!childVc) {
            childVc = [[SYliveAddressController alloc]init];
        }
        return childVc;
    }else{
        if (!childVc) {
            childVc =[[SYLiveChildController alloc] init];
        }
        //既然正常赋值不行那就用黑科技KVC。。。。。。。。
        LiveModel *model  = self.dataSorces[index-1];
        [childVc setValue:model.id forKey:@"idString"];
        
        return childVc;
    }
  
}
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillAppear:(UIViewController *)childViewController forIndex:(NSInteger)index {
}
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidAppear:(UIViewController *)childViewController forIndex:(NSInteger)index {
}
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index {
}
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index {
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [HttpTool POST:[SY_Live getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dictionay in [responseObject objectForKey:@"data"]) {
            LiveModel *model = [LiveModel mj_objectWithKeyValues:dictionay];
            [self.dataSorces addObject:model];
        }
        [self addData];
    } error:^(NSString *error) {
        
    }];
}

-(void)addData{
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (LiveModel *model in self.dataSorces) {
        [array addObject:model.name];
    }
    [array insertObject:@"我的频道" atIndex:0];
    [self.titles addObjectsFromArray:array];
    [self.scrollPageView reloadWithNewTitles:self.titles];
    [self addUI];
}
-(NSMutableArray<NSString *> *)titles{
    if (!_titles) {
        _titles = [[NSMutableArray alloc]init];
    }
    return _titles;
}

-(void)reload{
    [self.dataSorces removeAllObjects];
    [self getMessage];
}


@end
