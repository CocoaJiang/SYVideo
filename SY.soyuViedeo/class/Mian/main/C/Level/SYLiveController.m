//
//  SYLiveController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYLiveController.h"
#import "SYLeavelHeaderView.h"
#import "SYLevelPointHeaderView.h"
#import "SYLeveModel.h"
#import "SYLevelTaskCell.h"
#import "SYEXPCell.h"
#import "SYGrowthRecordController.h"


@interface SYLiveController ()
@property(strong,nonatomic)SYLeavelHeaderView *headerView;
@property(strong,nonatomic)SYLeveModel *model;


@end

@implementation SYLiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNAV];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 110);
    [view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
    self.tableView.tableHeaderView = view;
    [self.tableView XJRegisHeaderOrFooterforNibWithName:@"SYLevelPointHeaderView"];
    [self.tableView XJRegisHeadeORfootWithClass:NSStringFromClass([UITableViewHeaderFooterView class])];
    [self.tableView XJRegisCellWithNibWithName:@"SYLevelTaskCell"];
    [self getMessage];
}

-(void)setNAV{
    self.title = @"我的等级";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"成长记录" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem= item;
}
-(void)buttonClick{
    [self.navigationController pushViewController:[SYGrowthRecordController new] animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        SYLevelTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYLevelTaskCell"];
        cell.text.text = self.model.task[indexPath.row];
        return cell;
    }else{
        NSString *idstring = @"instring";
        SYEXPCell *cell = [tableView dequeueReusableCellWithIdentifier:idstring];
        if (!cell) {
            cell = [[SYEXPCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idstring];
        }
        cell.array = self.model.group;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 45;
    }else{
        return SCREEN_WIDTH/2.5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else{
        return CGFLOAT_MIN;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SYLevelPointHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SYLevelPointHeaderView"];
    if (section==0) {
        header.title.text = @"如何获得";
    }else{
        header.title.text = @"每级经验";
    }
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    UIView *view = [[UIView  alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [footer.contentView addSubview:view];
    view.backgroundColor = RGBA(250, 250, 250, 1);
    view.frame = footer.bounds;
    if (section==0) {
        return footer;
    }else{
        return nil;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return [self.model.task count];
    }else{
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(SYLeavelHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [Tools XJ_XibWithName:@"SYLeavelHeaderView"];
    }
    return _headerView;
}

-(void)getMessage{
    [HttpTool POST:[SY_Level getWholeUrl] param:nil success:^(id responseObject) {
        self.model = [SYLeveModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        [self addData];
        [self.tableView reloadData];
    } error:^(NSString *error) {
        
    }];
}
-(void)addData{
    self.headerView.disLabel.text = [NSString stringWithFormat:@"%@  距离下一等级还差%@经验  %@",self.model.level,self.model.next_exp,self.model.next_level];
    self.headerView.level.text = [NSString stringWithFormat:@"  %@  ",self.model.level];
    self.headerView.nickName.text = [SYUSERINFO info].userInfo.user_nick_name;
    
    float total = [self.model.next_exp floatValue] + [[SYUSERINFO info].userInfo.user_exp floatValue];
    
    float currExp = [[SYUSERINFO info].userInfo.user_exp floatValue];
    
    CGFloat value = currExp/total;
    
    self.headerView.progress.progress = value;
    
}

@end
