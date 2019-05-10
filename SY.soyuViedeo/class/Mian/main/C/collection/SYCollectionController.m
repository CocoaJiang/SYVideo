//
//  SYCollectionController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYCollectionController.h"
#import <HMSegmentedControl.h>
#import "SYcollectionChildVc.h"
#import "C_SYCollectionModel.h"


@interface SYCollectionController ()<UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)HMSegmentedControl *segmentedControl;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)UIButton *button;




@end

@implementation SYCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNAv];
    [self setTitle];
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@40);
    }];
    self.lineView = [Tools retunLineView];
    [self.view addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.segmentedControl.mas_bottom);
        make.height.mas_equalTo(@1);
    }];
    
    [self tz_addPopGestureToView:self.scrollView];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.lineView.mas_bottom);
    }];
    
    [self getmessage];
    
}

-(void)setNAv{
    self.title = @"我的收藏";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    self.button = button;
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem= item;
}
-(void)edit:(UIButton *)button{
    button.selected = !button.selected;
    self.scrollView.bounces = !button.selected;
    SYcollectionChildVc *vc = self.childViewControllers[self.segmentedControl.selectedSegmentIndex];
    __weak typeof(self)weakSelf= self;
    vc.cancel = ^{
        weakSelf.button.selected = !weakSelf.button.selected;
    };
    vc.tableViewEditing = button.selected;
}

-(void)setTitle{
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"电影",@"电视剧",@"动漫",@"综艺"]];
    __weak typeof(self)weakSelf = self;
    [segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*index, 0);
        }];
    }];
    segmentedControl.selectionIndicatorHeight = 4.0f;
    segmentedControl.backgroundColor = [UIColor clearColor];
    segmentedControl.selectionIndicatorColor = KappBlue;
    segmentedControl.selectionIndicatorBoxColor = KappBlue;
    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:KappBlue,NSFontAttributeName:[UIFont boldSystemFontOfSize:15]};
    segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]};
    segmentedControl.selectionIndicatorBoxOpacity = 1;
    segmentedControl.verticalDividerWidth=0.5f;
    segmentedControl.selectionIndicatorHeight=1.5f;
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.shouldAnimateUserSelection = YES;
    [segmentedControl setSelectedSegmentIndex:0 animated:YES];
    self.segmentedControl = segmentedControl;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled=YES;
        _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*4, 0);
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
       [self.segmentedControl setSelectedSegmentIndex:scrollView.contentOffset.x/SCREEN_WIDTH animated:YES];
}



-(void)getmessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"20" forKey:@"pageSize"];
    [HttpTool POST:[SY_CollectionList getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            C_SYCollectionModel *model = [C_SYCollectionModel mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:model];
        }
        [self addChildVc];
    } error:^(NSString *error) {
        
    }];
}

-(void)addChildVc{
    for (int i = 0; i<self.dataSorces.count; i++) {
        SYcollectionChildVc *childvc = [[SYcollectionChildVc alloc]init];
        [self addChildViewController:childvc];
        [self.scrollView addSubview:childvc.view];
        childvc.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, self.scrollView.width, self.scrollView.height);
        childvc.model =self.dataSorces[i];
    }
    NSMutableArray *array = [[NSMutableArray  alloc]init];
    for (C_SYCollectionModel *model in self.dataSorces) {
        [array addObject:model.type_name];
    }
    self.segmentedControl.sectionTitles =(NSArray *)array;
}






@end
