//
//  SYLiveChildController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYLiveChildController.h"
#import "SYLiveListCell.h"
#import "LiveListModel.h"
#import "SYLivePlayerController.h"
@interface SYLiveChildController ()
@property(strong,nonatomic)NSString *idString;

@end

@implementation SYLiveChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMessage];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView XJRegisCellWithNibWithName:@"SYLiveListCell"];
    self.tableView.rowHeight = 70;
    self.tableView.mj_header  = [SYGifHeader headerWithRefreshingBlock:^{
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
}


-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.idString forKey:@"id"];
    [dict setObject:@(self.SYindex) forKey:@"page"];
    [dict setObject:@(20) forKey:@"pageSize"];
    [HttpTool POST:[SY_liveList getWholeUrl] param:dict success:^(id responseObject) {
        self.isHaveNextPage = [[[responseObject objectForKey:@"data"] objectForKey:@"list"] count]<20?NO:YES;
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            LiveListModel *model  = [LiveListModel mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:model];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } error:^(NSString *error) {
    }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveListModel *model = self.dataSorces[indexPath.row];
    SYLivePlayerController *controller = [[SYLivePlayerController alloc]init];
    controller.idString  = model.ID;
    controller.savemodel = model;
    [self.navigationController pushViewController:controller animated:YES];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYLiveListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYLiveListCell"];
    LiveListModel *model = self.dataSorces[indexPath.row];
    [cell.icon XJ_setImageWithURLString:model.pic];
    cell.title.text = model.name;
    cell.subTitle.text = model.program;
    return cell;
}



@end


