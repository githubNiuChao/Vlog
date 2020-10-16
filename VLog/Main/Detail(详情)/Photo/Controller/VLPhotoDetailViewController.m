//
//  VLPhotoDetailViewController.m
//  VLog
//
//  Created by szy on 2020/9/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPhotoDetailViewController.h"
#import "VLPhotoDetailHeadView.h"


#import "VLCommentTableViewCell.h"

#import "CommentListRequest.h"
#import "NetworkHelper.h"

#import "VLPhotoDetailRequest.h"
#import "VLPhotoDetailManager.h"
#import "VLDetailResponse.h"
#import "VLIndexResponse.h"

NSString * const kVLCommentTableViewCell     = @"VLCommentTableViewCell";

@interface VLPhotoDetailViewController ()<NCHBaseModelManagerDelegate>

kProNSString(awemeId);
KProNSMutableArrayType(Comment,data);
KProAssignType(NSInteger,pageIndex);
KProAssignType(NSInteger,pageSize);
KProStrongType(VLPhotoDetailHeadView,detailHeadView);

KProStrongType(VLPhotoDetailManager, manager)
KProStrongType(VLDetailResponse, dataModel)
KProStrongType(VLVideoInfoModel, videoIndfoModel)
@end

@implementation VLPhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
    [self initSubView];
}
- (void)initCommon{
    _pageIndex = 0;
    _pageSize = 20;
    _data = [NSMutableArray array];
    self.manager = [[VLPhotoDetailManager alloc] init];
    self.manager.delegagte = self;
}

- (void)initSubView{
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VLCommentTableViewCell class] forCellReuseIdentifier:kVLCommentTableViewCell];
}

#pragma mark - Super
-(void)loadMore:(BOOL)isMore{
    _pageIndex = isMore? _pageIndex+=1:0;
    if (isMore) {
        [self loadData:_pageIndex pageSize:_pageSize];
    }else{
        [self.manager loadDataWithVideoId:self.video_id];
    }
}

#pragma mark -

- (void)requestDataCompleted{
    self.dataModel = self.manager.dataModel;
    self.videoIndfoModel = self.manager.dataModel.video_info;
    self.tableView.tableHeaderView = self.detailHeadView;
    [self endHeaderFooterRefreshing];
}




- (void)loadData:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
    __weak __typeof(self) wself = self;
    CommentListRequest *request = [CommentListRequest new];
    request.page = pageIndex;
    request.size = pageSize;
    request.aweme_id = _awemeId;
    [NetworkHelper getWithUrlPath:FindComentByPagePath request:request success:^(id data) {
        CommentListResponse *response = [[CommentListResponse alloc] initWithDictionary:data error:nil];
        NSArray<Comment *> *array = response.data;
        wself.pageIndex++;
        
        [UIView setAnimationsEnabled:NO];
        [wself.tableView beginUpdates];
        [wself.data addObjectsFromArray:array];
        NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
        for(NSInteger row = wself.data.count - array.count; row<wself.data.count; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [indexPaths addObject:indexPath];
        }
        [wself.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        [wself.tableView endUpdates];
        [UIView setAnimationsEnabled:YES];
        
        [wself endHeaderFooterRefreshing];
        if(!response.has_more) {
//            [wself.loadMore loadingAll];
        }
//        wself.label.text = [NSString stringWithFormat:@"%ld条评论",(long)response.total_count];
    } failure:^(NSError *error) {
//        [wself.loadMore loadingFailed];
    }];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [VLCommentTableViewCell cellHeight:_data[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVLCommentTableViewCell];
    [cell initData:_data[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Comment *comment = _data[indexPath.row];
//    if(!comment.isTemp && [@"visitor" isEqualToString:comment.user_type] && [MD5_UDID isEqualToString:comment.visitor.udid]) {
//        MenuPopView *menu = [[MenuPopView alloc] initWithTitles:@[@"删除"]];
//        __weak __typeof(self) wself = self;
//        menu.onAction = ^(NSInteger index) {
//            [wself deleteComment:comment];
//        };
//        [menu show];
//    }
}

-(VLPhotoDetailHeadView *)detailHeadView{
    if (!_detailHeadView) {
        _detailHeadView = [[VLPhotoDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.jk_width, 900) imageArray:self.videoIndfoModel.video_path];
        [_detailHeadView setInfo:self.dataModel];
    }
    return _detailHeadView;
}

@end
