//
//  SYEditViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYEditViewController.h"
#import "ChoseHeaderCell.h"
#import "SYInPutCell.h"
#import "SYSexChoseCell.h"


@interface SYEditViewController ()

@property(strong,nonatomic)UIImage *image;
@property(strong,nonatomic)UITextField *textField;//指针
@property(strong,nonatomic)NSString *sexString;

@end

@implementation SYEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNAV];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChoseHeaderCell" bundle:nil] forCellReuseIdentifier:@"ChoseHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYInPutCell" bundle:nil] forCellReuseIdentifier:@"SYInPutCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYSexChoseCell" bundle:nil] forCellReuseIdentifier:@"SYSexChoseCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
   
}
-(void)setNAV{
     self.title = @"编辑资料";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem= item;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYUSERINFO *info = [SYUSERINFO info];
    if (indexPath.row==0) {
        ChoseHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChoseHeaderCell"];
        [cell.header XJ_setImageWithURLString:info.userInfo.user_portrait];
        if (self.image) {
            cell.header.image = self.image;
        }
        return cell;
    }else if (indexPath.row==1){
        SYInPutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYInPutCell"];
        self.textField = cell.nicktextField;
        cell.nicktextField.text = info.userInfo.user_nick_name;
        return cell;
    }else if (indexPath.row==2){
        SYSexChoseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYSexChoseCell"];
        if ([info.userInfo.user_sex integerValue]==0) {
        }else if ([info.userInfo.user_sex integerValue]==1){
            cell.boysButton.selected=YES;
        }else{
            cell.girlButton.selected=YES;
        }
        __weak typeof(self)weakSelf = self;
        cell.sexChose = ^(NSString * _Nonnull sex) {
            NSLog(@"%@",sex);
            weakSelf.sexString = sex;
        };
        return cell;
    }
    return nil;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 60;
    }else{
        return 45;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        [Tools moreImagePickerAtController:self image:^(NSArray *images) {
            self.image = images[0];
            [self.tableView reloadData];
        } :1];
        
    }
}

-(void)buttonClick{
    if ([self.textField.text isEmpty]&&[self.sexString isEmpty]) {
        [Tools showErrorWithString:@"请您至少选择一项进行修改"];
        return;
    }
    SYUSERINFO *USER = [SYUSERINFO info];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if (![self.textField.text isEmpty]) {
        [dict setObject:self.textField.text forKey:@"nickName"];
        USER.userInfo.user_nick_name = self.textField.text;
    }
    if (![self.sexString isEmpty]) {
        if ([self.sexString isEqualToString:@"男"]) {
            [dict setObject:@(1) forKey:@"sex"];
            USER.userInfo.user_sex = @"1";
            
        }else{
            [dict setObject:@(2) forKey:@"sex"];
            USER.userInfo.user_sex = @"2";
        }
    }
    
    [HttpTool POST:[SY_edit getWholeUrl] param:dict success:^(id responseObject) {
        [Tools showSuccess:[responseObject objectForKey:@"message"] andWithDoEveryThingWithBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } error:^(NSString *error) {
        
    }];
    
    
    
    
}




@end
