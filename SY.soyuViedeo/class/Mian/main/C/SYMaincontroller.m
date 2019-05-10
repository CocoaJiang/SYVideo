//
//  SYMaincontroller.m
//  S.SouyunVideo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYMaincontroller.h"
#import "SYPersonHeader.h"
#import "SYPersonItemCell.h"
#import "SYPerSonOthersCell.h"
#import "SYPersonHistoryCell.h"
#import "SYSetViewController.h"
#import "SYMessageController.h"
#import "SYTheSkinViewController.h"
#import "SYLoginController.h"
#import "userInfo.h"
//离线缓存
#import "SYcaseViewController.h"
//收藏
#import "SYCollectionController.h"
//兑换码
#import "SYExchageCodeController.h"
///历史记录。。。。
#import "PlayInfoModel.h"
///等级
#import "SYLiveController.h"
///未登录的样子
#import "SYNOLoginedView.h"
///新登录页面
#import "SYNewLoginViewController.h"
///新注册页面
#import "SYnewRegisController.h"
@interface SYMaincontroller ()
@property(strong,nonatomic)SYPersonHeader *personHeader;
@property(strong,nonatomic)NSMutableArray *itemArray;
@property(strong,nonatomic)userInfo *info;
@property(strong,nonatomic)SYNOLoginedView *noLoginView;

@end
@implementation SYMaincontroller



-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNAV];
    [self.view addSubview:self.tableView];
    UIView *view_x = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
    [view_x addSubview:self.personHeader];
    [view_x addSubview:self.noLoginView];
    [self.personHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view_x);
    }];
    [self.noLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.mas_equalTo(view_x);
    }];
    self.tableView.tableHeaderView = view_x;
    [self.tableView registerNib:[UINib nibWithNibName:@"SYPersonItemCell" bundle:nil] forCellReuseIdentifier:@"SYPersonItemCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYPerSonOthersCell" bundle:nil] forCellReuseIdentifier:@"SYPerSonOthersCell"];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
-(void)setNAV{
    self.navigationController.title = @"";
    UIButton *button_left  = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_left setImage:[UIImage imageNamed:@"icon_mine_orcode"] forState:UIControlStateNormal];
    [button_left setTitle:@"  扫一扫" forState:UIControlStateNormal];
    [button_left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button_left.titleLabel.font = [UIFont systemFontOfSize:12];
    [button_left sizeToFit];
    button_left.tag=99;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button_left];
    [button_left addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = item;
    NSArray *array = @[@"icon_mine_setting",@"icon_mine_information",@"皮肤"];
    NSMutableArray *items = [[NSMutableArray alloc]init];
    for (int i = 0; i<2; i++) {
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        button.size = CGSizeMake(50, 50);
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
        [items addObject:item];
    }
    self.navigationItem.rightBarButtonItems = items;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([Tools isNeedLogin]) {
        self.noLoginView.hidden = NO;
        self.personHeader.hidden = YES;
    }else{
        self.noLoginView.hidden = YES;
        self.personHeader.hidden = NO;
    }
    if (![Tools isNeedLogin]) {
        [self getMessage];
        [self getHistory];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


-(void)buttonClick:(UIButton *)button{
    
    if ([Tools isNeedLogin]) {
        SYNewLoginViewController *controller = [[SYNewLoginViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    switch (button.tag) {
        case 99:
            
            break;
        case 100:{
            //设置界面
            SYSetViewController *set = [[SYSetViewController alloc]init];
            [self.navigationController pushViewController:set animated:YES];
        }
            break;
        case 101:{
            SYMessageController *controller = [[SYMessageController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
            break;
        case 102:{
            SYLoginController *controller = [[SYLoginController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
            
            break;
            
        default:
            break;
    }
}

-(SYPersonHeader *)personHeader{
    if (!_personHeader) {
        _personHeader = [Tools XJ_XibWithName:@"SYPersonHeader"];
        _personHeader.headerImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *zer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(levelPOP)];
        [_personHeader.headerImage addGestureRecognizer:zer];
        [_personHeader sizeToFit];
    }
    return _personHeader;
}

//pop
-(void)levelPOP{
    
    [self.navigationController pushViewController:[SYLiveController new] animated:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0||section==1) {
        return 1;
    }else{
        return [self.itemArray count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        SYPersonItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYPersonItemCell"];
        cell.points = [SYUSERINFO info].userInfo.user_points;
        return cell;
    }else if (indexPath.section==2){
        SYPerSonOthersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYPerSonOthersCell"];
        cell.name.text = self.itemArray[indexPath.row];
        return cell;
    }else if (indexPath.section==1){
        NSString *idString  = @"indSrring";
        SYPersonHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
        if (!cell) {
            cell = [[SYPersonHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idString];
        }
        cell.dataSources = self.dataSorces;
        return cell;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        if ([Tools isNeedLogin]) {
            [self.navigationController pushViewController:[SYNewLoginViewController new] animated:YES];
            return;
        }
        NSString *string = self.itemArray[indexPath.row];
        if ([string isEqualToString:@"离线缓存"]) {
            SYcaseViewController *controller = [[SYcaseViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if ([string isEqualToString:@"我的收藏"]){
            SYCollectionController *controller = [[SYCollectionController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if ([string isEqualToString:@"兑换码"]){
            [self.navigationController pushViewController:[SYExchageCodeController new] animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 135;
    }else if (indexPath.section==1){
        return [self.dataSorces count]>0?240:50;
    }else{
        return 55;
    }
}

-(NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = (NSMutableArray *)@[@"离线缓存",@"我的收藏",@"兑换码"];
    }
    return _itemArray;
}

-(void)getMessage{
    [HttpTool NOACtionPOST:[SY_userInfo getWholeUrl] param:nil success:^(id responseObject) {
        self.info = [userInfo mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        [self.tableView reloadData];
        [self addData];
    } error:^(NSString *error) {
        
    }];
    

}
-(void)addData{
    self.personHeader.nickName.text = self.info.user_nick_name;
    self.personHeader.lever.text = [NSString stringWithFormat:@"  %@  ",self.info.level];
    [self.personHeader.headerImage XJ_setImageWithURLString:self.info.user_portrait andWithImageName:@"touxiang"];
    SYUSERINFO *info = [SYUSERINFO info];
    //每次更新新的数据。。。。。。。。
    info.userInfo = self.info;
}

///请求播放记录
-(void)getHistory{
    [self.dataSorces removeAllObjects];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"1" forKey:@"number"];
    [dict setObject:@"10" forKey:@"pageSize"];
    [HttpTool NOACtionPOST:[SY_PlayHistoryInfo getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            PlayInfoModel *palyerInfo = [PlayInfoModel mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:palyerInfo];
        }
        [self.tableView reloadData];
    } error:^(NSString *error) {
        
    }];
}

-(SYNOLoginedView *)noLoginView{
    if (!_noLoginView) {
        _noLoginView = [Tools XJ_XibWithName:@"SYNOLoginedView"];
        __weak typeof(self)weakSelf  = self;
        _noLoginView.buttonClick = ^(NSString * _Nonnull title) {
            if ([title isEqualToString:@"登录"]) {
                SYNewLoginViewController *controller = [[SYNewLoginViewController alloc]init];
              //  SYLoginController *controller = [[SYLoginController alloc]init];
                [weakSelf.navigationController pushViewController:controller animated:YES];
            }else{
                SYnewRegisController *controller = [[SYnewRegisController alloc]init];
                [weakSelf.navigationController pushViewController:controller animated:YES];
            }
            
        };
    }
    return _noLoginView;
}


@end
