//
//  textModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

@class task_ist;

NS_ASSUME_NONNULL_BEGIN



@interface textModel : NSObject


/*
 signin_num    number    连续签到天数
 user_points    number    当前积分值
 invite_people    number    邀请人数
 task_ist    array    任务列表
 task_list->id    number    任务编号
 task_list->name    string    任务名称
 task_list->points    number    任务积分
 task_list-tips    string    任务信息提示
 task_list->day_times    number    1天奖励次数，0表示总共就能做一次
 task_list->today_times    number    当天完成次数
 */
@property(copy,nonatomic)NSString *invite_people;
@property(copy,nonatomic)NSString *user_points;
@property(copy,nonatomic)NSString *signin_num;
@property(copy,nonatomic)NSArray<task_ist *> *task_ist;
@end

@interface task_ist : NSObject
@property(copy,nonatomic)NSString *day_times;
@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *points;
@property(copy,nonatomic)NSString *tips;
@property(copy,nonatomic)NSString *invite_people;
@property(copy,nonatomic)NSString *today_times;
@property(copy,nonatomic)NSString *ico;


@end


NS_ASSUME_NONNULL_END
