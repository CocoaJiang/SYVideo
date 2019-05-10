//
//  SY_exchange.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN





@interface SY_changItem : NSObject
@property(copy,nonatomic)NSString * is_exchange;
@property(copy,nonatomic)NSString * id;
@property(copy,nonatomic)NSString * title;
@property(copy,nonatomic)NSString * ico;
@property(copy,nonatomic)NSString * valid_format;
@property(copy,nonatomic)NSString * expiration;
@property(copy,nonatomic)NSString * coin;
@property(assign,nonatomic)NSInteger section;

@end



@interface SY_exchange : NSObject

@property(copy,nonatomic)NSArray <SY_changItem*>* record;

@property(copy,nonatomic)NSArray <SY_changItem*>* list;


/*
data =     {
    record =     (
    ),
    list =     (
                {
 
 
 \     "is_exchange": 0,
 "id": 1,
 "title": "投屏特权",
 "ico": "http://192.168.10.192/upload/exchange/20190401-1/f63a25e7e8364ef61d77ad4be40de1ef.jpg",
 "valid_format": "1个星期",
 "expiration": 4032
 
 
                    id = 1,
                    title = "投屏特权",
                    coin = 100,
                    ico = "http://192.168.10.192/upload/exchange/20190401-1/f63a25e7e8364ef61d77ad4be40de1ef.jpg",
                    valid_format = "1个星期",
                    expiration = "",
                    is_exchange = 1,
                },
                {
                    id = 2,
                    title = "蓝光画质",
                    coin = 100,
                    ico = "http://192.168.10.192/upload/exchange/20190401-1/f63a25e7e8364ef61d77ad4be40de1ef.jpg",
                    valid_format = "1个月",
                    expiration = "",
                    is_exchange = 1,
                },
                {
                    id = 3,
                    title = "每日3次缓存特效",
                    coin = 60,
                    ico = "http://192.168.10.192/upload/exchange/20190401-1/f63a25e7e8364ef61d77ad4be40de1ef.jpg",
                    valid_format = "1个月",
                    expiration = "",
                    is_exchange = 1,
                },
                {
                    id = 4,
                    title = "每日10次缓存特效权",
                    coin = 300,
                    ico = "http://192.168.10.192/upload/exchange/20190401-1/f63a25e7e8364ef61d77ad4be40de1ef.jpg",
                    valid_format = "1个月",
                    expiration = "",
                    is_exchange = 0,
                },
                {
                    id = 5,
                    title = "每日不限缓存特权",
                    coin = 500,
                    ico = "http://192.168.10.192/upload/exchange/20190401-1/f63a25e7e8364ef61d77ad4be40de1ef.jpg",
                    valid_format = "1个月",
                    expiration = "",
                    is_exchange = 0,
                },
                ),
},
 */
@end

NS_ASSUME_NONNULL_END
