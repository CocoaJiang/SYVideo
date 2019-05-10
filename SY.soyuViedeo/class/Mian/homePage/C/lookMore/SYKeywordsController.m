//
//  SYKeywordsController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/25.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYKeywordsController.h"

@interface SYKeywordsController ()

@end

@implementation SYKeywordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Idstring = @"IDSTAing";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Idstring];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Idstring];
    }
    NSString *orangString = self.keywordsArray[indexPath.row];
    //先找到关键字的位置
    NSRange range = [orangString rangeOfString:self.keyWordString];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:orangString];
    //添加高亮为红色
    [attribute addAttribute:NSForegroundColorAttributeName value:KappBlue range:range];
    cell.textLabel.attributedText = attribute;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.keywordsArray count];
}

-(void)setKeywordsArray:(NSMutableArray *)keywordsArray{
    _keywordsArray = keywordsArray;
    [self.tableView reloadData];
}

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [Tools returnWithString:@"看官,未搜索到相关影片,请\n重新尝试"];
}

//点击模糊搜索进行真正的搜索
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchClick) {
        self.searchClick(self.keywordsArray[indexPath.row]);
    }
    //把字符串扔出去！！！！
    
}

//附加异步关键词页面
-(void)upKeyWordsWithText:(NSString *)text{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:text forKey:@"keyword"];
    [dictionary setObject:@(1) forKey:@"page"];
    [dictionary setObject:@(20) forKey:@"pageSize"];
    [HttpTool POST:[SY_SearchKeywords getWholeUrl] param:dictionary success:^(id responseObject) {
        self.keywordsArray = [[responseObject objectForKey:@"data"] objectForKey:@"list"];
        self.keyWordString =text;
        [self.tableView reloadData];
        NSLog(@"%@",responseObject);
        
    } error:^(NSString *error) {
        
    }];
    
}

@end
