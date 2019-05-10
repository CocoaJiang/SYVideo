//
//  SYSetViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYSetViewController.h"
#import "SYSetCell.h"
#import "LoginOutView.h"
#import "SYEditViewController.h"
#import "SYSafeViewController.h"
#import "SYPrivacyController.h"
#import "SYClarityController.h"
#import "addOrCountView.h"//数量编辑器
#import "SYLoginController.h"
#import "PersonHeaderCell.h" ///第一个Cell、。、
#import "SYEditNickName.h"
#import "SYEditSexViewController.h"
#import "SYCashSingleController.h"
#import "SYMessageNotifel.h" ///消息通知
#import "SYWriteViewController.h"///填写邀请码
#import "SYEditHeaderController.h"

@interface SYSetViewController ()
@property(strong,nonatomic)LoginOutView *loginOutView;
@property(strong,nonatomic)NSMutableDictionary *dict;
@property(strong,nonatomic)addOrCountView *addOrcopuntView;
@end
@implementation SYSetViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataSorces addObjectsFromArray:@[@[@"",@"账户安全中心",@"昵称",@"性别"],
                                           @[@"清除缓存",@"自动清理缓存(100M)",@"同时缓存个数",@"允许2G/3G/4G缓存视频"],
                                           @[@"消息通知",/*@"自动跳过片头片尾",*/@"连续播放",@"播放器手势操作",@"版本号V1.0.0"],
                                           @[@"填写好友邀请码"]
                                           ]];
    [self setNAV];
}



-(void)setNAV{
    self.title = @"设置";
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight=50;
    [self.tableView registerNib:[UINib nibWithNibName:@"SYSetCell" bundle:nil] forCellReuseIdentifier:@"SYSetCell"];
    [self.tableView XJRegisCellWithNibWithName:@"PersonHeaderCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    __weak typeof(self)weakSelf = self;
    LoginOutView *loginout = [[LoginOutView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    loginout.backgroundColor = [UIColor groupTableViewBackgroundColor];
    loginout.loginOut = ^{
        [HttpTool POST:[SY_LoginOut getWholeUrl] param:nil success:^(id responseObject) {
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:KUSER_NAME];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:KUSER_CODE];
            [Tools deleteTokenFile];
//            SYLoginController *controller  = [[SYLoginController alloc]init];
//            [weakSelf.navigationController pushViewController:controller animated:YES];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } error:^(NSString *error) {
            
        }];
    };
    
    if ([Tools isNeedLogin]) {
        self.tableView.tableFooterView = [UIView new];
    }else{
        self.tableView.tableFooterView = loginout;
    }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataSorces[section];
    return [array count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSorces count];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view =[[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 15);
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==[self.dataSorces count]-1) {
        return CGFLOAT_MIN;
    }
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SYSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYSetCell"];
    cell.SwitchBlock = ^(NSString * _Nonnull titleString, NSInteger index) {
        [self.dict setObject:[NSString stringWithFormat:@"%ld",(long)index] forKey:titleString];
    };
    SYUSERINFO *setting = [SYUSERINFO info];
    if (indexPath.section==0 && indexPath.row==0) {
        PersonHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonHeaderCell"];
        return cell;
    }else{
        NSArray *array = self.dataSorces[indexPath.section];
        cell.title.text = array[indexPath.row];
        if ([cell.title.text isEqualToString:@"昵称"]) {
            cell.type = CellTypeJiantouAndText;
            cell.text.text = setting.userInfo.user_nick_name;
        }else if ([cell.title.text isEqualToString:@"性别"]){
            cell.type = CellTypeJiantouAndText;
            if ([setting.userInfo.user_sex intValue]==1) {
                cell.text.text = @"男";
            }else if([setting.userInfo.user_sex intValue]==2){
                cell.text.text = @"女";
            }else{
                cell.text.text = @"未填写";
            }
        }else if ([cell.title.text isEqualToString:@"账户安全中心"]){
            cell.type = CellTpyeJiantou;
        }else if ([cell.title.text isEqualToString:@"清除缓存"]){
            cell.type = CellTypeJiantouAndText;
            cell.text.text = @"缓存大小3.22M";
        }else if ([cell.title.text containsString:@"自动清理缓存"]){
            cell.type = CellTypeSwitch;
            cell.SYswitch.on = YES;
        }else if ([cell.title.text isEqualToString:@"同时缓存个数"]){
            cell.type = CellTypeJiantouAndText;
            cell.text.text = [NSString stringWithFormat:@"%@个",setting.userInfo.setting.cacheNum];
        }else if ([cell.title.text isEqualToString:@"允许2G/3G/4G缓存视频"]){
            cell.type = CellTypeSwitch;
            cell.SYswitch.on = [setting.userInfo.setting.wifi boolValue];
        }else if ([cell.title.text isEqualToString:@"消息通知"]){
            cell.type = CellTypeJiantouAndText;
            cell.text.text  =  @"已开启";
        }else if ([cell.title.text isEqualToString:@"自动跳过片头片尾"]){
            cell.type = CellTypeSwitch;
            cell.SYswitch.on = YES;
        }else if ([cell.title.text isEqualToString:@"连续播放"]){
            cell.type = CellTypeSwitch;
            cell.SYswitch.on = [setting.userInfo.setting.continuity boolValue];
        }else if ([cell.title.text isEqualToString:@"播放器手势操作"]){
            cell.type = CellTypeSwitch;
            cell.SYswitch.on = [setting.userInfo.setting.hand boolValue];
        }else if ([cell.title.text isEqualToString:@"填写好友邀请码"]){
            cell.type = CellTypeJiantouAndText;
            cell.text.text = @"未填写";
        }else if ([cell.title.text compare:@"版本号"]){
            cell.type = CellTypeText;
            cell.text.text = @"1.0.0";
        }
        else{
        }
      
        
    }
      return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0 && indexPath.section == 0) {
        [self.navigationController pushViewController:[SYEditHeaderController new] animated:YES];
        return;
    }else{
        NSArray *array = self.dataSorces[indexPath.section];
        NSString *title = array[indexPath.row];
        
        if ([title isEqualToString:@"个人资料"]) {
            [self.navigationController pushViewController:[SYEditViewController new] animated:YES];
            return;
        }else if ([title isEqualToString:@"账户安全中心"]){
            SYSafeViewController *controller = [[SYSafeViewController alloc]init];
            controller.title = title;
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }else if ([title isEqualToString:@"隐私设置"]){
            SYPrivacyController *controller = [[SYPrivacyController alloc]init];
            controller.title=title;
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }else if ([title isEqualToString:@"缓存清晰度"]){
            SYClarityController *controller = [[SYClarityController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }else if ([title isEqualToString:@"昵称"]){
            SYEditNickName *controller = [[SYEditNickName alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }else if ([title isEqualToString:@"性别"]){
            SYEditSexViewController *contoller = [[SYEditSexViewController alloc]init];
            [self.navigationController pushViewController:contoller animated:YES];
            return;
        }else if ([title isEqualToString:@"同时缓存个数"]){
            SYCashSingleController *controller = [[SYCashSingleController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }else if ([title isEqualToString:@"消息通知"]){
            SYMessageNotifel *noti = [[SYMessageNotifel alloc]init];
            [self.navigationController pushViewController:noti animated:YES];
            return;
        }else if ([title isEqualToString:@"填写好友邀请码"]){
            [self.navigationController pushViewController:[SYWriteViewController new] animated:YES];
            return;
        }
    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section==0) {
        return 90;
    }else{
        return 60;
    }
}


-(NSMutableDictionary *)dict{
    if (!_dict) {
        _dict = [[NSMutableDictionary alloc]init];
    }
    return _dict;
}

-(void)change{
    ////当此用户未登录的时候直接过
    if ([Tools isNeedLogin]) {
        return;
    }
    if ([self.dict.allKeys count]>0) {
        SYUSERINFO *setting = [SYUSERINFO info];
        NSMutableDictionary *parma = [[NSMutableDictionary alloc]init];
        if ([self.dict.allKeys containsObject:@"允许2G/3G/4G缓存视频"]) {
            NSString *values = [self.dict objectForKey:@"允许2G/3G/4G缓存视频"];
            [parma setObject:values forKey:@"wifi"];
            setting.userInfo.setting.wifi = values;
        }
        if ([self.dict.allKeys containsObject:@"连续播放"]) {
            NSString *values = [self.dict objectForKey:@"连续播放"];
            [parma setObject:values forKey:@"continuity"];
            setting.userInfo.setting.continuity = values;
        }
        if ([self.dict.allKeys containsObject:@"跳过片头片尾"]) {
            NSString *values = [self.dict objectForKey:@"跳过片头片尾"];
            [parma setObject:values forKey:@"autoPlay"];
            setting.userInfo.setting.autoPlay = values;
        }
        if ([self.dict.allKeys containsObject:@"播放器手势操作"]) {
            NSString *values = [self.dict objectForKey:@"播放器手势操作"];
            [parma setObject:values forKey:@"hand"];
            setting.userInfo.setting.hand = values;
        }
        [HttpTool NOACtionPOST:[SY_Set getWholeUrl] param:parma success:^(id responseObject) {
            
        } error:^(NSString *error) {
            
        }];
    }
}

//iOS页面即将消失
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self change];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
-(addOrCountView *)addOrcopuntView{
    if (!_addOrcopuntView) {
        _addOrcopuntView = [Tools XJ_XibWithName:@"addOrCountView"];
        __weak typeof(self)weakSelf = self;
        _addOrcopuntView.addOrdetion = ^(NSInteger index) {
            [weakSelf.dict setObject:@(index) forKey:@"cacheNum"];
        };
    }
    return _addOrcopuntView;
}






@end
