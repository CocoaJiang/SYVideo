//
//  SYTopDetailModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/27.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>




@class info;

@class videoDetail;

@class recommendDetail;

@class comment;

@class commentDetail;

NS_ASSUME_NONNULL_BEGIN


//总的数据
@interface SYTopDetailModel : NSObject
@property(strong,nonatomic)comment *comment;
@property(strong,nonatomic)info *info;
@end


//评论
@interface comment : NSObject
@property(copy,nonatomic)NSString *pageSize;
@property(copy,nonatomic)NSString *page;
@property(strong,nonatomic)NSMutableArray <commentDetail *>*list;
@end


//评论详情
@interface commentDetail : NSObject
@property(copy,nonatomic)NSString *user_name;
@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *content;
@property(copy,nonatomic)NSString *portrait;
@property(copy,nonatomic)NSString *time_format;
@property(assign,nonatomic)CGFloat height;
@property(copy,nonatomic)NSString *pic;
///是否自己点过赞
@property(assign,nonatomic)BOOL yourSelfIsZan;


@end


//影视相关
@interface info : NSObject
@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *content;
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *like;
@property(copy,nonatomic)NSArray <videoDetail*>*vedio;
@end


//影视简介
@interface videoDetail : NSObject
@property(copy,nonatomic)NSString *actor;
@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *pic;
@property(copy,nonatomic)NSString *blurb;
@property(copy,nonatomic)NSString *Class;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *director;
@property(copy,nonatomic)NSString *is_store;//是否收藏0未收藏1收藏
@property(copy,nonatomic)NSArray<recommendDetail *>*relate;
@end

//推荐详情
@interface recommendDetail : NSObject
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *id;
@end

















NS_ASSUME_NONNULL_END


/*
{
    comment =     {
        pageSize = "20",
        list =     (
                    {
                        user_name = "骚货",
                        id = 23,
                        content = "2",
                        portrait = "",
                        time_format = "2019-03-11",
                    },
                    ),
        page = 1,
    },
    info =     {
        id = 1,
        title = "下饭神器，超火美食综艺节目，千万不要晚上看哟~",
        content = "<p style="border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; color: rgb(25, 25, 25); font-family: "><span style="border: 0px; margin: 0px; padding: 0px;">摩尔人家庭</span></p><p style="border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; color: rgb(25, 25, 25); font-family: "><span style="border: 0px; margin: 0px; padding: 0px;">伊比利亚半岛曾是古罗马的一部分，因此深受罗马帝国的影响。伊<span style="border: 0px; margin: 0px; padding: 0px;">比利亚半岛濒临地中海和大西洋，有着地中海沿岸国家明显的特点：阳光明媚，气候温暖，非常适合橄榄以及葡萄的种植。所以在古罗马时期，伊比利亚半岛成为古罗马橄榄油和葡萄酒供应地，橄榄的大量种植深刻地影响了西班牙烹饪，使用味道淡雅的橄榄油一直是西班牙烹饪的精髓。</span></span><span style="border: 0px; margin: 0px; padding: 0px;">除此之外，古罗马帝国时期农业发展迅猛使得伊比利亚半岛得以受益，大量灌溉系统的修建以及蔬菜的培育无疑让伊比利亚农业发生了巨大变化。在古罗马时期培育的芦笋、洋蓟、洋葱等食材甚至成为后世西班牙烹饪必不可少的食材。</span></p><p style="border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; color: rgb(25, 25, 25); font-family: "><img src="mac://img.mp.itc.cn/upload/20170729/411a35c528e14828bcebaccdaf42ef05_th.jpg" alt=""/></p><p style="border: 0px; margin-top: 0.63em; margin-bottom: 1.8em; padding: 0px; counter-reset: list-1 0 list-2 0 list-3 0 list-4 0 list-5 0 list-6 0 list-7 0 list-8 0 list-9 0; color: rgb(25, 25, 25); font-family: "><span style="border: 0px; margin: 0px; padding: 0px;">受到伊斯兰文化影响的摩尔人</span></p><p><br/></p>",
        vedio =     (
                     {
                         relate =     (
                                       {
                                           id = 1027,
                                           name = "小阴谋大爱情",
                                       },
                                       {
                                           id = 1028,
                                           name = "相棒剧场版4",
                                       },
                                       ),
                         actor = "王燕华,王晓彤,李晔,洪海天",
                         id = 1029,
                         pic = "http://pic.tudou1238.com/upload/vod/2019-03-22/201903221553237254.png",
                         blurb = "传说神灯主宰着正义与光明为了天下和平，天地女神坚守神灯千年。可是魔界力量危及天下。女神创造了龙娃与凤娃两个神娃，共同保卫天下和平。可是魔石摧毁了神灯能量，女神舍身使神灯重获光芒，保护了天地之脉，从此母",
                         class = "大陆 / 动漫",
                         name = "新东方神娃",
                         director = "殷晓东",
                     },
                     {
                         relate =     (
                         ),
                         actor = "水谷丰,反町隆史,铃木杏树,川原和久",
                         id = 1028,
                         pic = "http://pic.tudou1238.com/upload/vod/2019-03-22/201903221553237206.png",
                         blurb = "七年前，日本驻英领事馆发生了一起致命性的中毒事件，而唯一的幸存者也被国际犯罪组织劫走出于政治原因，日本政府决定将此事隐瞒了下来。 七年后，前国际犯罪情报事务局理事马克·刘来到日本追查犯罪组织头目渡鸦的",
                         class = "日本 / 剧情",
                         name = "相棒剧场版4",
                         director = "桥本一",
                     },
                     ),
        like = 0,
    },
    }

    */
 

