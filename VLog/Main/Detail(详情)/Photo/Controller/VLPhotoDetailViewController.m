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

#import "VLPhotoDetailRequest.h"
#import "VLPhotoDetailManager.h"
#import "VLDetailResponse.h"
#import "VLUserInfoModel.h"
#import "VLIndexResponse.h"
#import "VLCommentTextView.h"


static CGFloat kBottomViewHeight     = 50;
static NSString * const kVLDetailCommentCell     = @"VLVLDetailCommentCell";

@interface VLPhotoDetailViewController ()<NCHBaseModelManagerDelegate,VLDetailCommentCellDelegate,VLPhotoDetailHeadViewDelegate,VLPhotoDetailBottomViewDelegate>

kProNSString(awemeId);
KProAssignType(NSInteger,pageIndex);
KProAssignType(NSInteger,pageSize);
KProStrongType(VLPhotoDetailHeadView,detailHeadView);
KProStrongType(VLPhotoDetailBottomView,bottomView);

KProStrongType(VLPhotoDetailManager, manager)
KProStrongType(VLDetailResponse, dataModel)
KProStrongType(VLVideoInfoModel, videoIndfoModel)
KProStrongType(VLUserInfoModel, currentUserInfoModel)
KProStrongType(VLCommentTextView, textView)

//navsubView
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, strong) UIButton *shareButton;

//准备回复的Model
KProStrongType(VLDetailCommentModel, currentCommentModel)

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
    self.manager = [[VLPhotoDetailManager alloc] init];
    self.manager.delegagte = self;
}

- (void)initSubView{
    [self setNavigationsSubViews];
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
    self.currentUserInfoModel = self.manager.dataModel.user_info;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.currentUserInfoModel.headimg] placeholderImage:[UIImage jk_imageWithColor:kOrangeColor]];
    self.namelabel.text = self.currentUserInfoModel.nickname;
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

#pragma mark - VLDetailCommentCellDelegate
//回复评论
- (void)detailCommentCellModel:(VLDetailCommentModel *)cellModel replyCommentWith:(VLDetailCommentModel *)subCellModel atIndexPath:(NSIndexPath *)indexPath{
    [self.textView showWtihTitle:subCellModel.nickname];
}

- (void)reloadCellHeightForModel:(VLDetailCommentModel *)model atIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}






-(VLPhotoDetailHeadView *)detailHeadView{
    if (!_detailHeadView) {
        _detailHeadView = [[VLPhotoDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.jk_width, 1000) imageArray:self.videoIndfoModel.video_path];
        _detailHeadView.delegate = self;
        [_detailHeadView setInfo:self.dataModel];
    }
    return _detailHeadView;
}

#pragma mark - VLPhotoDetailHeadViewDelegate

- (void)detailHeadView:(VLPhotoDetailHeadView *)detailHeadView didClickTagForViewModel:(VLDetail_TagListResponse *)tagListModel{
    
    
    
}

- (VLPhotoDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[VLPhotoDetailBottomView alloc] initWithFrame:CGRectMake(0, self.view.jk_height- kBottomViewHeight-kSafeHeightBottom, self.view.jk_width, kBottomViewHeight+kSafeHeightBottom) infoModel:self.dataModel];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

#pragma mark - VLPhotoDetailBottomViewDelegate
- (void)photoDetailBottomViewShowComment:(VLPhotoDetailBottomView *)bottomView{
    [self.textView showWtihTitle:@""];
}

- (void)setNavigationsSubViews{
    
    //    [self addNavigationItemWithTitles:(NSArray *) isLeft:(BOOL) target:(id) action:(SEL) tags:(NSArray *)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"niv_back_dark"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    leftButton.tintColor = kBlackColor;
    self.headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    kViewRadius(_headImage, 15);
//    self.headImage.image = [UIImage jk_imageWithColor:kOrangeColor];
//    self.headImage.alignmentRectInsetsOverride = UIEdgeInsetsMake(0, 10, 0, -(10));
//      self.headImage.translatesAutoresizingMaskIntoConstraints = NO;
//      [self.headImage.widthAnchor constraintEqualToConstant:30].active = YES;
//      [self.headImage.heightAnchor constraintEqualToConstant:30].active = YES;
    

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = 10;
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc] initWithCustomView:self.headImage];
    self.namelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
    self.namelabel.font = kFontBSmall;
    self.namelabel.textColor = kBlackColor;
    self.namelabel.text = @"";
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc] initWithCustomView:self.namelabel];
    self.navigationItem.leftBarButtonItems = @[leftButton,item1,item2];
    
    
    _followButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    [_followButton setTitle:@"关注" forState:UIControlStateNormal];
    [_followButton setTitle:@"已关注" forState:UIControlStateSelected];
    _followButton.titleLabel.font = kFontBSmall;
    [_followButton setTitleColor:kCOLOR_THEME forState:UIControlStateNormal];
    [_followButton setTitleColor:kGreyColor forState:UIControlStateSelected];
    kViewBorderRadius(_followButton, 12.5, 1.0, kCOLOR_THEME);
    
    [_followButton addTarget:self action:@selector(followClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item3 = [[UIBarButtonItem alloc] initWithCustomView:_followButton];
    _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30,30)];
    [_shareButton setImageEdgeInsets:UIEdgeInsetsMake(3,0,3,0)];
    _shareButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_shareButton setImage:kNameImage(@"detail_share_icon") forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item4 = [[UIBarButtonItem alloc] initWithCustomView:_shareButton];
    self.navigationItem.rightBarButtonItems = @[item4,item3];
    //    [self addNavigationItemWithImageNames:@[@"",@""] isLeft:NO target:self action:@selector(right.) tags:<#(NSArray *)#>]

}


- (void)followClicked:(UIButton *)button{
    self.followButton.selected = !button.selected;
    if (_followButton.selected) {
        kViewBorderRadius(_followButton, 12.5, 1.0, kGreyColor);
    }else{
        kViewBorderRadius(_followButton, 12.5, 1.0, kCOLOR_THEME);
    }
}

- (void)shareClick:(UIButton *)button{
    
}


@end
