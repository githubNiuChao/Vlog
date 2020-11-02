//
//  VLFollowUnFollowRequest.m
//  VLog
//
//  Created by szy on 2020/10/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLFollowUnFollowRequest.h"

@implementation VLFollowUnFollowRequest

- (NSString *)requestUrl{
    if (_isFolleow) {
    return API_VLOG_FOLLOW_ACTION;
    }else{
    return API_VLOG_UNFOLLOW_ACTION;
    }
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}


- (void)followRequestWhitID:(NSString *)userId isFollow:(BOOL)isFollow{
     self.isFolleow = isFollow;
     [self nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
         [UIWindow showTips:@"操作成功"];
         
//         [[NSNotificationCenter defaultCenter] postNotificationName:VLRefreshLikeCollectListNotification object:nil userInfo:nil];
     } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
         [UIWindow showTips:@"操作失败"];
     }];
}

@end
