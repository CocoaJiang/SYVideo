//
//  SYcollectionChildVc.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYcollectionChildVc.h"
#import "C_SYcollectionViewCell.h"
#import "C_SYCollectionModel.h"
#import "BootomDelegateView.h"
@interface SYcollectionChildVc ()
@property(strong,nonatomic)BootomDelegateView *deletView; //f容器View
@property(strong,nonatomic)UIView *bootomView;

@end

@implementation SYcollectionChildVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView.rowHeight = 90;
    [self.tableView XJRegisCellWithNibWithName:@"C_SYcollectionViewCell"];
    [self.view addSubview:self.bootomView];
    [self addRefush];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    C_SYcollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"C_SYcollectionViewCell"];
    [cell.icon XJ_setImageWithURLString:self.model.data[indexPath.row].pic];
    cell.name.text = self.model.data[indexPath.row].name;
    cell.disLanel.text = self.model.data[indexPath.row].remark;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model.data count];
}
-(void)setModel:(C_SYCollectionModel *)model{
    _model = model;
    [self.tableView reloadData];
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

///实现全选
-(void)choseAllOrCanCel:(BOOL)isChoseAll{
    for (C_itemModel *model in self.model.data) {
        model.isseleted = isChoseAll;
    }
    [self.deletView setCountWithIndex:self.dataSorces.count];
    ///在实现TableView 的选中
    for (int i = 0; i<[self.model.data count]; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        if (isChoseAll) {
            [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
        }else{
            [self.tableView deselectRowAtIndexPath:path animated:YES];
        }
    }
    if (isChoseAll) {
        [self.deletView setCountWithIndex:self.model.data.count];
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
    NSMutableArray *array_loop = [self.model.data mutableCopy];
    for (C_itemModel *model in array_loop) {
        if (model.isseleted) {
            [array addObject:model.id];
            [self.model.data removeObject:model];
        }
    }
    [self.tableView reloadData];
    self.tableView.editing = NO;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
         CGFloat height = self.view.height;
        if (!iPhoneX) {
            self.bootomView.frame = self.tableViewEditing?CGRectMake(0, height, SCREEN_WIDTH, 50):CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 50);
        }else{
            self.bootomView.frame = self.tableViewEditing?CGRectMake(0, height, SCREEN_WIDTH, 84):CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 84);
        }
    }completion:^(BOOL finished) {
        //回调到控制器 取消
        if (weakSelf.cancel) {
            weakSelf.cancel();
        }
    }];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:array forKey:@"id"];
    [dict setObject:@"1" forKey:@"mid"];
    [dict setObject:@"2" forKey:@"eid"];
    [HttpTool POST:[SY_eventDeleted getWholeUrl] param:dict success:^(id responseObject) {
        [Tools showSuccessWithString:[responseObject objectForKey:@"message"]];
    } error:^(NSString *error) {
    }];
    
}
-(void)addRefush{
    __weak typeof(self)weakSelf= self;
    self.tableView.mj_header = [SYGifHeader headerWithRefreshingBlock:^{
        weakSelf.SYindex = 1;
        [weakSelf.model.data removeAllObjects];
        [weakSelf getMessage];
        
    }];
    self.tableView.mj_footer = [SYGifFoot footerWithRefreshingBlock:^{
        if (self.isHaveNextPage) {
            weakSelf.SYindex++;
            [weakSelf getMessage];
        }else{
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    }];
}
-(void)setTableViewEditing:(BOOL)tableViewEditing{
    _tableViewEditing =tableViewEditing;
    if (!tableViewEditing) {
        [self.deletView setCountWithIndex:0];
    }
    CGFloat height = self.view.height;
    [self.tableView setEditing:tableViewEditing animated:YES];
    if (tableViewEditing) {
        self.tableView.mj_header = nil;
        self.tableView.mj_footer = nil;
    }else{
        [self addRefush];
    }
    [UIView animateWithDuration:0.3 animations:^{
        if (!iPhoneX) {
            self.bootomView.frame = tableViewEditing?CGRectMake(0, height - 50, SCREEN_WIDTH, 50):CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 50);
        }else{
            self.bootomView.frame = tableViewEditing?CGRectMake(0, height - 84, SCREEN_WIDTH, 84):CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 84);
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

///选中模式下删除！！！！！！
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing) {
        C_itemModel *model = self.model.data[indexPath.row];
        model.isseleted = !model.isseleted;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (C_itemModel *choseModel in self.model.data) {
            if (choseModel.isseleted) {
                [array addObject:choseModel];
            }
        }
        [self.deletView setCountWithIndex:array.count];
        
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing) {
        C_itemModel *model = self.model.data[indexPath.row];
        model.isseleted = !model.isseleted;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (C_itemModel *choseModel in self.model.data) {
            if (choseModel.isseleted) {
                [array addObject:choseModel];
            }
        }
        [self.deletView setCountWithIndex:array.count];
        
    }
}

///加载更多
-(void)getMessage{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.model.type_id forKey:@"type_id"];
    [dict setObject:@(self.SYindex) forKey:@"page"];
    [dict setObject:@"20" forKey:@"pageSize"];
    [HttpTool POST:[SY_CollectionLoad getWholeUrl] param:dict success:^(id responseObject) {
        if ([[[responseObject objectForKey:@"data"] objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
            if ([[[responseObject objectForKey:@"data"] objectForKey:@"list"] count]<20) {
                self.isHaveNextPage = NO;
            }
        }
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            C_itemModel *model   = [C_itemModel mj_objectWithKeyValues:dict];
            [array addObject:model];
        }
        [self.model.data addObjectsFromArray:array];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } error:^(NSString *error) {
        
    }];
}



@end
