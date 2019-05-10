//
//  SYRankingViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYRankingViewController.h"
#import "SYHotRankTitle.h"
#import "SYHotRankCell.h"
#import "SYhotDayView.h"
#import "FindModel.h"
@interface SYRankingViewController ()
@property(strong,nonatomic)SYHotRankTitle *hotRanktitle;
@property(strong,nonatomic)SYhotDayView *dayView;
@property(assign,nonatomic)NSInteger index;
//定义指针
@property(strong,nonatomic)UIView *sectionFootView;



@end

@implementation SYRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMessage];
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.hotRanktitle];
    self.view.backgroundColor = RGBA(44, 53, 61, 1);
    [self.view addSubview:self.dayView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dayView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.layer.masksToBounds=YES;
    self.tableView.rowHeight=177;
    [self.tableView XJRegisCellWithNibWithName:@"SYHotRankCell"];
    self.tableView.bounces=NO;
    self.index = 0;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    imageView.image = [UIImage imageNamed:@"bg_rankinglist"];
    [imageView sizeToFit];
    imageView.width = SCREEN_WIDTH; 
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = RGBA(44, 53, 61, 0.9);
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, imageView.height);
    [imageView addSubview:view];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
-(SYHotRankTitle *)hotRanktitle{
    if (!_hotRanktitle) {
        _hotRanktitle = [[SYHotRankTitle alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50) andWithArray:@[@"电影",@"电视剧",@"动漫",@"综艺"]];
        __weak typeof(self)weakSelf = self;
        _hotRanktitle.buttonClick = ^(NSString * _Nonnull title, NSInteger index) {
            weakSelf.index = index;
            if ([self.dataSorces count]>index+1) {
                FindModel *model = weakSelf.dataSorces[index];
                if ([ model.data count]>0) {
                    [weakSelf.dayView setHidden:NO];
                    [weakSelf.sectionFootView setHidden:NO];
                }else{
                    [weakSelf.dayView setHidden:YES];
                    [weakSelf.sectionFootView setHidden:YES];
                }
            }
            [weakSelf.tableView reloadData];
        };
    }
    return _hotRanktitle;
}
-(SYHotRankCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYHotRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYHotRankCell"];
    FindModel *model = self.dataSorces[self.index];
    rankModel *rankModel = model.data[indexPath.row];
    [cell setModelWithModel:rankModel andWithIndex:indexPath.row];
    return cell;
}
-(SYhotDayView *)dayView{
    if (!_dayView) {
        _dayView = [[SYhotDayView alloc]initWithFrame:CGRectMake(10, self.hotRanktitle.bottom+10, SCREEN_WIDTH-20, 40)];
        _dayView.backgroundColor = [UIColor whiteColor];
        [_dayView makeYuanWithScle:10 andWithToplef:YES andWithTopRight:YES andWithBootomLeft:NO andWithBootomRight:NO];
        __weak typeof(self)weakSelf = self;
        _dayView.buttonClick = ^(NSString * _Nonnull buttonTitle) {
            [weakSelf getSearchDataWithString:[buttonTitle substringToIndex:buttonTitle.length-1]];
        };
    }
    return _dayView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSString *footString = [[NSString alloc]init];
    UITableViewHeaderFooterView *foot = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footString];
    if (!foot) {
        foot = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:footString];
        
        UIView *whiteView = [[UIView alloc]init];
        whiteView.backgroundColor = [UIColor whiteColor];
        self.sectionFootView = whiteView;
        [foot.contentView addSubview:whiteView];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(foot.contentView);
            make.height.mas_equalTo(@20);
        }];
        whiteView.frame = foot.bounds.size.width<=0?CGRectMake(0, 0, SCREEN_WIDTH-20, 20):foot.contentView.bounds;
        [whiteView makeYuanWithScle:10 andWithToplef:NO andWithTopRight:NO andWithBootomLeft:YES andWithBootomRight:YES];
        
    }
    return foot;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dataSorces count]>0) {
        FindModel *model = self.dataSorces[self.index];
        return [model.data count];
    }else{
        return 0;
    }
}

-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@(self.SYindex) forKey:@"page"];
    [dict setObject:@(30) forKey:@"pageSize"];
    [HttpTool POST:[SY_WatchRank getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dict in [responseObject objectForKey:@"data"]) {
            FindModel *model = [FindModel mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:model];
        }
        [self addData];
        [self.tableView reloadData];
        NSLog(@"%@",responseObject);
    } error:^(NSString *error) {
    }];
}

-(void)addData{
    if ([self.dataSorces count]>0) {
        FindModel *model = self.dataSorces[0];
        if ([model.data count]>0) {
            [self.dayView setHidden:NO];
            [self.sectionFootView setHidden:NO];
        }else{
            [self.dayView setHidden:YES];
            [self.sectionFootView setHidden:YES];
        }
    }else{
        [self.dayView setHidden:YES];
        [self.sectionFootView setHidden:YES];
    }
}

-(void)getSearchDataWithString:(NSString *)string{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    FindModel *model = self.dataSorces[self.index];
    [dict setObject:model.type_id forKey:@"type_id"];
    [dict setObject:string forKey:@"days"];
    [HttpTool POST:[SY_SingRank getWholeUrl] param:dict success:^(id responseObject) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in [responseObject objectForKey:@"data"]) {
            rankModel *model = [rankModel mj_objectWithKeyValues:dict];
            [array addObject:model];
        }
        model.data = array;
        [self.tableView reloadData];
    } error:^(NSString *error) {
        
    }];
    
    
}








@end
