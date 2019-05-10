//
//  SYMianLiveController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYMianLiveController.h"
#import "SYTableViewHeader.h"
#import "SYLiveListCell.h"
#import "SYCollectionModel.h"
#import "LiveListModel.h"
#import <XWDatabase.h>
@interface SYMianLiveController ()
@property(strong,nonatomic)NSArray *sectionArray;
@property(strong,nonatomic)NSArray *array_history;


@end

@implementation SYMianLiveController

// 使用系统的生命周期方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getMessage];
    [XWDatabase getModels:LiveListModel.class sortColumn:@"time" isOrderDesc:YES completion:^(NSArray * _Nullable objs) {
        //按照降序查询;
        self.array_history = objs;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView XJRegisHeaderOrFooterforNibWithName:@"SYTableViewHeader"];
    [self.tableView XJRegisCellWithNibWithName:@"SYLiveListCell"];
    NSArray *sectionArrary = @[@"我的收藏",@"历史记录",@"自定义频道"];
    self.tableView.rowHeight = 60;
    self.sectionArray = sectionArrary;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SYTableViewHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SYTableViewHeader"];
    header.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [header.button setImage:[UIImage imageNamed:@"点点点"] forState:UIControlStateNormal];
    header.title.font = [UIFont systemFontOfSize:13];
    header.title.textColor = [UIColor lightGrayColor];
    header.title.text =self.sectionArray[section];
    __weak typeof(self)weakSelf = self;
    if (section==0) {
        header.click = ^{
            [weakSelf showAlrertWithTitle:@"提示" andWithMessage:@"是否要清空我的收藏" andWithCancelButtonTitle:@"取消" andWithOKButtonTitle:@"清空我的收藏" andWithOKBlock:^{
                [weakSelf cancelAllCollection];
            }];
        };
    }else{
        header.click = ^{
            [weakSelf showAlrertWithTitle:@"提示" andWithMessage:@"是否要清空我的历史记录" andWithCancelButtonTitle:@"取消" andWithOKButtonTitle:@"清空我的历史记录" andWithOKBlock:^{
                [weakSelf clearHistorys];
            }];
        };
    }
    if (section==0) {
          if([self.dataSorces count]<1)return nil;
    }else{
        
        if([self.array_history count]<1)return nil;
    }
  
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYLiveListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYLiveListCell"];
    if (indexPath.section==0) {
        cell.model = self.dataSorces[indexPath.row];
    }else{
        cell.liveModel = self.array_history[indexPath.row];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
         return [self.dataSorces count]>0?40:CGFLOAT_MIN;
    }else{
        return [self.array_history count]>0?40:CGFLOAT_MIN;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return [self.dataSorces count];
    }else{
        return [self.array_history count];
    }
}

-(void)getMessage{
    
    if ([Tools isNeedLogin]) {
        return;
    }
    [self.dataSorces removeAllObjects];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@(2) forKey:@"eid"];
    [dict setObject:@(100) forKey:@"pageSize"];
    [HttpTool POST:[SY_CollectChannel getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            SYCollectionModel *model = [SYCollectionModel mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:model];
        }
        [self.tableView reloadData];
       
    } error:^(NSString *error) {
        
    }];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
}
///清空我的收藏
-(void)cancelAllCollection{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (SYCollectionModel *model in self.dataSorces) {
           NSNumber *number = [NSNumber numberWithInt:[model.id intValue]];
        [array addObject:number];
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"2" forKey:@"eid"];
    [dict setObject:array forKey:@"ids"];
    [HttpTool POST:[SY_ORder getWholeUrl] param:dict success:^(id responseObject) {
        [self.dataSorces removeAllObjects];
        [self.tableView reloadData];
    } error:^(NSString *error) {
        
    }];
}

-(void)clearHistorys{
    self.array_history = @[];
    [self.tableView reloadData];
    [XWDatabase clearModel:LiveListModel.class completion:^(BOOL isSuccess) {
        
    }];
}


@end
