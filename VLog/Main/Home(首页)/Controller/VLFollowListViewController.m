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
    
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        
        
    }];
}


#pragma mark - <JXCategoryListContentViewDelegate>
- (UIView *)listView {
    return self.view;
}


@end
