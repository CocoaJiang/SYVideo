//
//  HistoryDetailViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "HistoryDetailViewController.h"
#import "historyDetailCell.h"
#import "PlayInfoModel.h"
#import "BootomDelegateView.h"

@interface HistoryDetailViewController ()
@property(strong,nonatomic)BootomDelegateView *deletView; //f容器View
@property(strong,nonatomic)UIView *bootomView;

@end

@implementation HistoryDetailViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNAV];
    self.SYindex =1;
    [self gethistoryWithPage:self.SYindex];
    [self.view addSubview:self.tableView];
    self.title = @"播放记录";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"historyDetailCell" bundle:nil] forCellReuseIdentifier:@"historyDetailCell"];
    self.tableView.rowHeight=90;
    [self.view addSubview:self.bootomView];
    [self addRefush];
    
}

-(void)addRefush{
    __weak typeof(self)weakSelf= self;
    self.tableView.mj_header = [SYGifHeader headerWithRefreshingBlock:^{
        weakSelf.SYindex = 1;
        [weakSelf.dataSorces removeAllObjects];
        [weakSelf gethistoryWithPage:weakSelf.SYindex];
    }];
    self.tableView.mj_footer = [SYGifFoot footerWithRefreshingBlock:^{
        if (self.isHaveNextPage) {
            weakSelf.SYindex++;
            [weakSelf gethistoryWithPage:weakSelf.SYindex];
        }else{
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    }];
}


-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [Tools returnWithString:@"暂无浏览记录"];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    historyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyDetailCell"];
    if ([self.dataSorces count]>=indexPath.row+1) {
        PlayInfoModel *model = self.dataSorces[indexPath.row];
        [cell.icon XJ_setImageWithURLString:model.pic];
        
        cell.dislabel.text = [NSString stringWithFormat:@"观看至%@%%",model.playTime];
        if ([model.serlize integerValue]>0) {
            model.serlize = [NSString stringWithFormat:@"第%@集",model.serlize];
        }
        cell.title.text = [NSString stringWithFormat:@"%@%@",model.name,model.serlize];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSorces count];
}

-(void)gethistoryWithPage:(NSInteger)page{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(page) forKey:@"page"];
    [dict setObject:@"10" forKey:@"pageSize"];
    [HttpTool POST:[SY_PlayHistoryInfo getWholeUrl] param:dict success:^(id responseObject) {
        if ([[[responseObject objectForKey:@"data"] objectForKey:@"list"] count]<10) {
            self.isHaveNextPage=NO;
        }else{
            self.isHaveNextPage = YES;
        }
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            PlayInfoModel *palyerInfo = [PlayInfoModel mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:palyerInfo];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } error:^(NSString *error) {
        
    }];
}

-(void)setNAV{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateSelected];
    button.size  = CGSizeMake(50, 50);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem  = item;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)buttonClick:(UIButton *)button{
    button.selected = !button.selected;
    if (!button.selected) {
        [self.deletView setCountWithIndex:0];
    }
    CGFloat height = self.view.height;
    [self.tableView setEditing:button.selected animated:YES];
    if (button.selected) {
        self.tableView.mj_header = nil;
        self.tableView.mj_footer = nil;
    }else{
        [self addRefush];
    }
    [UIView animateWithDuration:0.3 animations:^{
        if (!iPhoneX) {
            self.bootomView.frame = button.selected?CGRectMake(0, height - 50, SCREEN_WIDTH, 50):CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 50);
        }else{
             self.bootomView.frame = button.selected?CGRectMake(0, height - 84, SCREEN_WIDTH, 84):CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 84);
        }
        
    }];
}
#pragma mark - tableView 的操作部分
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        PlayInfoModel *model  = self.dataSorces [indexPath.row];
        
        model.isSeted = YES;
        
        [self deleted];
        
        [self.dataSorces removeObjectAtIndex:indexPath.row];
        
        [self.tableView reloadData];
        
        
        
    }
}
///多选删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.isEditing) {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}

-(BootomDelegateView *)deletView{
    if (!_deletView) {
        _deletView = [Tools XJ_XibWithName:@"BootomDelegateView"];
        __weak typeof(self)weakSelf  = self;
        _deletView.buttonClick = ^(NSString * _Nonnull title) {
            if ([title containsString:@"全选"]) {
                [weakSelf choseAllOrCanCel:YES];
            }else if ([title containsString:@"取消"]){
                [weakSelf choseAllOrCanCel:NO];
            }else{
                [weakSelf deleted];
            }
        };
 
    }
    return _deletView;
}

-(UIView *)bootomView{
    if (!_bootomView) {
        _bootomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 50)];
        if (iPhoneX) {
            _bootomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 84)];
        }
        _bootomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_bootomView addSubview:self.deletView];
        [self.deletView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.left.mas_equalTo(self->_bootomView);
            make.height.mas_equalTo(@50);
        }];
    }
    return _bootomView;
}

///选中模式下删除！！！！！！
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing) {
        PlayInfoModel *model = self.dataSorces[indexPath.row];
        model.isSeted = !model.isSeted;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (PlayInfoModel *choseModel in self.dataSorces) {
            if (choseModel.isSeted) {
                [array addObject:choseModel];
            }
        }
        [self.deletView setCountWithIndex:array.count];
        
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing) {
        PlayInfoModel *model = self.dataSorces[indexPath.row];
        model.isSeted = !model.isSeted;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (PlayInfoModel *choseModel in self.dataSorces) {
            if (choseModel.isSeted) {
                [array addObject:choseModel];
            }
        }
        [self.deletView setCountWithIndex:array.count];
        
    }
}


///实现全选
-(void)choseAllOrCanCel:(BOOL)isChoseAll{
    for (PlayInfoModel *model in self.dataSorces) {
        model.isSeted = isChoseAll;
    }
    [self.deletView setCountWithIndex:self.dataSorces.count];
    ///在实现TableView 的选中
    for (int i = 0; i<[self.dataSorces count]; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        if (isChoseAll) {
             [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
        }else{
            [self.tableView deselectRowAtIndexPath:path animated:YES];
        }
    }
    if (isChoseAll) {
         [self.deletView setCountWithIndex:self.dataSorces.count];
    }else{
        [self.deletView setCountWithIndex:0];
        [self.tableView layoutIfNeeded];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
   
}
#pragma mark - 点击事件
///实现删除
-(void)deleted{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSMutableArray *array_loop = [self.dataSorces mutableCopy];
    for (PlayInfoModel *model in array_loop) {
        if (model.isSeted) {
            [array addObject:model.id];
            [self.dataSorces removeObject:model];
        }
    }
    [self.tableView reloadData];
    if ([array count]<1) {
        [Tools showStatusWithString:@"请选中您想删除的条目"];
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:array forKey:@"id"];
    [dict setObject:@"1" forKey:@"mid"];
    [dict setObject:@"4" forKey:@"eid"];
    [HttpTool POST:[SY_eventDeleted getWholeUrl] param:dict success:^(id responseObject) {
        [Tools showSuccessWithString:[responseObject objectForKey:@"message"]];
    } error:^(NSString *error) {
    }];
    
}








@end
