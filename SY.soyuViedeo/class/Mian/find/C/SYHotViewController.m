//
//  SYHotViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHotViewController.h"
#import "SYhotViedeCell.h"
#import "SYHotDetail.h"
#import "FindModel.h"

@interface SYHotViewController ()

@end

@implementation SYHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self getMessage];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYhotViedeCell" bundle:nil] forCellReuseIdentifier:@"SYhotViedeCell"];
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
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYhotViedeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYhotViedeCell"];
      hotModel *model = self.dataSorces[indexPath.row];
    cell.model =model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    hotModel *model = self.dataSorces[indexPath.row];
    if (model.height>0) {
        return model.height+270;
    }else{
      model.height =[Tools XJCalculateTheSizeWithFont:[UIFont systemFontOfSize:15] andWithText:model.title andWithWidthMAX:SCREEN_WIDTH-43].height;
        return   model.height;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSorces count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SYHotDetail *controller = [[SYHotDetail alloc]init];
    hotModel *model = self.dataSorces[indexPath.row];
    controller.idString = model.id;
    controller.titleString = model.title;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)getMessage{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(self.SYindex) forKey:@"page"];
    [dict setObject:@(10) forKey:@"pageSize"];
    //拉数据………………
    [HttpTool POST:[SY_discovery getWholeUrl] param:dict success:^(id responseObject) {
        self.isHaveNextPage = [[[responseObject objectForKey:@"data"] objectForKey:@"list"] count]<10?NO:YES;
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            hotModel *model = [hotModel mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:model];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
           } error:^(NSString *error) {
               
           }];
    
    
}

@end
