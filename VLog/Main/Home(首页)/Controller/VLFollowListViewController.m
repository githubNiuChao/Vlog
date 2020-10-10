//
//  VLFollowListViewController.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLFollowListViewController.h"
#import "VLIndexRequest.h"

@interface VLFollowListViewController ()

@end

@implementation VLFollowListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma mark - Super
- (void)loadMore:(BOOL)isMore{
    
    VLIndexRequest *request =  [[VLIndexRequest alloc]init];
    NSLog(@"%@%@",request.baseUrl,request.requestUrl);
//    [request setArgument:@"asthare" forKey:@"user_name"];
//    [request setArgument:@"123456" forKey:@"password"];
    [request setArgument:@"15" forKey:@"video_id"];
    NCWeakSelf(self);
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [weakself endHeaderFooterRefreshing];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        [weakself endHeaderFooterRefreshing];
    }];
}

#pragma mark - <JXCategoryListContentViewDelegate>
- (UIView *)listView {
    return self.view;
}


@end
