//
//  VLMessageFollowListViewController.m
//  VLog
//
//  Created by szy on 2020/10/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLMessageFollowListViewController.h"
#import "VLMessageLikeTableViewCell.h"

@interface VLMessageFollowListViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation VLMessageFollowListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    self.dataArray = [[NSArray alloc] init];
    
}

- (void)loadMore:(BOOL)isMore{
    VLMessageFansRequest *request = [[VLMessageFansRequest alloc] init];
    
    
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
    [self.tableView registerClass:[VLMessageLikeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VLMessageLikeTableViewCell class])];
}

- (void)setInfoData:(NSArray *)dataArray tagInfo:(NSString *)titleInfo isGoods:(BOOL)isGoods{
    
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
    VLMessageLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VLMessageLikeTableViewCell class])];
    NSObject *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.rightImageView.hidden = YES;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *model = [self.dataArray objectAtIndex:indexPath.row];
}

@end
