//
//  SYseachViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/14.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYseachViewController.h"
#import "ZJScrollPageView.h"
#import "SYSearchChlidVc.h"
#import "UIColor+DD.h"
#import "SYSearTipView.h"
#import "UILabel+HuaZhi.h"
#import "DDLocalStore.h"//更新数据存储的地方……
#import "SYSearchResultController.h"//搜索出结果的控制器
#import "SYSearchModel.h" //模型文件………………
#import "SYKeywordsController.h"//搜索的模糊文件………………
@interface SYseachViewController ()<ZJScrollPageViewDelegate,UISearchBarDelegate>
@property(strong,nonatomic)UISearchBar *searBar;
@property(strong,nonatomic)NSArray *titles;
@property(strong,nonatomic)ZJScrollPageView *scrollPageView;
@property(strong,nonatomic)SYSearTipView *searchTipView;
@property(assign,nonatomic)CGFloat historyHight;
@property(strong,nonatomic)NSMutableArray *historyArray;
@property(strong,nonatomic)SYSearchResultController *searResultController;
@property(strong,nonatomic)SYKeywordsController *keyworldController;


@end
@implementation SYseachViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMessage];
  //最先的应该是控制器的添加
    self.searResultController = [[SYSearchResultController alloc]init];
    [self addChildViewController:self.searResultController];
    self.keyworldController = [[SYKeywordsController alloc]init];
    [self addChildViewController:self.keyworldController];
    __weak typeof(self)weakSelf  = self;
    self.keyworldController.searchClick = ^(NSString * _Nonnull searchKeyWords) {
        [weakSelf saveItemWithText:searchKeyWords];
        [weakSelf.tableView reloadData];
        [weakSelf removeKeyWorldController];
        weakSelf.searResultController.keyWorlds = searchKeyWords;
        [weakSelf addResultViewControllerView];
    };
    
    [self tz_addPopGestureToView:self.tableView];

    self.historyArray = [[DDLocalStore sharedStore]getSearchHistoryArrayFromLocal];
    [self updateHistoryList];
    [self setNAv];
    self.titles = @[@"热搜",
                    @"电影",
                    @"电视剧",
                    @"动漫",
                    @"综艺"
                    ];
    [self addBaseView];
}
-(void)setNAv{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem= item;
    self.navigationController.navigationItem.titleView = self.searBar;
    self.navigationItem.titleView =self.searBar;
    self.navigationItem.titleView.bounds  = self.searBar.bounds;
    UITextField *textField = [self.searBar valueForKey:@"_searchField"];
    textField.font = [UIFont systemFontOfSize:13];
    textField.backgroundColor = KTEXTFIELDBACKGROUNDCOLOR;
    UIImage *image = [UIImage imageNamed:@"搜索2"];
    UIImageView *iView = [[UIImageView alloc] initWithImage:image];
    iView.frame = CGRectMake(0, 0, image.size.width , image.size.height);
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [iView sizeToFit];
    [leftView addSubview:iView];
    iView.center = leftView.center;
    textField.leftView = leftView;
    textField.textColor = [UIColor whiteColor];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.layer.masksToBounds=YES;
    textField.layer.cornerRadius = 18;
    [textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:(UIControlEventEditingChanged)];
}
-(void)cancle{
    [self.searBar resignFirstResponder];
    self.searBar.text = @"";
    [self.navigationController popViewControllerAnimated:YES];
}

-(UISearchBar *)searBar{
    if (!_searBar) {
        _searBar = [[UISearchBar alloc]init];
        _searBar.placeholder = @"请输入您要输入的内容";
        _searBar.searchBarStyle =UISearchBarStyleProminent;
        _searBar.backgroundColor = KAPPMAINCOLOR;
        _searBar.delegate = self;
        if (@available(iOS 11.0, *)) {
            [[_searBar.heightAnchor constraintEqualToConstant:44.0] setActive:YES];
        }
    }
    return _searBar;
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.scrollPageView.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view.top);
        make.height.mas_equalTo(@40);
    }];
}



- (NSInteger)numberOfChildViewControllers {
    return [self.titles count];
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(SYSearchChlidVc<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    SYSearchChlidVc<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = [[SYSearchChlidVc alloc] init];
    }
    if ([self.dataSorces count]>=index+1) {
        SYSearchModel *model = self.dataSorces[index];
        childVc.array = model.list;
    }
    __weak typeof(self)weakSelf = self;
    childVc.saveItem = ^(NSString * _Nonnull historyString) {
        [weakSelf saveItemWithText:historyString];
        [weakSelf.tableView reloadData];
        weakSelf.searResultController.keyWorlds = historyString;
        [weakSelf addResultViewControllerView];
    };
    return childVc;
}
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillAppear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    NSLog(@"%ld ---将要出现",(long)index);
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidAppear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    NSLog(@"%ld ---已经出现",(long)index);
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    NSLog(@"%ld ---将要消失",(long)index);
    
}
- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    NSLog(@"%ld ---已经消失",(long)index);
    
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

//第一步 我要将tableView 加载出来 并在Cell 里填充CollectionView控制器、、、、、
-(void)addBaseView{
    
    //第一步添加到Tableview上
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
//第二部 添加CollectionView 进入到Cell 中！！！
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        //及当TableView 的第一行的时候。。
        NSString *IdControllerString = @"IdControllerString";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdControllerString];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdControllerString];
            /*在这里我要添加框架 所以我必须先把框架初始化*/
            [cell.contentView addSubview:self.scrollPageView.segmentView];
            [self.scrollPageView.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.mas_equalTo(cell.contentView);
                make.height.mas_equalTo(@40);
            }];
            [cell.contentView addSubview:self.scrollPageView];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }
    NSString *searchString = @"searchString";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchString];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchString];
        [cell.contentView addSubview:self.searchTipView];
        [self.searchTipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(cell.contentView);
        }];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    self.searchTipView.hidden = self.historyHight>1?NO:YES;
    return cell;
}
#pragma mark -  计算高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return SCREENH_HEIGHT-kTabBarHeight;
    }else{
        return self.historyHight;
    }
}

#pragma mark - 个数控制！！！
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 1;
}
#pragma mark - 控制分
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
#pragma mark - 初始化框架………………
-(ZJScrollPageView *)scrollPageView{
    if (!_scrollPageView) {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        //显示遮盖
        style.showCover = NO;
        // 颜色渐变
        style.gradualChangeTitleColor = YES;
        style.scaleTitle = YES;
        style.normalTitleColor = RGBA(155,155, 155, 1);
        style.selectedTitleColor = KAPPMAINCOLOR;
        style.titleBigScale = 1.2;
        style.scrollLineColor =KAPPMAINCOLOR;
        _scrollPageView = [[ZJScrollPageView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREENH_HEIGHT-40-kStatusBarHeight) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
        [self.scrollPageView setSelectedIndex:0 animated:NO];
    }
    return _scrollPageView;
}
#pragma mark - 得到SearchTip的实例…………
-(SYSearTipView *)searchTipView{
    if (!_searchTipView) {
        _searchTipView = [[SYSearTipView alloc]init];
        __weak typeof(self)weakSelf = self;
        _searchTipView.removeAllhistory = ^{
            //清除所有的历史记录的地方……………………
            weakSelf.historyArray = [NSMutableArray new];
            //然后本地化需要清空所有 就是
            [[DDLocalStore sharedStore]saveSearchHistoryArrayToLocal:weakSelf.historyArray];
            //再然后..更新UI
            [weakSelf updateHistoryList];
            //执行清空操作
            [weakSelf celarn];
            
            
            
        };
    }
    return _searchTipView;
}
- (void)updateHistoryList {
    
    for (UIView *view in self.searchTipView.contentView.subviews) {
        if (view.tag == 1999) {
            [view removeFromSuperview];
        }
    }
    CGSize orgxy=CGSizeMake(10, 0);
    for (int i=0; i<self.historyArray.count; i++) {
        UILabel *historyLabel=[[UILabel alloc] init];
        historyLabel.backgroundColor = [UIColor colorWithHexString:@"F4F4F4"];
        historyLabel.clipsToBounds = YES;
        historyLabel.layer.cornerRadius = 3;
        historyLabel.tag = 1999;
        historyLabel.font = [UIFont systemFontOfSize:15];
        historyLabel.textColor = [UIColor colorWithHexString:@"333333"];
        historyLabel.text=[NSString stringWithFormat:@"  %@  ", self.historyArray[i]];
        orgxy=[historyLabel nextOrgin:orgxy];//适配
        [historyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        historyLabel.userInteractionEnabled=YES;
        [self.searchTipView.contentView addSubview:historyLabel];
    }
    
    //再加上一个s30的间隔
    self.historyHight = orgxy.height + 40 + 20+30;
    if (self.historyArray.count == 0) {
        self.historyHight=0;
    }
    [self.tableView reloadData];
}

-(void)tagDidCLick:(UITapGestureRecognizer *)zer{
    UILabel *label = (UILabel *)zer.view;
    NSLog(@"%@",label.text);
    //点击搜索标后。。。。。 第一件事情就是本地数据更新…………
    //去除空格！
    NSString *str = [label.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //拿到内存的值
    [self saveItemWithText:str];
    self.searBar.text = str;

    [self updateHistoryList];
    //然后弹出来搜索结果的TableView。。。。
    [self addResultViewControllerView];
    
}

-(void)saveItemWithText:(NSString *)str{
    //拿到内存的值
    NSMutableArray *array = [[DDLocalStore sharedStore] getSearchHistoryArrayFromLocal];
    if ([array containsObject:str]) {
        //将这货移到第一位就可以了！
        [array removeObject:str];
        //垃圾移除法、
    }
    [array insertObject:str atIndex:0];
    //保存到内存中
    [[DDLocalStore sharedStore]saveSearchHistoryArrayToLocal:array];
}


#pragma mark - searchTextField 的处理事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text length]<1) {
        [Tools showErrorWithString:@"请您输入内容进行搜索"]; //需要进行修改；
        return;
    }
    //先去重复的！
    if ([self.historyArray containsObject:searchBar.text]) {
        [self.historyArray removeObject:searchBar.text];
    }
    //然后更新数据。。。。
    [self.historyArray insertObject:searchBar.text atIndex:0];
    [[DDLocalStore sharedStore]saveSearchHistoryArrayToLocal:self.historyArray];
    [self updateHistoryList];
    //然后弹出来搜索结果的TableView。。。。
    self.searResultController.keyWorlds = searchBar.text;
    [self addResultViewControllerView];
}

#pragma mark - search结果的视图
-(void)addResultViewControllerView{
    [self.view addSubview:self.searResultController.view];
    self.searResultController.view.frame = self.view.bounds;
}
-(void)addKeyWorldController{
    [self.view addSubview:self.keyworldController.view];
    self.keyworldController.view.frame = self.view.bounds;
}
-(void)removeKeyWorldController{
    [self.keyworldController.view removeFromSuperview];
    self.keyworldController.keywordsArray = [NSMutableArray new];

}
-(void)removeResultController{
    [self.searResultController.view removeFromSuperview];
    [self.searResultController removeFromParentViewController];
}


-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[Tools getUUID] forKey:@"deviceId"];
    [HttpTool POST:[SY_SearchInfo getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"]objectForKey:@"data"]) {
            SYSearchModel *model = [SYSearchModel mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:model];
        }
        [self updataData];
    } error:^(NSString *error) {
    }];
}

-(void)updataData{
    //首先更新标题
    NSMutableArray *titleArray = [[NSMutableArray alloc]init];
    for (SYSearchModel *model in self.dataSorces) {
        [titleArray addObject:model.type_name];//标题
    }
    self.titles = (NSArray *)titleArray;
    [self.scrollPageView reloadWithNewTitles:self.titles];
}

-(void)textFieldValueChanged:(UITextField *)textField{
    NSLog(@"%@",textField.text);
    //先添加视图。。。
    if ([textField.text length]>=1) {
        [self addKeyWorldController];
        [self.keyworldController upKeyWordsWithText:textField.text];
    }else{
        [self removeKeyWorldController];
        [self removeResultController];
    }
}
#pragma mark - 执行清空操作
-(void)celarn{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:[Tools getUUID] forKey:@"deviceId"];
    [HttpTool POST:[SY_ClearnHistory getWholeUrl] param:dictionary success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } error:^(NSString *error) {
        
    }];
    
}









@end
