//
//  SYSearchDevicesCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/5.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSearchDevicesCell.h"
#import "UIScrollView+EmptyDataSet.h"
@interface SYSearchDevicesCell()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UIImage *image_show;
///是否失败
@property(assign,nonatomic)BOOL isLoading;


@end





@implementation SYSearchDevicesCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        self.isLoading=YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.isLoading = NO;
            [self.tableView reloadEmptyDataSet];
        });
        
    }
    return self;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.rowHeight = 45;
        [_tableView setHidenLine];
        [_tableView setOthers];
        
    }
    return _tableView;
}
#pragma mark -delegate and  DataSources.. and Empty...
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idString = @"iDstring";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idString];
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.choseCell) {
        self.choseCell(indexPath.row);
    }
}


-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.isLoading) {
        NSMutableArray *images = [[NSMutableArray alloc]init];
        NSArray *array = @[@"a7i",@"a7j",@"a7k",@"a7l",@"a7m",@"a7n",@"a7o",@"a7p",@"a7q",@"a7r",@"a7s",@"a7t",@"a7u",@"a7v",@"a7w",@"a7x",@"a7y",@"a7z"];
        for (NSString *string in array) {
            UIImage *image  = [UIImage imageNamed:string];
            [images addObject:image];
        }
        UIImage *image = [UIImage animatedImageWithImages:images duration:0.3];
        return image;
    }else{
        return [Tools EmptyImage];
    }
}
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.isLoading) return [Tools returnWithString:@"正在搜索中..."];
    return [Tools returnWithString:@"没有找到设备"];
    
}
-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 100;
}
-(void)setArray:(NSMutableArray *)array{
    _array = array;
    [self.tableView reloadData];
}

@end


/*
 
 
 
 
 */
