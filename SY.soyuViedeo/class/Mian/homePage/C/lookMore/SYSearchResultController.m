//
//  SYSearchResultController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/25.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSearchResultController.h"
#import "SYSearchResultCell.h"
#import "HomePageModel.h"
#import "SYVideoPlayerController.h"
static NSString *cellIdstring  = @"SYSearchResultCell";

@interface SYSearchResultController ()

@end

@implementation SYSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView XJRegisCellWithNibWithName:cellIdstring];
    self.tableView.rowHeight = 100;
}
-(SYSearchResultCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdstring];
    cell.model = self.dataSorces[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    item *model = self.dataSorces[indexPath.row];
    SYVideoPlayerController *controller = [[SYVideoPlayerController alloc]init];
    controller.video_id = model.id;
    [self.navigationController pushViewController:controller animated:YES];
    
}



-(void)getMessgeWithPage:(NSString *)title andWithPage:(NSInteger)page{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:title forKey:@"keyword"];
    [dict setObject:@(page) forKey:@"page"];
    [dict setObject:@(20) forKey:@"pageSize"];
    [dict setObject:[Tools getUUID] forKey:@"deviceId"];
    [HttpTool POST:[SY_SearchList getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            item *model = [item mj_objectWithKeyValues:dict];
            model.keyWords = title;
            [self.dataSorces addObject:model];
        }
        [self.tableView reloadData];
        NSLog(@"%@",responseObject);
        
    } error:^(NSString *error) {
        
    }];
}

-(void)setKeyWorlds:(NSString *)keyWorlds{
    _keyWorlds = keyWorlds;
    [self getMessgeWithPage:keyWorlds andWithPage:1];
}

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [Tools returnWithString:@"看官,您搜索的资源不存在,请\n重新尝试"];
}




@end
