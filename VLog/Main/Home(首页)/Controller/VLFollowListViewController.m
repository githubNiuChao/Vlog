//
//  VLFollowListViewController.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLFollowListViewController.h"
#import "VLFollowListTableViewCell.h"
#import "VLFollowListRequest.h"
#import "VLFollowResponse.h"

static NSString *const kVLFollowListTableViewCell = @"VLFollowListTableViewCell";

@interface VLFollowListViewController ()

KProStrongType(UIView, headerView)
KProNSArrayType(VLFollowListModel, dataArray)
@end

@implementation VLFollowListViewController

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
        weakself.dataArray =dataModel.list;
        weakself.tableView.tableHeaderView = [weakself createHeaderView];
        [weakself.tableView reloadData];
        [weakself endHeaderFooterRefreshing];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        [weakself endHeaderFooterRefreshing];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    self.dataArray = [[NSArray alloc] init];
}

//- (void)loadMore:(BOOL)isMore{
//      VLTopicRequest *request = [[VLTopicRequest alloc] init];
//        [request setArgument:self.parent_id forKey:@"parent_id"];
//        NCWeakSelf(self);
//        [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
//            NSArray *modelArray = [NSArray yy_modelArrayWithClass:[VLIndex_Cat_InfoResponse class] json:baseResponse.data];
//            weakself.dataArray = [modelArray mutableCopy];
//            weakself.tableView.tableHeaderView = [weakself createHeaderView];
//            [weakself.tableView reloadData];
//            [weakself endHeaderFooterRefreshing];
//        } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
//        }];
//}

- (void)initSubView{
    [self setBackgroundColor:[UIColor whiteColor]];
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VLFollowListTableViewCell class] forCellReuseIdentifier:kVLFollowListTableViewCell];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLFollowListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVLFollowListTableViewCell];
    VLFollowListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.indexPathRow  = indexPath.row;
    [cell setDataModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (UIView *)createHeaderView{
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.jk_width, 120)];
    _headerView.backgroundColor = kWhiteColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    label.jk_centerX = _headerView.jk_centerX;
    label.jk_centerY = _headerView.jk_centerY - 10;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"还没有关注的人";
    label.font = kFontBMedium;
    label.textColor = kBlackColor;
    [_headerView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    label1.jk_centerX = _headerView.jk_centerX;
    label1.jk_centerY = _headerView.jk_centerY + 10;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"关注后可以在这里查看对方的最新动态";
    label1.font = kFontBSmall;
    label1.textColor = kGreyColor;
    [_headerView addSubview:label1];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 90,self.view.jk_width, 0.4)];
    view.backgroundColor = kSysGroupBGColor;
    [_headerView addSubview:view];
    
    UILabel *labe2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 150, 20)];
    labe2.textAlignment = NSTextAlignmentLeft;
    labe2.text = @"为您推荐：";
    labe2.font = kFontBMedium;
    labe2.textColor = kBlackColor;
    [_headerView addSubview:labe2];
    
    
    NCWeakSelf(self);
//    [_headerView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
//        if (weakself.delegate &&[weakself.delegate respondsToSelector:@selector(topicListView:didSelectCatid:SelectCatTitle:)]) {
//            [weakself.delegate topicListView:self didSelectCatid:0 SelectCatTitle:@"不选择话题"];
//        }
//    }];
    return _headerView;
}


#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end
