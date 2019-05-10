//
//  SYBaseViewController.h
//  S.SouyunVideo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"
#import <UINavigationController+TZPopGesture.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OKblock)(void);
@interface SYBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *dataSorces;
@property(strong,nonatomic)UICollectionView *collectionView;
@property(assign,nonatomic)NSInteger SYindex;//当前页数
@property(assign,nonatomic)NSInteger SYall;//总页数
@property(assign,nonatomic)BOOL isHaveNextPage;//分页
-(void)showAlrertWithTitle:(NSString *)title
            andWithMessage:(NSString *)message
  andWithCancelButtonTitle:(NSString *)Canceltitle
      andWithOKButtonTitle:(NSString *)OKbuttonTitle
            andWithOKBlock:(OKblock)okBlock;
-(void)reload;
@end

NS_ASSUME_NONNULL_END
