//
//  VLAPIMacros.h
//  VLog
//
//  Created by szy on 2020/9/30.
//  Copyright © 2020 niuchao. All rights reserved.
//

#ifndef VLAPIMacros_h
#define VLAPIMacros_h

//#define YSCAPI(path) [YSCBaseURL stringByAppendingString:path]
//测试
#define API_APP_INDEX  @"/index"

#define API_SITE_LOGIN @"/site/login"

#pragma mark - 首页
//首页-发现
#define API_VLOG_INDEX_FIND @"/user/short-video/index.html?tab_id=3"
//消息
#define API_VLOG_MESSAGE @"/user/short-video/message.html"

#pragma mark - 详情
#define API_VLOG_DETAIL_INFO @"/user/short-video/video-info"


#pragma mark - 个人中心
//作品
#define API_VLOG_HOME_WORKS @"/user/short-video/user.html"
//收藏
#define API_VLOG_HOME_COLLECT @"/user/short-video/user.html?tab_id=2"
//赞过
#define API_VLOG_HOME_LIKE @"/user/short-video/user.html?tab_id=1"

#endif /* VLAPIMacros_h */
