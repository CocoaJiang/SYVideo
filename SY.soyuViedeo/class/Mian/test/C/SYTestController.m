//
//  SYTestController.m
//  S.SouyunVideo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYTestController.h"
#import "textModel.h"
#import "testCell.h"
#import "SYTextTopView.h"
#import "SYTestThreeItem.h"
#import "SYmonkeyHistory.h"
#import "SYTextCenterController.h"
#import "SYNewLoginViewController.h"
#import "SYMyOrderController.h"


@interface SYTestController ()
@property(strong,nonatomic)textModel *textModel;
@property(strong,nonatomic)SYTextTopView *topView;
@property(strong,nonatomic)SYTestThreeItem *threeItem;
@property(strong,nonatomic)SYmonkeyHistory *historyController;
@property(strong,nonatomic)SYTextCenterController *textController;


@end

@implementation SYTestController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"任务中心";
    [self.view addSubview:self.topView];
    [self.view addSubview:self.threeItem];
    [self.threeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(@80);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.threeItem.mas_bottom);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"testCell" bundle:nil] forCellReuseIdentifier:@"testCell"];
    self.tableView.rowHeight=80;
    [self getmessage];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getmessage) name:@"MoneyRush" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resush) name:@"loginSuccess" object:nil];
    self.textController = [[SYTextCenterController alloc]init];
    self.historyController = [[SYmonkeyHistory alloc]init];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    testCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell"];
    __weak typeof(self)weakSelf = self;
    cell.refush = ^{
        [weakSelf getmessage];
    };
    cell.model  = self.dataSorces[indexPath.row];
    return cell;
}
-(void)getmessage{
    [HttpTool POST:[SY_testList getWholeUrl] param:nil success:^(id responseObject) {
        self.textModel = [textModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        self.dataSorces = (NSMutableArray *)self.textModel.task_ist;
        [self.tableView reloadData];
        [self addData];
    } error:^(NSString *error) {
    }];
    
}

-(void)addData{
    [SYUSERINFO info].userInfo.user_points = self.textModel.user_points;
    [self.threeItem addDataWithInvateButtonCount:self.textModel.invite_people andWithMonkey:self.textModel.user_points andWithQianDaoDays:self.textModel.signin_num];
    //回调刷新
    [self.historyController refush];
    [self.textController refush];
}

-(SYTextTopView *)topView{
    if (!_topView) {
        _topView = [[SYTextTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        _topView.type = twoButtonType;
        __weak typeof(self)weakSelf =self;
        _topView.topButtonClick = ^(NSString * _Nonnull title) {
            if ([Tools isNeedLogin]) {
                [weakSelf.navigationController pushViewController:[SYNewLoginViewController new] animated:YES];
                return ;
            }
            if ([title isEqualToString:@"兑换中心"]) {
                [weakSelf.navigationController pushViewController:weakSelf.textController animated:YES];
            }else{
                [weakSelf.navigationController pushViewController:[SYMyOrderController new] animated:YES];
            }
        };
    }
    return _topView;
}
-(SYTestThreeItem *)threeItem{
    if (!_threeItem) {
        _threeItem = [Tools XJ_XibWithName:@"SYTestThreeItem"];
        [_threeItem sizeToFit];
        __weak typeof(self)weakSelf = self;
        _threeItem.buttonClick = ^(NSInteger index) {
            if (index ==1) {
                if ([Tools isNeedLogin]) {
                    [weakSelf.navigationController pushViewController:[SYNewLoginViewController new] animated:YES];
                    return ;
                }
                [weakSelf.navigationController pushViewController:weakSelf.historyController animated:YES];
            }
        };
    }
    return _threeItem;
}

-(void)resush{
    [self getmessage];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
