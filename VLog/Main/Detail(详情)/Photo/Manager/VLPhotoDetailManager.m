//
//  VLPhotoDetailManager.m
//  VLog
//
//  Created by szy on 2020/10/14.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPhotoDetailManager.h"
#import "VLPhotoDetailRequest.h"
#import "VLPublishCommentRequest.h"
#import "VLDetailResponse.h"
#import "VLLikeCommentRequest.h"

@implementation VLPhotoDetailManager

-(void)loadDataWithVideoId:(NSString *)videoid{
    
    VLPhotoDetailRequest *request =  [[VLPhotoDetailRequest alloc]init];
    [request setArgument:videoid forKey:@"video_id"];
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        VLDetailResponse *dataModel = [VLDetailResponse yy_modelWithJSON:baseResponse.data];
        NSMutableArray *muArray = [[NSMutableArray alloc] init];
        [dataModel.tag_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[VLDetail_TagListResponse class] json:obj];
            if (!kArrayIsEmpty(modelArray)) {
                [muArray addObject:modelArray];
            }
        }];
        dataModel.tag_list = muArray;
        weakself.dataModel = dataModel;
        
        if (weakself.delegagte && [weakself.delegagte respondsToSelector:@selector(requestDataCompleted)]) {
            [weakself.delegagte requestDataCompleted];
        };
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {

        if (weakself.delegagte && [weakself.delegagte respondsToSelector:@selector(requestDataFailedErrorMessage:)]) {
            [weakself.delegagte requestDataFailedErrorMessage:baseResponse.errorMessage];
        }
    }];
}


+ (void)deleteCommentWithCommentModel:(VLDetailCommentModel *)commentModel{
    
    VLPublishCommentRequest *commentRequest = [[VLPublishCommentRequest alloc] init];
    commentRequest.isAdd = NO;
    [commentRequest setArgument:commentModel.comment_id forKey:@"comment_id"];
    [commentRequest nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
       
        if (baseResponse.code == 0) {
            [UIWindow showTips:@"删除成功"];
        }else{
            [UIWindow showTips:baseResponse.message];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        [UIWindow showTips:@"删除失败 检查网络"];
    }];
    
}

+ (void)likeCommentWithCommentModel:(VLDetailCommentModel *)commentModel isLike:(BOOL)isLike{
    VLLikeCommentRequest *request = [[VLLikeCommentRequest alloc] init];
    request.isLike = isLike;
    [request setArgument:commentModel.comment_id forKey:@"comment_id"];
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        if (baseResponse.code == 0) {
            NSString *string = isLike?@"点赞成功":@"取消点赞成功";
            [UIWindow showTips:string];
        }else{
            NSString *string = isLike?@"点赞失败":@"取消点赞失败";
            [UIWindow showTips:string];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        NSString *string = isLike?@"点赞失败":@"取消点赞失败";
        [UIWindow showTips:string];
    }];

}


@end
