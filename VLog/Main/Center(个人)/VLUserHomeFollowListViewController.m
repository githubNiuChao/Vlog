//
//  VLUserHomeFollowListViewController.m
//  VLog
//
//  Created by szy on 2020/11/2.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLUserHomeFollowListViewController.h"
#import "VLUserHomeFansTableViewCell.h"


@interface VLUserHomeFollowListViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation VLUserHomeFollowListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    self.dataArray = [[NSArray alloc] init];
    
}

- (void)loadMore:(BOOL)isMore{
    VLUserHomeFollowListRequest *request = [[VLUserHomeFollowListRequest alloc] init];
    
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
        VLUserHomeFansListResponse *model = [VLUserHomeFansListResponse yy_modelWithJSON:baseResponse.data];
        weakself.dataArray = model.list;
        [weakself endHeaderFooterRefreshing];
        [weakself.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
    }];

}

- (void)initSubView{
    [self setLeftBarButton:@"niv_back_dark"];
    [self setNavigationBarTitle:@"我的关注"];
    [self setBackgroundColor:kWhiteColor];
    [self.tableView registerClass:[VLUserHomeFansTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VLUserHomeFansTableViewCell class])];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLUserHomeFansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VLUserHomeFansTableViewCell class])];
    VLUserHomeFansListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.followModel = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *model = [self.dataArray objectAtIndex:indexPath.row];
}

@end
