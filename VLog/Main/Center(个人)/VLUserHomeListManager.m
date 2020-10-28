//
//  VLUserHomeListManager.m
//  VLog
//
//  Created by szy on 2020/10/19.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLUserHomeListManager.h"
#import "VLUserHomeRequest.h"

@implementation VLUserHomeListManager

-(instancetype)init{
    self = [super init];
    if (self) {
        _dataArray = @[].mutableCopy;
    }
    return self;
}

#pragma mark ————— 拉取数据 —————
-(void)loadDataWithCatId:(NSInteger)catId{
    VLUserHomeRequest *request =  [[VLUserHomeRequest alloc]init];
      NSLog(@"%@%@",request.baseUrl,request.requestUrl);
    [request setArgument:@(self.page) forKey:@"page[cur_page]"];
//    [request setArgument:@(10) forKey:@"page[page_size]"];
    if (catId!=0) {
        [request setArgument:[NSString stringWithFormat:@"%ld",catId] forKey:@"tab_id"];
    }
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        VLUserHomeResponse *dataModel = [VLUserHomeResponse yy_modelWithJSON:baseResponse.data];
        
        if (weakself.page!=1){
            [weakself.dataArray addObjectsFromArray:dataModel.list];
        }else{
            weakself.dataArray = [dataModel.list mutableCopy];
        }
        if (weakself.delegagte && [self.delegagte respondsToSelector:@selector(requestDataCompleted)]) {
            [weakself.delegagte requestDataCompleted];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        if (weakself.delegagte && [weakself.delegagte respondsToSelector:@selector(requestDataFailedErrorMessage:)]) {
               [weakself.delegagte requestDataFailedErrorMessage:baseResponse.errorMessage];
           }
    }];
}

@end
