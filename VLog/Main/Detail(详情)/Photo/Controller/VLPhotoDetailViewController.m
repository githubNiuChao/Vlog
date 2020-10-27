//
//  VLPhotoDetailViewController.m
//  VLog
//
//  Created by szy on 2020/9/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPhotoDetailViewController.h"
#import "VLPhotoDetailHeadView.h"
#import "VLPhotoDetailBottomView.h"

#import "VLDetailCommentCell.h"
#import "VLDetailCommentModel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"

#import "CommentListRequest.h"
#import "NetworkHelper.h"

#import "VLPhotoDetailRequest.h"
#import "VLPhotoDetailManager.h"
#import "VLDetailResponse.h"
#import "VLIndexResponse.h"
#import "VLCommentTextView.h"


static CGFloat kBottomViewHeight     = 50;
static NSString * const kVLDetailCommentCell     = @"VLVLDetailCommentCell";

@interface VLPhotoDetailViewController ()<NCHBaseModelManagerDelegate,VLDetailCommentCellDelegate,VLPhotoDetailBottomViewDelegate>

kProNSString(awemeId);
KProNSMutableArrayType(Comment,data);
KProAssignType(NSInteger,pageIndex);
KProAssignType(NSInteger,pageSize);
KProStrongType(VLPhotoDetailHeadView,detailHeadView);
KProStrongType(VLPhotoDetailBottomView,bottomView);

KProStrongType(VLPhotoDetailManager, manager)
KProStrongType(VLDetailResponse, dataModel)
KProStrongType(VLVideoInfoModel, videoIndfoModel)
KProStrongType(VLCommentTextView, textView)

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
    self.tableView.jk_height = self.view.jk_height-(kBottomViewHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VLDetailCommentCell class] forCellReuseIdentifier:kVLDetailCommentCell];
    
    self.textView = [VLCommentTextView new];
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
    
    [self.view addSubview:self.bottomView];
    [self endHeaderFooterRefreshing];
}

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



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    VLDetailCommentModel *model = [self.commentListData objectAtIndex:indexPath.row];
    [self.textView showWtihTitle:model.nickname];
}

#pragma mark - CellDelegate
- (void)reloadCellHeightForModel:(VLDetailCommentModel *)model atIndexPath:(NSIndexPath *)indexPath {
  [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];    
    
}

- (void)photoDetailBottomViewShowComment:(VLPhotoDetailBottomView *)bottomView{
    [self.textView showWtihTitle:@"说点什么…"];
    
}

-(VLPhotoDetailHeadView *)detailHeadView{
    if (!_detailHeadView) {
        _detailHeadView = [[VLPhotoDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.jk_width, 1000) imageArray:self.videoIndfoModel.video_path];
        [_detailHeadView setInfo:self.dataModel];
    }
    return _detailHeadView;
}

- (VLPhotoDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[VLPhotoDetailBottomView alloc] initWithFrame:CGRectMake(0, self.view.jk_height- kBottomViewHeight-kSafeHeightBottom, self.view.jk_width, kBottomViewHeight+kSafeHeightBottom) infoModel:self.dataModel];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

@end
