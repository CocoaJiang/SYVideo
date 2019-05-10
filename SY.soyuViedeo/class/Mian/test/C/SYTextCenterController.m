//
//  SYTextCenterController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/20.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYTextCenterController.h"
#import "SYTextTopView.h"
#import "SYExchangeCenter.h"
#import "SYTableViewHeader.h"
#import "SY_exchange.h"
@interface SYTextCenterController ()
@property(strong,nonatomic)SYTextTopView *topView;
@property(strong,nonatomic)SY_exchange *exchangeModel;

@end

@implementation SYTextCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换中心";
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYExchangeCenter" bundle:nil] forCellReuseIdentifier:@"SYExchangeCenter"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYTableViewHeader" bundle:nil ] forHeaderFooterViewReuseIdentifier:@"SYTableViewHeader"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topView.mas_bottom);
    }];
    self.tableView.rowHeight=70;
    
    [self getMessage];
    
}

-(void)refush{
    [self.topView setLabelText:[SYUSERINFO info].userInfo.user_points];
}

-(SYTextTopView *)topView{
    if (!_topView) {
        _topView = [[SYTextTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        _topView.type=oneLableType;
        [_topView setLabelText:[SYUSERINFO info].userInfo.user_points];
    }
    return _topView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section==0?[self.exchangeModel.record count]:[self.exchangeModel.list count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYExchangeCenter *cell = [tableView dequeueReusableCellWithIdentifier:@"SYExchangeCenter"];
    cell.item  = indexPath.section==0?self.exchangeModel.record[indexPath.row]:self.exchangeModel.list[indexPath.row];
    __weak typeof(self)weakSelf =  self;
    cell.buttonClick = ^(NSString * _Nonnull idString) {
      ///去兑换
        [weakSelf changeWithID:idString];
        
    };
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SYTableViewHeader *header= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SYTableViewHeader"];
    [header.button setHidden:YES];
    header.title.font = [UIFont boldSystemFontOfSize:16];
    if (section==1) {
        header.hidden = [self.exchangeModel.list count]<1?YES:NO;
            header.title.text = @"未兑换的特权";
    }else{
       header.hidden = [self.exchangeModel.record count]<1?YES:NO;
            header.title.text = @"已兑换的特权";
    }
    header.title.textColor = [UIColor blackColor];
    
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return  [self.exchangeModel.record count]<1?CGFLOAT_MIN:40;
    }else{
        return  [self.exchangeModel.list count]<1?CGFLOAT_MIN:40;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return  [self.exchangeModel.record count]<1?CGFLOAT_MIN:20;
    }else{
        return  [self.exchangeModel.list count]<1?CGFLOAT_MIN:20;
    }
}

-(void)getMessage{
    [HttpTool POST:[SY_ChangeList getWholeUrl] param:nil success:^(id responseObject) {
         self.exchangeModel = [SY_exchange mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        for (SY_changItem *model in self.exchangeModel.record) {
            model.section=0;
        }
        for (SY_changItem *model in self.exchangeModel.list) {
            model.section=1;
        }
        [self.tableView reloadData];
    } error:^(NSString *error) {
        
    }];
}

-(void)changeWithID:(NSString *)idString{
    NSMutableDictionary *dict =  [[NSMutableDictionary alloc]init];
    [dict setObject:idString forKey:@"id"];
    [HttpTool POST:[SY_exchangeID getWholeUrl] param:dict success:^(id responseObject) {
        [Tools showErrorWithString:@"兑换成功"];
        [self getMessage];
        //在此发送通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"MoneyRush" object:nil];
    } error:^(NSString *error) {
        
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
