//
//  OCExampleViewController.m
//  JXPagerView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "PagingViewController.h"
#import "JXCategoryView.h"
#import "VLUserHomeRequest.h"
#import "VLUserHomeResponse.h"


@interface PagingViewController () <JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) VLUserHomeResponse *dataModel;

@end

@implementation PagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    //导航栏隐藏的情况，处理扣边返回，下面的代码要加上
//    [self.pagerView.listContainerView.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
//    [self.pagerView.mainTableView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];

    [self initCommon];
    [self initSubView];
    [self loadData];
}

- (void)initCommon{
    self.titles = @[@"笔记", @"收藏", @"赞过"];
}

- (void)initSubView{
    [self userHeaderView];
    [self.view addSubview:self.pagerView];
    /*关联*/
    self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
}

- (VLUserHomeHeaderView *)userHeaderView{
    if (!_userHeaderView) {
        _userHeaderView = [[VLUserHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth, TableHeaderViewHeight)];
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
        //        [request setArgument:@"asthare" forKey:@"user_name"];
        //        [request setArgument:@"123456" forKey:@"password"];
        //        [request setArgument:@"15" forKey:@"video_id"];
//        [request setArgument:@"15" forKey:@"video_id"];
    //        [request setArgument:@"2" forKey:@"cat_id"];
        NCWeakSelf(self);
        [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
            
            self.dataModel = [VLUserHomeResponse yy_modelWithJSON:baseResponse.data];
            
//            VLDetailResponse *dataModel = [VLDetailResponse yy_modelWithJSON:baseResponse.data];
//            NSMutableArray *muArray = [[NSMutableArray alloc] init];
//            [dataModel.tag_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSArray *modelArray = [NSArray yy_modelArrayWithClass:[VLDetail_TagListResponse class] json:obj];
//                [muArray addObject:modelArray];
//            }];
//            dataModel.tag_list = muArray;
//            weakself.dataModel = dataModel;
//
//            if (weakself.delegagte && [weakself.delegagte respondsToSelector:@selector(requestDataCompleted)]) {
//                [weakself.delegagte requestDataCompleted];
//            };
        } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {

//            if (weakself.delegagte && [weakself.delegagte respondsToSelector:@selector(requestDataFailedErrorMessage:)]) {
//                [weakself.delegagte requestDataFailedErrorMessage:baseResponse.errorMessage];
//            }
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

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    VLIndexViewController *list = [[VLIndexViewController alloc]init];
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


