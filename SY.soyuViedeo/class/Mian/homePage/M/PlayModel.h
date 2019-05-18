//
//  PlayModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/28.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SYad;

@class item;

@class play_record;

NS_ASSUME_NONNULL_BEGIN





//标题和选集
@interface SYSet : NSObject
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *url;
@property(assign,nonatomic)CGFloat width;
//需要设置选中状态！！！
@property(assign,nonatomic)BOOL isSetseleted;
@end

//视频源
@interface urlInfo : NSObject
@property(copy,nonatomic)NSString *icon;
@property(copy,nonatomic)NSString *player;
@property(copy,nonatomic)NSArray <SYSet *> *list;
@property(copy,nonatomic)NSString *player_name;
@property(copy,nonatomic)NSString *from;
@property(assign,nonatomic)BOOL isseleted;
@end


//视频信息
@interface videoInfo : NSObject
@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *like;
@property(copy,nonatomic)NSArray <urlInfo *> *url;
@property(copy,nonatomic)NSString *copyright;
@property(copy,nonatomic)NSString *director;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *douban_score;
@property(copy,nonatomic)NSString *serial;
@property(copy,nonatomic)NSString *from;
@property(copy,nonatomic)NSString *hot;
@property(copy,nonatomic)NSString *comment_num;
@property(copy,nonatomic)NSString *blurb;
@property(copy,nonatomic)NSString *actor;
@property(copy,nonatomic)NSString *type_id;
@property(copy,nonatomic)NSString *hits;
@property(copy,nonatomic)NSString *Class;
@property(copy,nonatomic)NSString *vod_total;
@property(copy,nonatomic)NSString *content;
@property(copy,nonatomic)NSString *pic;
@property(assign,nonatomic)CGFloat contentHeight;
@property(strong,nonatomic)play_record *play_record;
@property(copy,nonatomic)NSString *store;


/*
 play_record =     {
 serlize = 1,
 player = 1,
 play_time = 6,
 },
 */

@end


//评论
@interface  videoPlayercomment: NSObject
@property(copy,nonatomic)NSString *comment_id;
@property(copy,nonatomic)NSString *content;
@property(copy,nonatomic)NSString *user_name;
@property(copy,nonatomic)NSString *user_portrait;
@property(copy,nonatomic)NSString *up;
@property(copy,nonatomic)NSString *time_format;
@property(copy,nonatomic)NSString *comment_reply;
@property(copy,nonatomic)NSString *pic;
@property(assign,nonatomic)CGFloat height;
///是否自己点过赞
@property(assign,nonatomic)BOOL yourSelfIsZan;
@end




//总的数据源！！

@interface PlayModel : NSObject
@property(strong,nonatomic)SYad *ad;
@property(strong,nonatomic)videoInfo *info;
@property(strong,nonatomic)NSMutableArray <videoPlayercomment *>*comment;
@property(copy,nonatomic)NSArray <videoPlayercomment *>*hot_comment;
@property(copy,nonatomic)NSArray<item *>*recommend;
@property(copy,nonatomic)NSString *last_play_time;
@property(copy,nonatomic)NSString *pic;
@end


//播放相关
@interface play_record : NSObject
@property(copy,nonatomic)NSString *serlize; //h集
@property(copy,nonatomic)NSString *player; //播放源
@property(copy,nonatomic)NSString *play_time; //已播放时长
@end




NS_ASSUME_NONNULL_END

/*
{
    code = 0,
    message = "成功",
    data =     {
        ad = "",
        info =     {
            id = 6,
            like = "0",
            copyright = 0,
            director = "查传谊,",
            name = "小女花不弃",
            douban_score = "0.0",
            serial = "41",
            url =     (
                       {
                           icon = "http://192.168.10.192/upload/ad/20190327-1/e216c6ac88a094a273178c17d0330b3b.png",
                           player = "pptv",
                           list =     (
                                       {
                                           title = "第1集",
                                           url = "http://v.pptv.com/show/8oOkI4vxYZ8CgEw.html",
                                       },
                                       {
                                           title = "第2集",
                                           url = "http://v.pptv.com/show/GdibAic2fNPXveXKA.html",
                                       },
                                       {
                                           title = "第3集",
                                           url = "http://v.pptv.com/show/RTtc20OpGVe6OMQ.html",
                                       },
                                       {
                                           title = "第4集",
                                           url = "http://v.pptv.com/show/cwkurRV76ymMCtY.html",
                                       },
                                       {
                                           title = "第5集",
                                           url = "http://v.pptv.com/show/tErraNA2puRHxQk.html",
                                       },
                                       {
                                           title = "第6集",
                                           url = "http://v.pptv.com/show/2qDFQqoQgL4hn2M.html",
                                       },
                                       {
                                           title = "第7集",
                                           url = "http://v.pptv.com/show/IdZ39FzCMnDTUZ0.html",
                                       },
                                       {
                                           title = "第8集",
                                           url = "http://v.pptv.com/show/PsVq6VG3J2XIRoo.html",
                                       },
                                       {
                                           title = "第9集",
                                           url = "http://v.pptv.com/show/HBY3tByC8jCTEd0.html",
                                       },
                                       {
                                           title = "第10集",
                                           url = "http://v.pptv.com/show/WtyBicmbMPHrdW6c.html",
                                       },
                                       {
                                           title = "第11集",
                                           url = "http://v.pptv.com/show/r8Fl4kqwIF7BP8M.html",
                                       },
                                       {
                                           title = "第12集",
                                           url = "http://v.pptv.com/show/ySNDwCiaOicjyfHeE.html",
                                       },
                                       {
                                           title = "第13集",
                                           url = "http://v.pptv.com/show/6wUppg505CKFA88.html",
                                       },
                                       {
                                           title = "第14集",
                                           url = "http://v.pptv.com/show/XZ7AP6cNfbsenGA.html",
                                       },
                                       {
                                           title = "第15集",
                                           url = "http://v.pptv.com/show/co2xLpb8bKoNia1c.html",
                                       },
                                       {
                                           title = "第16集",
                                           url = "http://v.pptv.com/show/846wL5f9basOjFA.html",
                                       },
                                       {
                                           title = "第17集",
                                           url = "http://v.pptv.com/show/ib5a4N58FdbMWlFg.html",
                                       },
                                       {
                                           title = "第18集",
                                           url = "http://v.pptv.com/show/wrXZVr4klNI1sz8.html",
                                       },
                                       {
                                           title = "第19集",
                                           url = "http://v.pptv.com/show/dgElogpw4B6BicwM.html",
                                       },
                                       {
                                           title = "第20集",
                                           url = "http://v.pptv.com/show/gHMTkPhezgxv7fE.html",
                                       },
                                       {
                                           title = "第21集",
                                           url = "http://v.pptv.com/show/jHcXlPxia0hBz8f0.html",
                                       },
                                       {
                                           title = "第22集",
                                           url = "http://v.pptv.com/show/JRA2tR2D8zGUEt4.html",
                                       },
                                       {
                                           title = "第23集",
                                           url = "http://v.pptv.com/show/GSxS0TmfD02wLrI.html",
                                       },
                                       {
                                           title = "第24集",
                                           url = "http://v.pptv.com/show/ibjBX1DyiaElCzMb0.html",
                                       },
                                       {
                                           title = "第25集",
                                           url = "http://v.pptv.com/show/quCHBGzSQoDjYW0.html",
                                       },
                                       {
                                           title = "第26集",
                                           url = "http://v.pptv.com/show/0wAnpAxy4iaCDAc0.html",
                                       },
                                       {
                                           title = "第27集",
                                           url = "http://v.pptv.com/show/zxw7uCCG9jSXFdk.html",
                                       },
                                       {
                                           title = "第28集",
                                           url = "http://v.pptv.com/show/H0blYsowoN5Bv0M.html",
                                       },
                                       {
                                           title = "第29集",
                                           url = "http://v.pptv.com/show/ia9uCAWnPP33gXqI.html",
                                       },
                                       {
                                           title = "第30集",
                                           url = "http://v.pptv.com/show/mc1s61O5KWfKSJQ.html",
                                       },
                                       {
                                           title = "第31集",
                                           url = "http://v.pptv.com/show/pibibODXXbS4nsanY.html",
                                       },
                                       {
                                           title = "第32集",
                                           url = "http://v.pptv.com/show/tK3MS7MZiaccqqDQ.html",
                                       },
                                       {
                                           title = "第33集",
                                           url = "http://v.pptv.com/show/tazLSLAWhsQnpSk.html",
                                       },
                                       {
                                           title = "第34集",
                                           url = "http://v.pptv.com/show/NSFIxyibVBUOmJKg.html",
                                       },
                                       {
                                           title = "第35集",
                                           url = "http://v.pptv.com/show/MCRDwCiaOicjyfHeE.html",
                                       },
                                       {
                                           title = "第36集",
                                           url = "http://v.pptv.com/show/dibeGBW3TQ4HkYm4.html",
                                       },
                                       {
                                           title = "第37集",
                                           url = "http://v.pptv.com/show/ob3cW8Mpmdc6uEQ.html",
                                       },
                                       {
                                           title = "第38集",
                                           url = "http://v.pptv.com/show/kgMppg505CKFA88.html",
                                       },
                                       {
                                           title = "第39集",
                                           url = "http://v.pptv.com/show/eWwMiaicNZyQdq6PQ.html",
                                       },
                                       {
                                           title = "第40集",
                                           url = "http://v.pptv.com/show/hg8tqhJ46CaJB8s.html",
                                       },
                                       {
                                           title = "第41集",
                                           url = "http://v.pptv.com/show/iahtBviaaMicDqdGibc.html",
                                       },
                                       ),
                           player_name = "PPTV",
                           from = "pptv",
                       },
                       ),
            from = "预留字段。应该使用第1个播放源的from值",
            hot = 0,
            comment_num = 0,
            blurb = "大卫五世而乱，得碧罗天宝藏者得天下因为这句预言，可以打开宝藏的花不弃被多方势力觊觎，从小就跟着九叔颠沛流离受尽苦难。后九叔被杀，花不弃遇见了一直爱慕的大侠莲衣客，却没想到莲衣客是七王爷的独子陈煜，七王",
            actor = "林依晨,张彬彬,林柏宏,孙祖君,黄心娣,",
            type_id = 2,
            hits = 782,
            class = "国产",
            vod_total = 0,
            content = "<p>大卫五世而乱，得碧罗天宝藏者得天下因为这句预言，可以打开宝藏的花不弃被多方势力觊觎，从小就跟着九叔颠沛流离受尽苦难。后九叔被杀，花不弃遇见了一直爱慕的大侠莲衣客，却没想到莲衣客是七王爷的独子陈煜，七王爷一心想夺帝位，想把花不弃祭天得到宝藏，因此花不弃和陈煜的感情之路坎坷曲折。花不弃九死一生逃回江南朱府，却发现她早已经和东方炻有了婚约，东方炻的外公也想利用花不弃得到宝藏，可东方炻爱上了花不弃，不想花不弃死，为了证明不拿宝藏也可以得到天下，东方炻起兵造反导致民不聊生。花不弃与陈煜帮助皇帝平定战乱，东方炻为救花不弃被萧九凤误杀，萧九凤被埋碧罗天，从此战争结束，花不弃和陈煜一同游历江湖</p>",
        },
        comment =     (
        ),
        recommend =     (
        ),
        hot_comment =     (
        ),
        last_play_time = 0,
    },
    sign = "F85B1857B890D81BA885B120D8012CBD",
    token = "",
}
    
    */
