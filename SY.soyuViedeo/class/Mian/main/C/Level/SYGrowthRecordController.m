//
//  SYGrowthRecordController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYGrowthRecordController.h"
#import "SYCoin_log.h"

@interface SYGrowthRecordController ()

@end

@implementation SYGrowthRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成长记录";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView XJRegisCellWithNibWithName:@"SYCoin_log"];
    self.tableView.mj_header = [SYGifHeader headerWithRefreshingBlock:^{
        [self.dataSorces removeAllObjects];
        self.SYindex=1;
        [self getMessage];
    }];
    self.tableView.mj_footer = [SYGifFoot footerWithRefreshingBlock:^{
        if (self.isHaveNextPage) {
            self.SYindex++;
            [self getMessage];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    [self getMessage];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYCoin_log *logCell = [tableView dequeueReusableCellWithIdentifier:@"SYCoin_log"];
    levelLog *logmodel = self.dataSorces[indexPath.row];
    logCell.titleLanel.text =logmodel.info;
    logCell.timeLabel.text = logmodel.date_time;
    logCell.coinLabel.text = logmodel.exp;
    return logCell;
}

-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(self.SYindex) forKey:@"page"];
    [dict setObject:@(20) forKey:@"pageSize"];
    [HttpTool POST:[SY_Leavelog getWholeUrl] param:dict success:^(id responseObject) {
        self.isHaveNextPage = [[[responseObject objectForKey:@"data"] objectForKey:@"list"] count]<20?NO:YES;
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            levelLog *model = [levelLog mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:model];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } error:^(NSString *error) {
        
    }];
    
}

@end


@implementation levelLog


@end
