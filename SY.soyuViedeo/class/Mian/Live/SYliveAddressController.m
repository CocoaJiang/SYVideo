//
//  SYliveAddressController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYliveAddressController.h"
#import "LiveModel.h"
#import "LiveListModel.h"
#import "SYLivePlayerController.h"
#import "SYLiveListCell.h"

@interface SYliveAddressController ()
//分控制器写
@property(strong,nonatomic)UITableView *leftTableView;
@property(strong,nonatomic)UITableView *rightTableView;
@property(strong,nonatomic)NSMutableArray *leftArray;
@property(strong,nonatomic)NSMutableArray *rightArray;


@end

@implementation SYliveAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(@70);
    }];
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.leftTableView.mas_right);
    }];
    [self.rightTableView XJRegisCellWithNibWithName:@"SYLiveListCell"];
    [self getMessage];
}
-(UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 70;
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.showsHorizontalScrollIndicator = NO;
        _leftTableView.tableFooterView = [UIView new];
        [_leftTableView setHidenLine];
        [_leftTableView setOthers];
    }
    return _leftTableView;
}

-(UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 70;
        _rightTableView.showsHorizontalScrollIndicator = NO;
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.tableFooterView = [UIView new];
        [_rightTableView setHidenLine];
        [_rightTableView setOthers];
    }
    return _rightTableView;
}

///获取地方台分类
-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [HttpTool POST:[SY_liveLocal getWholeUrl] param:dict success:^(id responseObject) {
        int i = 0;
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            LiveModel *model  = [LiveModel mj_objectWithKeyValues:dict];
            [self.leftArray addObject:model];
            if (i==0) {
                model.isSeted = YES;
            }
            i++;
        }
        [self.leftTableView reloadData];
        if ([self.leftArray count]>0) {
            LiveModel *model = self.leftArray[0];
            [self getRightMessageWithIDString:model.id];
        }
    } error:^(NSString *error) {
        
    }];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_leftTableView) {
        NSString *idstring  = @"leftTableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idstring];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idstring];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        LiveModel *model = self.leftArray[indexPath.row];
        cell.textLabel.text =model.name;
        if (model.isSeted) {
            cell.textLabel.textColor = KAPPMAINCOLOR;
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }else{
            cell.textLabel.textColor = [UIColor darkTextColor];
            cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        return cell;
    }else{
        SYLiveListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYLiveListCell"];
        LiveListModel *model = self.rightArray[indexPath.row];
        cell.liveModel  = model;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_leftTableView) {
        //去请求分类填充右边的框架
        for (LiveModel *model in self.leftArray) {
            model.isSeted = NO;
        }
        LiveModel *model = self.leftArray[indexPath.row];
        model.isSeted = YES;
        [_leftTableView reloadData]; 
        [self getRightMessageWithIDString:model.id];
    }else{
        LiveListModel *model = self.rightArray[indexPath.row];
        SYLivePlayerController *controller = [[SYLivePlayerController alloc]init];
        controller.idString = model.ID;
        controller.savemodel = model;
        [self.navigationController pushViewController:controller animated:YES];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_leftTableView) {
        return [self.leftArray count];
    }
    return [self.rightArray count];
}

-(void)getRightMessageWithIDString:(NSString *)idString{
    [self.rightArray removeAllObjects];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:idString forKey:@"id"];
    [dict setObject:@(100) forKey:@"pageSize"];
    [HttpTool POST:[SY_liveList getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            LiveListModel *model =[LiveListModel mj_objectWithKeyValues:dict];
            [self.rightArray addObject:model];
        }
        [self.rightTableView reloadData];
    } error:^(NSString *error) {
        
    }];
}











-(NSMutableArray *)leftArray{
    if (!_leftArray) {
        _leftArray = [[NSMutableArray alloc]init];
    }
    return _leftArray;
}
-(NSMutableArray *)rightArray{
    if (!_rightArray) {
        _rightArray = [[NSMutableArray alloc]init];
    }
    return _rightArray;
}

@end
