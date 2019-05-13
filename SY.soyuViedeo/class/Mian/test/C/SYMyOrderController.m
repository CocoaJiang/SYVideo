//
//  SYMyOrderController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/30.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYMyOrderController.h"
#import "MyOrderView.h"
#import "SYShareController.h"
#import "SYOrderSectionHeader.h"

@interface SYMyOrderController ()
@property(strong,nonatomic)MyOrderView *orderView;

@end


@implementation SYMyOrderController
-(void)viewDidLoad{
    self.title = @"我的邀请";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView.mj_header = [SYGifHeader headerWithRefreshingBlock:^{
        [self.dataSorces removeAllObjects];
        self.SYindex = 0;
        [self getList];
    }];
    self.tableView.mj_footer = [SYGifFoot footerWithRefreshingBlock:^{
        if (self.isHaveNextPage) {
            self.SYindex++;
            [self getList];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    
    [self getNum];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (UIView *subView in self.tableView.subviews) {
            
            if ([subView isKindOfClass:NSClassFromString(@"DZNEmptyDataSetView")]) {
                
                if ([subView.subviews count]>0) {
                
                    for (UIView *buttonView in subView.subviews[0].subviews) {
                        
                        if ([buttonView isKindOfClass:[UIButton class]]) {
                            
                            UIButton *button = (UIButton *)buttonView;
                            
                            [button setBackgroundColor:KAPPMAINCOLOR];
                            
                            button.height = 40;
                            
                            button.layer.cornerRadius = 20;
                            
                            button.layer.masksToBounds = YES;
                            
                            
                        }
                        
                    }
                    
                }
                
                
            }else{
                
                return ;
            }
            
            
        }
        
        
    });
}
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [Tools returnWithString:@"您暂时还未邀请过其他人"];
}
-(NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"邀请好友" attributes:@{
                                                                                              NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                              NSFontAttributeName:[UIFont systemFontOfSize:16]
                                                                                            }];
    return string;
}
-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    [self.navigationController pushViewController:[SYShareController new] animated:YES];
}

-(MyOrderView *)orderView{
    if (!_orderView) {
        _orderView = [Tools XJ_XibWithName:@"MyOrderView"];
        _orderView.orderButton.clickAction = ^(UIButton *button) {
          [self.navigationController pushViewController:[SYShareController new] animated:YES];
        };
    }
    return _orderView;
}

-(void)addData{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    [view addSubview:self.orderView];
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
    self.tableView.tableHeaderView  = view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *const indstring = @"idString";
    SYOrderSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:indstring];
    if (!header) {
        header = [[SYOrderSectionHeader alloc]initWithReuseIdentifier:indstring];
    }
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSorces count];;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.dataSorces count]>0) return 1;
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const indeerString = @"inderstring";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indeerString];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indeerString];
    }
    cell.textLabel.text = self.dataSorces[indexPath.row][@"nickName"];
    cell.detailTextLabel.text = self.dataSorces[indexPath.row][@"regTime"];
    return cell;
}


-(void)getNum{
    [HttpTool NOACtionPOST:[SY_ORDERNUM getWholeUrl] param:nil success:^(id responseObject) {
        NSString *string = [[responseObject objectForKey:@"data"] objectForKey:@"num"];
        if ([string intValue]>0) {
            self.orderView.number.text = string;
            [self addData];
        }
    } error:^(NSString *error) {
        
    }];
}

-(void)getList{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(self.SYindex) forKey:@"page"];
    [dict setObject:@(40) forKey:@"pageSize"];
    [HttpTool POST:[SY_ORDERLIST getWholeUrl] param:dict success:^(id responseObject) {
        self.isHaveNextPage = [[[responseObject objectForKey:@"data"] objectForKey:@"list"] count]==40?YES:NO;
        self.dataSorces = [[responseObject objectForKey:@"data"] objectForKey:@"list"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } error:^(NSString *error) {
        
    }];
}

@end
