//
//  VLFollowListViewController.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLFollowListViewController.h"
#import "VLFollowListRequest.h"
#import "VLFollowResponse.h"

@interface VLFollowListViewController ()

KProNSArray(dataArrray)
@end

@implementation VLFollowListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark - Super
- (void)loadMore:(BOOL)isMore{
    
    VLFollowListRequest *request =  [[VLFollowListRequest alloc]init];
    NSLog(@"%@%@",request.baseUrl,request.requestUrl);
    //    [request setArgument:@"asthare" forKey:@"user_name"];
    //    [request setArgument:@"123456" forKey:@"password"];
    //    [request setArgument:@"15" forKey:@"video_id"];
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {

        VLFollowResponse *dataModel = [VLFollowResponse yy_modelWithJSON:baseResponse.data];
//        weakself._dataArrray =


    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {


    }];
}



#pragma mark - <JXCategoryListContentViewDelegate>
- (UIView *)listView {
    return self.view;
}


@end
