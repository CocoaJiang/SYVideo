//
//  urlHeader.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#ifndef urlHeader_h
#define urlHeader_h
//接口文档。。。。。。。。

////本来是AFNETWORKINGD的Ton告知 不想导入文件 提高编译速度设置成静态变量不可能改。。。
static NSString * const KVEYSTRING =                    @"com.alamofire.networking.reachability.change";  //////接受通知的字段。。。
////AFNETWORKING 接受WIFI的字段。
static NSString * const KWIFI =                         @"AFNetworkingReachabilityNotificationStatusItem";
////项目的总地址《内网地址》
#define APPSevers                                       @"http://192.168.10.192:8086/"
////项目的总地址《外网地址》
//#define APPSevers                                       @"http://api.baimaotv.com/api/"
///本地存储地址
#define LocationAddress                                 @"playAbout"
///操作习惯储存地址
#define LocationOperationHabit                          @"OperationHabit"
///直播历史k记录
#define LiveHistory                                     @"user"
//注册用户。。。。。
#define SY_register                                     @"auth/register"
//发送验证码
#define SY_smsCode                                      @"smsCode"
//用户登录
#define SY_login                                        @"auth/login"
//用户信息。。。
#define SY_userInfo                                     @"auth/user"
//修改用户信息
#define SY_edit                                         @"user/edit"
//用户复杂选项设置
#define SY_Set                                          @"user/setting"
//退出登录token
#define SY_LoginOut                                     @"auth/logout"
//获取系统设置
#define SY_system                                       @"system"
//用户可进行的r任务
#define SY_testList                                     @"task/list"
//提交任务
#define SY_award                                        @"task/award"
//首页数据
#define SY_index                                        @"index"
//换一批首页
#define SY_Change                                       @"index/change"
//下拉加载
#define SY_more                                         @"index/more"
//当下模块的全部内容
#define SY_AllData                                      @"index/list"
//搜索模块的一些信息
#define SY_SearchInfo                                   @"search"
//搜索异步关键词
#define SY_SearchKeywords                               @"search/keywords"
//搜索结果列表
#define SY_SearchList                                   @"search/list"
//搜索历史执行清空操作
#define SY_ClearnHistory                                @"search/history"
//影视分类
#define SY_VideoType                                    @"type"
//影视筛选
#define SY_ChoseLoad                                    @"type/load"
//热门专题的内容
#define SY_discovery                                    @"topic"
//Rank观影排行榜
#define SY_WatchRank                                    @"discovery"
//单个分类排行榜
#define SY_SingRank                                     @"discovery/rank"  ///discovery/rank
//专题详情
#define SY_TopICDetail                                  @"topic/detail"
//视频信息
#define SY_PlayInfo                                     @"vod/play"
///用户播放记录
#define SY_PlayHistoryInfo                              @"user/play/record"
///用户播放记录删除
#define SY_eventDeleted                                 @"event/delete"
///收藏记录
#define SY_CollectionList                               @"user/store/record"
///收藏记录加载更多消息
#define SY_CollectionLoad                               @"user/store/load"
///兑换列表
#define SY_ChangeList                                   @"exchange/list"
///兑换
#define SY_exchangeID                                   @"exchange"
///金币明细
#define SY_coin_log                                     @"user/points/log"
///系统消息
#define SY_systemMessage                                @"message/system"
///提交用户反馈
#define SY_UpdataUserReport                             @"message/report"
///我的等级相关信息
#define SY_Level                                        @"level"
///成长记录
#define SY_Leavelog                                     @"level/log"
///用户快速登录
#define SY_loginFast                                    @"auth/fastlogin"
///返回地方电视台分类
#define SY_liveLocal                                    @"live/local"
///获取某个分类下的电视台
#define SY_liveList                                     @"live/list"
///获取播放详情页
#define SY_LivePlayer                                   @"live/play"
///获取某一天的节目清单
#define SY_liveDay                                      @"live/menu"
///收藏或者预定
#define SY_ORder                                        @"live/event"
///收藏电视台
#define SY_CollectChannel                               @"live/event/list"
//选择头像
#define SY_choseHeaderImage                             @"portrait"
///获取直播信息
#define SY_Live                                         @"live"
#pragma mark - 评论相关。。。
#define SY_GotoPJ                                       @"comment/create"
//用户收藏，播放，浏览，点播等
#define SY_event                                        @"event"
///给评论点赞
#define SY_zanContent                                   @"comment/up"
///邀请人总数
#define SY_ORDERNUM                                     @"user/invitenum"
///邀请记录
#define SY_ORDERLIST                                    @"user/invitelog"




#endif /* urlHeader_h */
