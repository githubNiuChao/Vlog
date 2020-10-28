//
//  VLUserHomeViewController.m
//  VLog
//
//  Created by szy on 2020/10/19.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLUserHomeViewController.h"
#import "JXCategoryView.h"
#import "JXCategoryTitleView.h"

#import "VLUserHomeHeaderView.h"
#import "VLUserHomeRequest.h"
#import "VLUserHomeResponse.h"
#import "VLUserInfoModel.h"

#import "VLCommentTextView.h"
#import "VLSendCommentTextView.h"

@interface VLUserHomeViewController () <JXCategoryViewDelegate,VLUserHomeHeaderViewDelegate>

@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) VLUserHomeHeaderView *userHeaderView;
@property (nonatomic, strong) VLUserHomeResponse *dataModel;

@property (nonatomic, strong) VLCommentTextView *textView;
//@property (nonatomic, strong) VLSendCommentTextView *textView;

@end

@implementation VLUserHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    //导航栏隐藏的情况，处理扣边返回，下面的代码要加上
//    [self.pagerView.listContainerView.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
//    [self.pagerView.mainTableView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];

    [self initCommon];
    [self initSubView];
    [self loadData];
}

- (void)initCommon{
    self.titles = @[@"笔记", @"赞过", @"收藏"];
}

- (void)setNavigationsSubViews{
    
    UIButton *homeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [homeButton setImageEdgeInsets:UIEdgeInsetsMake(3,0,3,0)];
    homeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [homeButton setImage:kNameImage(@"user_home_icon") forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(homeClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
    
    UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30,30)];
    [moreButton setImageEdgeInsets:UIEdgeInsetsMake(3,0,3,0)];
    moreButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [moreButton setImage:kNameImage(@"user_more_icon") forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
//    self.navigationItem.rightBarButtonItems = @[item4,item3];
    //    [self addNavigationItemWithImageNames:@[@"",@""] isLeft:NO target:self action:@selector(right.) tags:<#(NSArray *)#>]
}

- (void)initSubView{
    [self userHeaderView];
    [self.view addSubview:self.pagerView];
    /*关联*/
    self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    [self setNavigationsSubViews];
    
    self.textView = [VLCommentTextView new];
//    _textView.delegate = self;
}


- (VLUserHomeHeaderView *)userHeaderView{
    if (!_userHeaderView) {
        _userHeaderView = [[VLUserHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth, TableHeaderViewHeight)];
        _userHeaderView.delegate = self;
    }
    return _userHeaderView;
}

-(JXPagerView *)pagerView{
    if (!_pagerView) {
        _pagerView = [[JXPagerView alloc] initWithDelegate:self];
        _pagerView.mainTableView.gestureDelegate = self;
    }
    return _pagerView;
}

- (JXCategoryTitleView *)categoryView{
    
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HeaderInSectionHeight)];
         _categoryView.titles = self.titles;
         _categoryView.backgroundColor = kWhiteColor;
         _categoryView.delegate = self;
         _categoryView.titleSelectedColor = [UIColor blackColor];
         _categoryView.titleColor = [UIColor grayColor];
         _categoryView.titleFont = kFontBBig;
         _categoryView.titleColorGradientEnabled = YES;
         _categoryView.titleLabelZoomEnabled = YES;
         _categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
         
         JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
         lineView.indicatorColor = [UIColor redColor];
         lineView.indicatorWidth = 30;
         _categoryView.indicators = @[lineView];
    }
    return _categoryView;
}

- (void)loadData{
     VLUserHomeRequest *request =  [[VLUserHomeRequest alloc]init];
        NCWeakSelf(self);
        [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
            
            weakself.dataModel = [VLUserHomeResponse yy_modelWithJSON:baseResponse.data];
            weakself.navigationItem.title = weakself.dataModel.user_info.nickname;
            [weakself.userHeaderView setInfoData:weakself.dataModel];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
            
        }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (JXPagerView *)preferredPagingView {
    return [[JXPagerView alloc] initWithDelegate:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.pagerView.frame = self.view.bounds;
}

- (void)onUserActionTap:(NSInteger)tag{
    
    [self.textView showWtihTitle:@"8888"];
}

#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return TableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return HeaderInSectionHeight;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return self.categoryView.titles.count;
}

- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidScroll:(UIScrollView *)scrollView {
    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
}


- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    VLUserHomeListViewController *list = [[VLUserHomeListViewController alloc]init];
    list.catId = index;
    return list;
    
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXPagerMainTableViewGestureDelegate

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end


