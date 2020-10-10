//
//  SmoothViewController.m
//  JXPagerViewExample-OC
//
//  Created by jiaxin on 2019/11/15.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "SmoothViewController.h"
#import "JXPagerView.h"
#import "SmoothListViewController.h"
#import "JXCategoryIndicatorLineView.h"
#import "SmoothListCollectionViewController.h"
#import "SmoothListScrollViewController.h"
#import "SmoothViewDefines.h"

#import "UserInfoHeader.h"

@interface SmoothViewController () <JXPagerSmoothViewDataSource,JXPagerSmoothViewDelegate>
@property (nonatomic, strong) UserInfoHeader                   *userInfoHeader;
@end

@implementation SmoothViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.type = SmoothListType_TableView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    
    self.pager = [[JXPagerSmoothView alloc] initWithDataSource:self];
    self.pager.delegate = self;
    [self.view addSubview:self.pager];

    _categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.titles = @[@"笔记", @"收藏", @"赞过"];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.titleSelectedColor = kCOLOR_THEME;
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = kCOLOR_THEME;
    lineView.indicatorWidth = 30;
    self.categoryView.indicators = @[lineView];

    self.userInfoHeader = [[UserInfoHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.jk_width, 300)];
    
    self.categoryView.contentScrollView = self.pager.listCollectionView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pager.frame = self.view.bounds;
}

#pragma mark - JXPagerSmoothViewDataSource

- (CGFloat)heightForPagerHeaderInPagerView:(JXPagerSmoothView *)pagerView {
    return 300;
}

- (UIView *)viewForPagerHeaderInPagerView:(JXPagerSmoothView *)pagerView {
    return self.userInfoHeader;
}

- (CGFloat)heightForPinHeaderInPagerView:(JXPagerSmoothView *)pagerView {
    return SmoothViewPinCategoryHeight;
}

- (UIView *)viewForPinHeaderInPagerView:(JXPagerSmoothView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerSmoothView *)pagerView {
    return self.categoryView.titles.count;
}

- (id<JXPagerSmoothViewListViewDelegate>)pagerView:(JXPagerSmoothView *)pagerView initListAtIndex:(NSInteger)index {
//    switch (self.type) {
//        case SmoothListType_TableView: {
//            SmoothListViewController *listVC = [[SmoothListViewController alloc] init];
//            listVC.title = self.categoryView.titles[index];
//            return listVC;
//            break;
//        }
//        case SmoothListType_CollectionView: {
            SmoothListCollectionViewController *listVC = [[SmoothListCollectionViewController alloc] init];
            listVC.title = self.categoryView.titles[index];
            return listVC;
//            break;
//        }
//        case SmoothListType_ScrollView: {
//            SmoothListScrollViewController *listVC = [[SmoothListScrollViewController alloc] init];
//            listVC.title = self.categoryView.titles[index];
//            return listVC;
//            break;
//        }
//    }
}
#pragma mark - JXPagerSmoothViewDelegate
- (void)pagerSmoothViewDidScroll:(UIScrollView *)scrollView
{
    [self.userInfoHeader scrollViewDidScroll:scrollView.contentOffset.y];
}


@end
