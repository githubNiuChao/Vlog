//
//  VLPublishCommentRequest.m
//  VLog
//
//  Created by szy on 2020/11/4.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPublishCommentRequest.h"

@implementation VLPublishCommentRequest

- (NSString *)requestUrl{
    if (self.isAdd) {
    return API_VLOG_ADDCOMMENT_ACTION;
    }else{
    return API_VLOG_DELETECOMMENT_ACTION;
    }
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (void)likeOrCollectRequestWhitID:(NSString *)videoId isLikeCollect:(BOOL)isLikeCollect{
     
     [self nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
         [UIWindow showTips:@"操作成功"];
         
     } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
         [UIWindow showTips:@"操作失败"];
     }];
}




@end
