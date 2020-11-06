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

#import "VLPublishCommentRequest.h"

static CGFloat kBottomViewHeight     = 50;
static NSString * const kVLDetailCommentCell     = @"VLVLDetailCommentCell";

@interface VLPhotoDetailViewController ()<NCHBaseModelManagerDelegate,VLDetailCommentCellDelegate,VLPhotoDetailHeadViewDelegate,VLPhotoDetailBottomViewDelegate,VLCommentTextViewDelegate>

kProNSString(awemeId);
KProAssignType(NSInteger,pageIndex);
KProAssignType(NSInteger,pageSize);
KProStrongType(VLPhotoDetailHeadView,detailHeadView);
KProStrongType(VLPhotoDetailBottomView,bottomView);

KProStrongType(VLPhotoDetailManager, manager)
KProStrongType(VLDetailResponse, dataModel)
KProStrongType(VLVideoInfoModel, videoIndfoModel)
KProStrongType(VLUserInfoModel, videoUserInfoModel)//视频作者
KProStrongType(VLUserInfoModel, loginUserInfoModel)//登陆作者
KProStrongType(VLCommentTextView, textView)

//当前准备回复的评论model
KProStrongType(VLDetailCommentModel, currentCommentModel)
//配置默认的评论模型
KProStrongType(VLDetailCommentModel, defaultCommentModel)

//当前准备回复的评论IndexPath
@property (nonatomic, strong) NSIndexPath *currentCommentIndexPath;

//navsubView
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, strong) UIButton *shareButton;



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

     //配置默认的评论模型
     self.defaultCommentModel =  [[VLDetailCommentModel alloc]init];
     self.defaultCommentModel.parent_id = @"0";
     self.defaultCommentModel.reply_id = @"0";
    
}

- (void)initSubView{
    [self setNavigationsSubViews];
    [self setBackgroundColor:kWhiteColor];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.jk_height = self.view.jk_height-(kBottomViewHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VLDetailCommentCell class] forCellReuseIdentifier:kVLDetailCommentCell];
    
    self.textView = [VLCommentTextView new];
    self.textView.delegate = self;
    
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
    self.videoUserInfoModel = self.manager.dataModel.user_info;
    self.loginUserInfoModel = self.manager.dataModel.current_user;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.videoUserInfoModel.headimg] placeholderImage:[UIImage jk_imageWithColor:kOrangeColor]];
    self.namelabel.text = self.videoUserInfoModel.nickname;
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
    
//    NCWeakSelf(self);
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
    cell.loginUserInfoModel = self.loginUserInfoModel;
    [cell configCellWithModel:model indexPath:indexPath];
    return cell;
}

//回复主评论
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VLDetailCommentModel *model = [self.commentListData objectAtIndex:indexPath.row];

    self.currentCommentIndexPath = indexPath;
    
    self.currentCommentModel = [[VLDetailCommentModel alloc] init];
    self.currentCommentModel.parent_id = model.comment_id;
    self.currentCommentModel.reply_id = @"0";

    [self.textView showWtihTitle:model.nickname];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    VLDetailCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    return cell.testModel.is_author;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            [VLPhotoDetailManager deleteCommentWithCommentModel:[self.commentListData objectAtIndex:indexPath.row]];
            [self.commentListData removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}



#pragma mark - VLDetailCommentCellDelegate
//subCell回复评论
- (void)detailCommentCellModel:(VLDetailCommentModel *)cellModel replyCommentWith:(VLDetailCommentModel *)subCellModel atIndexPath:(NSIndexPath *)indexPath{
    
    self.currentCommentIndexPath = indexPath;
    
    self.currentCommentModel = [[VLDetailCommentModel alloc] init];
    self.currentCommentModel.parent_id = cellModel.comment_id;
    self.currentCommentModel.reply_id = subCellModel.comment_id;
    self.currentCommentModel.reply_user = subCellModel.nickname;
    
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
    self.currentCommentModel = self.defaultCommentModel;
    [self.textView showWtihTitle:@""];
    
    
}

#pragma mark - VLCommentTextViewDelegate - 评论弹窗代理
- (void)onSendText:(NSString *)text{
    
    VLPublishCommentRequest *commentRequest = [[VLPublishCommentRequest alloc] init];
    commentRequest.isAdd = YES;
    [commentRequest setArgument:self.currentCommentModel.parent_id forKey:@"parent_id"];
    [commentRequest setArgument:self.currentCommentModel.reply_id forKey:@"reply_id"];
    [commentRequest setArgument:self.videoIndfoModel.video_id forKey:@"video_id"];
    [commentRequest setArgument:text forKey:@"content"];

    [commentRequest nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
        if (baseResponse.code == 0) {
            [UIWindow showTips:@"评论发表成功"];
            
            [self.bottomView.commentButton setTitle:[request.responseJSONObject objectForKey:@"comment_count"] forState:UIControlStateNormal];
            
            VLDetailCommentModel *model = [VLDetailCommentModel yy_modelWithJSON:[request.responseJSONObject objectForKey:@"comment_info"]];
            model.headimg = self.loginUserInfoModel.headimg;
            model.nickname = self.loginUserInfoModel.nickname;
            if (self.currentCommentModel.reply_user.length) {
                model.reply_user = self.currentCommentModel.reply_user;
            }
            
            if ([self.currentCommentModel.parent_id isEqualToString:@"0"] && [self.currentCommentModel.reply_id isEqualToString:@"0"]) {
                [self.commentListData insertObject:model atIndex:0];
//                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView reloadData];
            }else{
                VLDetailCommentCell *cell = [self.tableView cellForRowAtIndexPath:self.currentCommentIndexPath];
                cell.testModel.shouldUpdateCache = YES;
//                if (kArrayIsEmpty(cell.testModel.children)) {
//                    cell.testModel.children = [[NSMutableArray alloc] init];
//                }
                
                [cell.testModel.children insertObject:model atIndex:0];
                [self reloadCellHeightForModel:cell.testModel atIndexPath:self.currentCommentIndexPath];
            }
        }else{
            [UIWindow showTips:@"评论发表失败"];
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        [UIWindow showTips:@"评论发表失败"];
        
    }];
    
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
