//
//  VLIndexListManager.m
//  VLog
//
//  Created by szy on 2020/9/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLIndexListManager.h"
#import "VLIndexRequest.h"

@interface VLIndexListManager()
@property (nonatomic,copy) NSArray * imgArray;
@property (nonatomic,copy) NSArray * nickNameArray;
@property (nonatomic,copy) NSArray * hobbysArray;
@property (nonatomic,copy) NSArray * fromArray;
@end

@implementation VLIndexListManager

-(instancetype)init{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark ————— 拉取数据 —————
-(void)loadDataWithCatId:(NSInteger)catId{
    
    VLIndexRequest *request =  [[VLIndexRequest alloc]init];
    request.isFolllow = self.isfollow;
    NSLog(@"%@%@",request.baseUrl,request.requestUrl);
    [request setArgument:@(self.page) forKey:@"page[cur_page]"];
    //    [request setArgument:@(10) forKey:@"page[page_size]"];
    if (catId!=0) {
        [request setArgument:[NSString stringWithFormat:@"%ld",catId] forKey:@"catId"];
    }
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
        VLIndexResponse *dataModel = [VLIndexResponse yy_modelWithJSON:baseResponse.data];
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
