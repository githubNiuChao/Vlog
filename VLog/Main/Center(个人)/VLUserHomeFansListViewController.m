//
//  VLUserHomeFansListViewController.m
//  VLog
//
//  Created by szy on 2020/11/2.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLUserHomeFansListViewController.h"
#import "VLUserHomeFansListRequest.h"
#import "VLUserHomeFansTableViewCell.h"


@interface VLUserHomeFansListViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation VLUserHomeFansListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    self.dataArray = [[NSArray alloc] init];
    
}

- (void)loadMore:(BOOL)isMore{
    VLUserHomeFansListRequest *request = [[VLUserHomeFansListRequest alloc] init];
    
     self.dataArray = @[@"",@"",@"",@""];
       [self endHeaderFooterRefreshing];
       [self.tableView reloadData];
    
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
        VLMessageFansResponse *model = [VLMessageFansResponse yy_modelWithJSON:baseResponse.data];
        
        weakself.dataArray = @[@"",@"",@"",@""];
        [weakself endHeaderFooterRefreshing];
        [weakself.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
    }];

}

- (void)initSubView{
    [self setLeftBarButton:@"niv_back_dark"];
    [self setNavigationBarTitle:@"新增关注"];
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
    NSObject *model = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *model = [self.dataArray objectAtIndex:indexPath.row];
}

@end
