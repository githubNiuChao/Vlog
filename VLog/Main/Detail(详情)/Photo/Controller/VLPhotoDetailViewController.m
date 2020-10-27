//
//  VLPhotoDetailViewController.m
//  VLog
//
//  Created by szy on 2020/9/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPhotoDetailViewController.h"
#import "VLPhotoDetailHeadView.h"

#import "VLDetailCommentCell.h"
#import "VLDetailCommentModel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"

#import "CommentListRequest.h"
#import "NetworkHelper.h"

#import "VLPhotoDetailRequest.h"
#import "VLPhotoDetailManager.h"
#import "VLDetailResponse.h"
#import "VLIndexResponse.h"

NSString * const kVLDetailCommentCell     = @"VLVLDetailCommentCell";

@interface VLPhotoDetailViewController ()<NCHBaseModelManagerDelegate,VLDetailCommentCellDelegate>

kProNSString(awemeId);
KProNSMutableArrayType(Comment,data);
KProAssignType(NSInteger,pageIndex);
KProAssignType(NSInteger,pageSize);
KProStrongType(VLPhotoDetailHeadView,detailHeadView);

KProStrongType(VLPhotoDetailManager, manager)
KProStrongType(VLDetailResponse, dataModel)
KProStrongType(VLVideoInfoModel, videoIndfoModel)

@property (nonatomic, strong) NSMutableArray<VLDetailCommentModel*> *commentListData;

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
    [self setLeftBarButton:@"niv_back_dark"];
    [self setBackgroundColor:kWhiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VLDetailCommentCell class] forCellReuseIdentifier:kVLDetailCommentCell];
}

#pragma mark - Super
-(void)loadMore:(BOOL)isMore{
    _pageIndex = isMore? _pageIndex+=1:0;
    if (isMore) {
        [self endHeaderFooterRefreshing];
    }else{
        [self.manager loadDataWithVideoId:self.video_id];
    }
}

#pragma mark -

- (void)requestDataCompleted{
    self.dataModel = self.manager.dataModel;
    self.commentListData = [self.dataModel.comment_list mutableCopy];
    self.videoIndfoModel = self.manager.dataModel.video_info;
    self.tableView.tableHeaderView = self.detailHeadView;
    [self.tableView reloadData];
    [self endHeaderFooterRefreshing];
}

//- (void)loadData:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
//    __weak __typeof(self) wself = self;
//    CommentListRequest *request = [CommentListRequest new];
//    request.page = pageIndex;
//    request.size = pageSize;
//    request.aweme_id = _awemeId;
//    [NetworkHelper getWithUrlPath:FindComentByPagePath request:request success:^(id data) {
//        CommentListResponse *response = [[CommentListResponse alloc] initWithDictionary:data error:nil];
//        NSArray<Comment *> *array = response.data;
//        wself.pageIndex++;
//
//        [UIView setAnimationsEnabled:NO];
//        [wself.tableView beginUpdates];
//        [wself.data addObjectsFromArray:array];
//        NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
//        for(NSInteger row = wself.data.count - array.count; row<wself.data.count; row++) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
//            [indexPaths addObject:indexPath];
//        }
//        [wself.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
//        [wself.tableView endUpdates];
//        [UIView setAnimationsEnabled:YES];
//
//        [wself endHeaderFooterRefreshing];
//        if(!response.has_more) {
////            [wself.loadMore loadingAll];
//        }
////        wself.label.text = [NSString stringWithFormat:@"%ld条评论",(long)response.total_count];
//    } failure:^(NSError *error) {
////        [wself.loadMore loadingFailed];
//    }];
//}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentListData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLDetailCommentModel *model = [self.commentListData objectAtIndex:indexPath.row];
    
    CGFloat h = [VLDetailCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
      VLDetailCommentCell *cell = (VLDetailCommentCell *)sourceCell;
      [cell configCellWithModel:model indexPath:indexPath];
    } cache:^NSDictionary *{
      NSDictionary *cache = @{kHYBCacheUniqueKey : model.comment_id,
               kHYBCacheStateKey  : @"",
               kHYBRecalculateForStateKey : @(model.shouldUpdateCache)};
      model.shouldUpdateCache = NO;
      return cache;
    }];

    return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kVLDetailCommentCell];
    cell.delegate = self;


    VLDetailCommentModel *model = [self.commentListData objectAtIndex:indexPath.row];
    [cell configCellWithModel:model indexPath:indexPath];
    return cell;
}


#pragma mark - HYBTestCellDelegate
- (void)reloadCellHeightForModel:(VLDetailCommentModel *)model atIndexPath:(NSIndexPath *)indexPath {

  [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];    
    
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
        _detailHeadView = [[VLPhotoDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.jk_width, 1000) imageArray:self.videoIndfoModel.video_path];
        [_detailHeadView setInfo:self.dataModel];
    }
    return _detailHeadView;
}

@end
