//
//  VLPhotoDetailManager.m
//  VLog
//
//  Created by szy on 2020/10/14.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPhotoDetailManager.h"
#import "VLPhotoDetailRequest.h"
#import "VLPhotoDetailResponse.h"

@implementation VLPhotoDetailManager

-(void)loadDataWithVideoId:(NSString *)videoid{
    VLPhotoDetailRequest *request =  [[VLPhotoDetailRequest alloc]init];
    //        [request setArgument:@"asthare" forKey:@"user_name"];
    //        [request setArgument:@"123456" forKey:@"password"];
    //        [request setArgument:@"15" forKey:@"video_id"];
    [request setArgument:@"15" forKey:@"video_id"];
//        [request setArgument:@"2" forKey:@"cat_id"];
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        VLPhotoDetailResponse *dataModel = [VLPhotoDetailResponse yy_modelWithJSON:baseResponse.data];
        NSMutableArray *muArray = [[NSMutableArray alloc] init];
        [dataModel.tag_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[VLDetail_TagListResponse class] json:obj];
            [muArray addObject:modelArray];
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
@end
