//
//  SYBaseViewController.m
//  S.SouyunVideo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYBaseViewController.h"
@interface SYBaseViewController ()
///网络状态
@property(assign,nonatomic)int status;
@end
@implementation SYBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.SYindex=1;
    self.isHaveNextPage=YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afNetworkStatusChanged:) name:KVEYSTRING object:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KVEYSTRING object:nil];
}
-(NSMutableArray *)dataSorces{
    if (!_dataSorces) {
        _dataSorces = [[NSMutableArray alloc]init];
    }
    return _dataSorces;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight=48;
        [_tableView setHidenLine];
        [_tableView setOthers];
        _tableView.emptyDataSetSource=self;
        _tableView.emptyDataSetDelegate=self;
        _tableView.backgroundColor = [UIColor  whiteColor];
    }
    return _tableView;
}
#pragma mark - collectionViewCell
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled=YES;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.showsHorizontalScrollIndicator=NO;
        _collectionView.emptyDataSetSource=self;
        _collectionView.emptyDataSetDelegate=self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSorces count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
#pragma mark - delegate and dataSorces
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *Idstring =  @"IDString";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Idstring];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Idstring];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSorces count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(void)showAlrertWithTitle:(NSString *)title
            andWithMessage:(NSString *)message
  andWithCancelButtonTitle:(NSString *)Canceltitle
      andWithOKButtonTitle:(NSString *)OKbuttonTitle
            andWithOKBlock:(OKblock)okBlock{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:Canceltitle style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                         }];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:OKbuttonTitle style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action) {
                                                             if (okBlock) {
                                                                 okBlock();
                                                             }
                                                         }];
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)afNetworkStatusChanged:(NSNotification *)noti{
    NSString *status =noti.userInfo[KWIFI];
    self.status = [status intValue];
    [self.collectionView reloadEmptyDataSet];
    [self.tableView reloadEmptyDataSet];
}
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if ((self.status==0 || self.status == -1) && self.status){
       return [UIImage imageNamed:@"error 2"];
    }
    return [Tools EmptyImage];
}
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    if ((self.status==0||self.status==-1) && self.status) return [Tools returnWithString:@"您已断开网络"];
    return [Tools returnWithString:@"暂无数据"];
}
-(NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.status==0 || self.status == -1) return nil;
    return [Tools ReturnWithString:@"请刷新重试" andWithColor:KappBlue andWithFont:13 andWithString:@"" andWithColor:KappBlue andWithFont:13];
}
-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    [self reload];
}
-(void)reload{
    
}




@end
