//
//  VLIndexResponse.h
//  VLog
//
//  Created by szy on 2020/10/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHBaseRequestResponse.h"

NS_ASSUME_NONNULL_BEGIN

@class
VLIndex_Cat_InfoResponse,
VLIndex_ListResponse,
VLIndex_PageResponse,
VLIndex_ContextResponse
;
@interface VLIndexResponse : NCHBaseRequestResponse

KProStrongType(VLIndex_Cat_InfoResponse,cat_info)
KProNSArrayType(VLIndex_Cat_InfoResponse,cat_list)
kProNSString(tab_id)
kProNSString(short_video_hot_search)
KProNSArrayType(VLIndex_ListResponse,list)
KProStrongType(VLIndex_PageResponse,page)
KProStrongType(VLIndex_ContextResponse,context)
//KProNSDictionary(context)
@end

//"cat_info":{
//          "cat_id":2,
//          "cat_name":"二级分类",
//          "parent_id":1,
//          "cat_level":2,
//          "is_show":1,
//          "cat_sort":222,
//          "cat_image":null
//      },

//"cat_list":[
//{
//             "cat_id":"3",
//             "cat_name":"游戏",
//             "parent_id":"0",
//             "cat_level":"1",
//             "is_show":"1",
//             "cat_sort":"255",
//             "cat_image":"/backend/1/images/2020/09/28/16012602196993.png",
//             "width":135,
//             "height":135,
//             "children":[
//                 {
//                     "cat_id":"7",
//                     "cat_name":"LOL",
//                     "parent_id":"3",
//                     "cat_level":"2",
//                     "is_show":"1",
//                     "cat_sort":"255",
//                     "cat_image":""
//                 },
//                 {
//                     "cat_id":"8",
//                     "cat_name":"王者荣耀",
//                     "parent_id":"3",
//                     "cat_level":"2",
//                     "is_show":"1",
//                     "cat_sort":"255",
//                     "cat_image":""
//                 },
//                 {
//                     "cat_id":"9",
//                     "cat_name":"消消乐",
//                     "parent_id":"3",
//                     "cat_level":"2",
//                     "is_show":"1",
//                     "cat_sort":"255",
//                     "cat_image":""
//                 }
//             ]
//         },

@interface VLIndex_Cat_InfoResponse : NSObject
KProNSInteger(cat_id)
kProNSString(cat_name)
KProNSInteger(parent_id)
KProNSInteger(cat_level)
KProNSInteger(is_show)
KProNSInteger(cat_sort)
kProNSString(cat_image)
KProNSInteger(width)
KProNSInteger(height)
KProNSArrayType(VLIndex_Cat_InfoResponse,children)
@end

//
//"list":[
//           Object{...},
//           {
//               "video_id":"1",
//               "video_title":"短视频-标题1",
//               "video_desc":"短视频-介绍1",
//               "video_path":[
//                   "http://68test.oss-cn-beijing.aliyuncs.com/images/746/user/611/images/2020/09/24/16009193136055.jpeg"
//               ],
//               "video_img":"http://68products.oss-cn-beijing.aliyuncs.com/taobao-yun-images/522585897277/TB1Vo0sNXXXXXaDapXXXXXXXXXX_!!0-item_pic.jpg",
//               "video_type":"0",
//               "user_id":"1",
//               "cat_id1":"1",
//               "cat_id2":"2",
//               "publish_time":"1596698791",
//               "publish_address":"河北秦皇岛",
//               "publish_lng":"",
//               "publish_lat":"",
//               "province":null,
//               "city":null,
//               "city_code":null,
//               "is_recommend":"0",
//               "audit_status":"1",
//               "audit_text":"滚滚滚滚滚",
//               "clicks":"7",
//               "video_sort":"1",
//               "user_name":null,
//               "nickname":null,
//               "headimg":null,
//               "like_count":"1",
//               "is_like":true
//           }
//       ]

typedef enum : NSUInteger {
    VLIndex_ListResponseTypeImage = 0,
    VLIndex_ListResponseTypeVidel = 1
} VLIndex_ListResponseType;

@interface VLIndex_ListResponse : NSObject
kProNSString(video_id)
kProNSString(video_title)
kProNSString(video_desc)
KProNSArray(video_path)
kProNSString(video_img)
kProNSString(video_type)
kProNSString(user_id)
kProNSString(cat_id1)
kProNSString(cat_id2)
kProNSString(publish_time)
kProNSString(publish_address)
kProNSString(publish_lng)
kProNSString(publish_lat)
kProNSString(province)
kProNSString(city)
kProNSString(city_code)
kProNSString(is_recommend)
kProNSString(audit_status)
kProNSString(audit_text)
kProNSString(clicks)
kProNSString(video_sort)
kProNSString(user_name)
kProNSString(nickname)
kProNSString(headimg)
kProNSString(like_count)
KProBool(is_like)
KProNSInteger(width)
KProNSInteger(height)
KProAssignType(NSInteger,imageCacheHeight)
KProAssignType(NSInteger,hobbysCacheHeight)
KProAssignType(VLIndex_ListResponseType,videoType)
@end

//"page":{
//           "page_key":"page",
//           "page_id":"pagination",
//           "default_page_size":10,
//           "count_disabled":false,
//           "cur_page":1,
//           "page_size":10,
//           "page_size_list":[
//               10,
//               50,
//               500
//           ],
//           "record_count":2,
//           "page_count":1,
//           "offset":0,
//           "url":null,
//           "sql":null
//       },
@interface VLIndex_PageResponse : NSObject
kProNSString(page_key)
kProNSString(page_id)
KProNSInteger(default_page_size)
KProBool(count_disabled)
KProNSInteger(cur_page)
KProNSInteger(page_size)
KProNSArray(page_size_list)
KProNSInteger(record_count)
KProNSInteger(page_count)
KProNSInteger(offset)
kProNSString(url)
kProNSString(sql)
@end

//"context":{
//          "current_time":1602484668,
//          "user_info":Object{...},
//          "config":Object{...},
//          "cart":Object{...},
//          "szy_version":"default"
//      }

//#pragma mark - Context

@class
VLIndex_Context_UserInfoResponse,
VLIndex_Context_ConfigResponse;
@interface VLIndex_ContextResponse : NSObject

KProNSInteger(current_time)
KProStrongType(VLIndex_Context_UserInfoResponse,user_info)
KProStrongType(VLIndex_Context_ConfigResponse,config)
KProNSDictionary(cart)
kProNSString(szy_version)
@end
//"context":{
//    "current_time":1602484668,
//    "user_info":{
//        "user_id":611,
//        "user_name":"asthare",
//        "nickname":"龙龙",
//        "headimg":"/user/3255/headimg/15887709131361.png",
//        "email":null,
//        "email_validated":0,
//        "mobile":"18701665311",
//        "mobile_validated":1,
//        "is_seller":0,
//        "shop_id":0,
//        "last_time":1602484371,
//        "last_ip":"192.168.1.97",
//        "last_region_code":null,
//        "user_rank":{
//            "min_points":700,
//            "max_points":9999,
//            "is_special":0,
//            "type":0,
//            "rank_id":3,
//            "rank_name":"银牌会员",
//            "rank_img":"http://68dsw.oss-cn-beijing.aliyuncs.com/demo/user/rank/2017/08/25/15036257724227.jpg"
//        }
//    }
@class VLIndex_Context_UserInfo_UserRankResponse;
@interface VLIndex_Context_UserInfoResponse : NSObject
KProNSInteger(user_id)
kProNSString(user_name)
kProNSString(nickname)
kProNSString(headimg)
kProNSString(email)
KProNSInteger(email_validated)
kProNSString(mobile)
KProNSInteger(mobile_validated)
KProNSInteger(is_seller)
KProNSInteger(shop_id)
KProNSInteger(last_time)
kProNSString(last_ip)
kProNSString(last_region_code)
KProStrongType(VLIndex_Context_UserInfo_UserRankResponse, user_rank)

@end

@interface VLIndex_Context_UserInfo_UserRankResponse : NSObject
KProNSInteger(min_points)
KProNSInteger(max_points)
KProNSInteger(is_special)
KProNSInteger(type)
KProNSInteger(rank_id)
kProNSString(rank_name)
kProNSString(rank_img)
@end
//
//"config":{
//     "mall_logo":"/system/config/mall/mall_logo_0.png",
//     "site_name":"云商城测试站",
//     "user_center_logo":"/system/config/mall/user_center_logo_0.jpg",
//     "mall_region_code":"13,03,02",
//     "mall_region_name":{
//         "13":"河北省",
//         "13,03":"秦皇岛市",
//         "13,03,02":"海港区"
//     },
//     "mall_address":"河北商之翼互联网科技有限公司",
//     "site_icp":"冀ICP备07501206号-25",
//     "site_copyright":"河北省秦皇岛市海港区河北省秦皇岛市海港区河北省秦皇岛市海港区河北省秦皇岛市海港区河北省秦皇岛市海港区河北省秦皇岛市海港区河北省秦皇岛市海港区河北省秦皇岛市海港区",
//     "site_powered_by":"",
//     "mall_phone":"400-078-5268",
//     "mall_email":"szy@68ecshop.com",
//     "mall_wx_qrcode":"/system/config/mall/mall_wx_qrcode_0.jpg",
//     "mall_qq":"1109488871",
//     "mall_wangwang":"ceshi",
//     "default_user_portrait":"/system/config/default_image/default_user_portrait_0.png",
//     "favicon":"http://68test.oss-cn-beijing.aliyuncs.com/images/746/system/config/website/favicon_0.png",
//     "aliim_enable":"1",
//     "evaluate_show":"1",
//     "is_webp":"1",
//     "aliim_appkey":"23488235",
//     "aliim_secret_key":"b88d4dd831e463d7ec451d7c171a323e",
//     "aliim_main_customer":"xn8801160116",
//     "aliim_customer_logo":"/system/config/aliim/aliim_customer_logo_0.jpg",
//     "aliim_welcome_words":"",
//     "aliim_uid":"d41d8cd98f00b204e9800998ecf8427e",
//     "aliim_pwd":"d41d8cd98f00b204e9800998ecf8427e"
// },

@interface VLIndex_Context_ConfigResponse : NSObject
kProNSString(mall_logo)
kProNSString(site_name)
kProNSString(user_center_logo)
kProNSString(mall_region_code)
KProNSDictionary(mall_region_name)
kProNSString(mall_address)
kProNSString(site_icp)
kProNSString(site_copyright)
kProNSString(site_powered_by)
kProNSString(mall_phone)
kProNSString(mall_email)
kProNSString(mall_wx_qrcode)
kProNSString(mall_qq)
kProNSString(mall_wangwang)
kProNSString(default_user_portrait)
kProNSString(favicon)
kProNSString(aliim_enable)
kProNSString(evaluate_show)
kProNSString(is_webp)
kProNSString(aliim_appkey)
kProNSString(aliim_secret_key)
kProNSString(aliim_main_customer)
kProNSString(aliim_customer_logo)
kProNSString(aliim_welcome_words)
kProNSString(aliim_uid)
kProNSString(aliim_pwd)

@end

NS_ASSUME_NONNULL_END
