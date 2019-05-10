//
//  SYThiredAccount.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYThiredAccount.h"
#import "thiredAccountCell.h"

@interface SYThiredAccount ()

@property(strong,nonatomic)NSMutableArray *imageArray;

@end

@implementation SYThiredAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定第三方账户";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"thiredAccountCell" bundle:nil] forCellReuseIdentifier:@"thiredAccountCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    NSArray *array = @[@"QQ",@"微信",@"微博"];
    [self.dataSorces addObjectsFromArray:array];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    thiredAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thiredAccountCell"];
    cell.title.text =self.dataSorces[indexPath.row];
    [cell.icon setHidden:YES];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    return cell;
}
-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc]init];
        [_imageArray addObjectsFromArray:@[@"QQ (1)",@"微信",@"微博"]];
    }
    return _imageArray;
}


@end
