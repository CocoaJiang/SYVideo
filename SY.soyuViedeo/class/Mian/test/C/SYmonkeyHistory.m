//
//  SYmonkeyHistory.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/16.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYmonkeyHistory.h"
#import "SYMonkeyTopView.h"
#import "SYHUView.h"//弧度。。
#import "SYCoin_log.h"//cell
#import "SYCoinLogsModel.h"//模型
#import "SYTableViewHeader.h"
@interface SYmonkeyHistory ()
@property(strong,nonatomic)SYMonkeyTopView *topView;
@property(strong,nonatomic)SYHUView *huView;


@end

@implementation SYmonkeyHistory


-(void)viewWillAppear:(BOOL)animated{
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@记录",[SYUSERINFO info].systemModel.coin_name];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@140);
    }];
    [self.view addSubview:self.huView];
    [self.huView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(@25);
    }];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom).offset(-20);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.view.bottom).offset(-20);
    }];
    self.tableView.backgroundColor = RGBA(250, 250, 250, 1);
    [self.tableView XJRegisCellWithNibWithName:@"SYCoin_log"];
    [self.tableView XJRegisHeaderOrFooterforNibWithName:@"SYTableViewHeader"];
    self.tableView.rowHeight = 75;
    self.tableView.mj_header = [SYGifHeader headerWithRefreshingBlock:^{
        [self.dataSorces removeAllObjects];
        self.SYindex = 1;
        [self getMessageWithPage:self.SYindex];
    }];
    self.tableView.mj_footer = [SYGifFoot footerWithRefreshingBlock:^{
        if (self.isHaveNextPage) {
            self.SYindex++;
            [self getMessageWithPage:self.SYindex];
        }else{
            [self.tableView.mj_footer endRefreshing];
        
        }
    }];
}

-(void)refush{
      [self.topView setCoinsWithCoins:[SYUSERINFO info].userInfo.user_points];
}

-(SYMonkeyTopView *)topView{
    if (!_topView) {
        _topView = [Tools XJ_XibWithName:@"SYMonkeyTopView"];
        [_topView setCoinsWithCoins:[SYUSERINFO info].userInfo.user_points];
        [_topView sizeToFit];
    }
    return _topView;
}
-(SYHUView *)huView{
    if (!_huView) {
        _huView = [[SYHUView alloc]init];
        _huView.backgroundColor = KappBlue;
    }
    return _huView;
}

-(void)getMessageWithPage:(NSInteger)page{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(page) forKey:@"page"];
    [dict setObject:@(20) forKey:@"pageSize"];
    [HttpTool NOACtionPOST:[SY_coin_log getWholeUrl] param:dict success:^(id responseObject) {
        self.isHaveNextPage = [[[responseObject objectForKey:@"data"] objectForKey:@"list"] count]<20?NO:YES;
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            SYCoinLogsModel *model = [SYCoinLogsModel mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:model];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
             [self.tableView reloadData];
        
    } error:^(NSString *error) {
        
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYCoin_log *cell  = [tableView dequeueReusableCellWithIdentifier:@"SYCoin_log"];
    cell.model =  self.dataSorces[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSorces count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SYTableViewHeader *header= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SYTableViewHeader"];
    [header.button setHidden:YES];
    header.title.font = [UIFont boldSystemFontOfSize:16];
    header.title.text = [NSString stringWithFormat:@"%@明细",[SYUSERINFO info].systemModel.coin_name];
    header.title.textColor = [UIColor blackColor];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
    
}


@end
