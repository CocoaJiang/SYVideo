//
//  SYSafeViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSafeViewController.h"
#import "SYSetCell.h"
#import "SYThiredAccount.h"
#import "SYChangePassWorldController.h"
#import "SYChangePassWorld2Controller.h"


@interface SYSafeViewController ()

@end

@implementation SYSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"绑定手机号",@"更改密码",@"修改手机号"];
    [self.dataSorces addObjectsFromArray:array];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYSetCell" bundle:nil] forCellReuseIdentifier:@"SYSetCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYSetCell"];
    cell.title.text =self.dataSorces[indexPath.row];
    cell.type = CellTpyeJiantou;
    if ([cell.title.text isEqualToString:@"绑定手机号"]) {
        cell.type = CellTypeJiantouAndText;
        cell.text.text = [@"+86  "add:[Tools returnBankCard:USERREAD_object(KUSER_NAME)]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = self.dataSorces[indexPath.row];
    if ([string isEqualToString:@"绑定手机号"]) {
        return;
    //    [self.navigationController pushViewController:[SYThiredAccount new] animated:YES];
    }else if ([string isEqualToString:@"更改密码"]){
        SYChangePassWorldController *controller = [[SYChangePassWorldController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        SYChangePassWorld2Controller *controller = [[SYChangePassWorld2Controller alloc]init];
        controller.type = changPhone;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}



@end
