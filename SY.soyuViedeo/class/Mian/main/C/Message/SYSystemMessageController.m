//
//  SYSystemMessageController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSystemMessageController.h"
#import "SYMessageCell.h"
#import "SYStemMessage.h"//系统消息

@interface SYSystemMessageController ()

@end

@implementation SYSystemMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYMessageCell" bundle:nil] forCellReuseIdentifier:@"SYMessageCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self getMessage];
    self.tableView.mj_header = [SYGifHeader headerWithRefreshingBlock:^{
        [self.dataSorces removeAllObjects];
        self.SYindex = 1;
        [self getMessage];
    }];
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_footer = [SYGifFoot footerWithRefreshingBlock:^{
        if (self.isHaveNextPage) {
            self.SYindex++;
            [weakSelf getMessage];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSorces count];;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYMessageCell"];
    cell.cellType = 0;
    SYStemMessage *message = self.dataSorces[indexPath.row];
    cell.titile.text = message.title;
    cell.time.text = message.message_time;
    cell.countent.text = message.content;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     SYStemMessage *message = self.dataSorces[indexPath.row];
    if (message.cellHeight>0) {
        return message.cellHeight;
    }else{
        message.cellHeight = 77+[Tools XJCalculateTheSizeWithFont:[UIFont systemFontOfSize:13] andWithText:message.content andWithWidthMAX:SCREEN_WIDTH-35].height;
        return message.cellHeight;
    }
}

-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(self.SYindex) forKey:@"page"];
    [dict setObject:@(20) forKey:@"pageSize"];
    [HttpTool POST:[SY_systemMessage getWholeUrl] param:dict success:^(id responseObject) {
        self.isHaveNextPage = [[[responseObject objectForKey:@"data"] objectForKey:@"list"] count]<20?NO:YES;
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"]objectForKey:@"list"]) {
            SYStemMessage *message = [SYStemMessage mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:message];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
    } error:^(NSString *error) {
        
    }];
}

@end
