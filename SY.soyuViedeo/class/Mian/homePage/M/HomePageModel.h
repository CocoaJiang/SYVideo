//
//  HomePageModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/13.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYad;
@class cover;
@class item;
@class data;
@class recommendModel;


NS_ASSUME_NONNULL_BEGIN

@interface HomePageModel : NSObject
@property(copy,nonatomic)NSArray<recommendModel *> *recommend;//为你推荐 处理好了！
@property(strong,nonatomic)NSMutableArray<data *> *data;//真正的数据。。。。
@property(copy,nonatomic)NSArray<recommendModel *>*slide; //滚动图 //处理好了
@property(copy,nonatomic)NSString *type_id;//模块的ID
@property(copy,nonatomic)NSString *type_name;
@property(copy,nonatomic)NSString *type_search;


//这是最外层最外边的分类、、、好多页面的数据
@end

@interface data: NSObject
@property(strong,nonatomic)SYad *ad; //这是广告
@property(strong,nonatomic)cover *cover; //这是封面模块的推荐
@property(assign,nonatomic)BOOL isHaveCover; //是否有封面图
@property(assign,nonatomic)BOOL isHaveAdd;//是否有广告图，，，
@property(copy,nonatomic)NSString *itemId;
@property(copy,nonatomic)NSString *itemName;
@property(copy,nonatomic)NSString *link;
@property(copy,nonatomic)NSString *link_type;
@property(copy,nonatomic)NSArray<item *>*item_list;//模块内容
@property(copy,nonatomic)NSString *composing; //横排或者竖排 排版1横排2竖排
//缓存item的大小



//这是每页的数据。。每页取得展示 都是用的这里面的东西。。。。

@end


@interface SYad : NSObject
@property(copy,nonatomic)NSString *link;
@property(copy,nonatomic)NSString *link_type;
@property(copy,nonatomic)NSString *pic;
@end


@interface cover : NSObject
@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *link;
@property(copy,nonatomic)NSString *link_type;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *pic;
@property(copy,nonatomic)NSString *sub_name;
@end


@interface item : NSObject
@property(copy,nonatomic)NSString *hot;
@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *link;
@property(copy,nonatomic)NSString *link_type;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *pic;
@property(copy,nonatomic)NSString *serial;
@property(copy,nonatomic)NSString *sub_name;
@property(copy,nonatomic)NSString *vod_total;
@property(copy,nonatomic)NSString *remark;
@property(copy,nonatomic)NSString *douban_score;
@property(copy,nonatomic)NSString *hits;
//关键字
@property(copy,nonatomic)NSString *keyWords;




@end

@interface recommendModel : NSObject
@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *link;
@property(copy,nonatomic)NSString *link_type;  /**/
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *pic;
@property(copy,nonatomic)NSString *sub_name;
/*
 link    string    link不为空时则是直接链接，否则根据id和link_type来跳转
 link_type    number    链接类型（1影视链接2广告直接跳转3模块列表链接）
 */

@end












NS_ASSUME_NONNULL_END
