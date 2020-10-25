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
//首页-关注
#define API_VLOG_INDEX_FOLLOW @"/user/short-video/index.html?tab_id=4"
//关注推荐
#define API_VLOG_INDEX_FOLLOW_RECOMMEND @"/user/short-video/recommend-list"

#pragma mark - 消息
//消息首页
#define API_VLOG_MESSAGE @"/user/short-video/message.html"
//收到的喜欢列表
#define API_VLOG_MESSAGE_LIKE_LIST @"/user/short-video/new-like.html"
//收到的关注列表
#define API_VLOG_MESSAGE_FANS_LIST @"/user/short-video/new-fans.html"
//收到的评论列表
#define API_VLOG_MESSAGE_FANS_ @""


#pragma mark - 详情
#define API_VLOG_DETAIL_INFO @"/user/short-video/video-info"


#pragma mark - 发布
#define API_VLOG_PUBLISH_UPLOAD_IMAGE @"/site/upload-image"//上传图片
#define API_VLOG_PUBLISH_UPLOAD_VIDEO @"/site/upload-video"//上传视频


//发布
#define API_VLOG_PUBLISH_ADD @"/user/short-video/add"
//话题
#define API_VLOG_PUBLISH_TOPIC @"/user/short-video/video-cat"
//品牌
#define API_VLOG_PUBLISH_TAG_BRAND @"/user/short-video/brand-list"
//商品
#define API_VLOG_PUBLISH_TAG_GOODS @"/user/short-video/goods-list"


#pragma mark - 个人中心
//作品
#define API_VLOG_HOME_WORKS @"/user/short-video/user.html"
//收藏
#define API_VLOG_HOME_COLLECT @"/user/short-video/user.html?tab_id=2"
//赞过
#define API_VLOG_HOME_LIKE @"/user/short-video/user.html?tab_id=1"

//我的关注列表
#define API_VLOG_HOME_FOLLOWER_LIST @"/user/short-video/follower.html"
//我的粉丝列表
#define API_VLOG_HOME_FANS_LIST @"/user/short-video/fans.html"


#pragma  mark - Action
//点赞、收藏
//短视频ID：id
//类型：relation_type 1-点赞 2-收藏
#define API_VLOG_LIKE_ACTION @"/user/short-video/like"

///取消点赞、收藏
//短视频ID：id
//类型：relation_type 1-点赞 2-收藏
#define API_VLOG_UNLIKE_ACTION @"/user/short-video/unlike"

///关注
//被关注者的用户ID：id
#define API_VLOG_FOLLOW_ACTION @"/user/short-video/follow"
///取消关注
//被取消关注者的用户ID：id
#define API_VLOG_UNFOLLOW_ACTION @"/user/short-video/unfollow"


///添加评论
#define API_VLOG_ADDCOMMENT_ACTION @"/user/short-video/add-comment"
///删除评论
//comment_id
#define API_VLOG_DELETECOMMENT_ACTION @"/user/short-video/delete-comment"

///点赞评论
//comment_id
#define API_VLOG_LIKECOMMENT_ACTION @"/user/short-video/like-comment"
///取消点赞评论
//comment_id
#define API_VLOG_UNLIKECOMMENT_ACTION @"/user/short-video/unlike-comment"


#endif /* VLAPIMacros_h */
