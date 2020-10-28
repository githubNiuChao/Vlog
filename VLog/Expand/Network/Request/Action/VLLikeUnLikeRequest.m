//
//  VLLikeUnLikeRequest.m
//  VLog
//
//  Created by szy on 2020/10/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLLikeUnLikeRequest.h"

@implementation VLLikeUnLikeRequest

- (instancetype)initWithIsLikeRequest:(BOOL)isLikeRequest
{
    self = [super init];
    if (self) {
        if (isLikeRequest) {
            [self setArgument:@"1" forKey:@"relation_type"];
        }else{
            [self setArgument:@"2" forKey:@"relation_type"];
        }
    }
    return self;
}

- (NSString *)requestUrl{
    if (self.isLike) {
        
    return API_VLOG_LIKE_ACTION;
    }else{
        
    return API_VLOG_UNLIKE_ACTION;
    }
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}


- (void)likeOrCollectRequestWhitID:(NSString *)videoId isLikeCollect:(BOOL)isLikeCollect{
     self.isLike = isLikeCollect;
     [self nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
         [UIWindow showTips:@"操作成功"];
         
         [[NSNotificationCenter defaultCenter] postNotificationName:VLRefreshLikeCollectListNotification object:nil userInfo:nil];
     } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
         [UIWindow showTips:@"操作失败"];
     }];
}



@end
