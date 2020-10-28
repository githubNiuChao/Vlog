//
//  VLNestViewController.m
//  VLog
//
//  Created by szy on 2020/9/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLNestViewController.h"
#import "JXCategoryTitleView.h"
#import "VLNestSubjectViewController.h"
#import "VLIndexViewController.h"
#import "VLFollowListViewController.h"

@interface VLNestViewController ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation VLNestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"关注", @"发现", @"同城"];
    
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.defaultSelectedIndex = 1;
    self.myCategoryView.cellSpacing = 30;
    self.myCategoryView.titleColor = [UIColor grayColor];
    self.myCategoryView.titleSelectedColor = [UIColor blackColor];
    self.myCategoryView.titleFont = [UIFont boldSystemFontOfSize:18];
    self.myCategoryView.titleLabelZoomEnabled = YES;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc ]init];
    self.myCategoryView.indicators = @[lineView];
    
    [self.myCategoryView removeFromSuperview];
    self.navigationItem.titleView = self.myCategoryView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.myCategoryView.frame = CGRectMake(0, 0, 250, 30);
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (CGFloat)preferredCategoryViewHeight {
    return 0;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {

    if (index == 0) {
        VLFollowListViewController *vc = [[VLFollowListViewController alloc] init];
        return vc;
    }else if(index == 1) {
        VLNestSubjectViewController *nestVc = [[VLNestSubjectViewController alloc] init];
        return nestVc;
    }else if (index == 2) {
        VLIndexViewController *vc = [[VLIndexViewController alloc] init];
        return vc;
    }
    return [[VLBaseListViewController alloc] init];//空类
}

- (void)listContainerViewDidScroll:(UIScrollView *)scrollView{
    if ([self isKindOfClass:[VLNestViewController class]]) {
        CGFloat index = scrollView.contentOffset.x/scrollView.bounds.size.width;
        CGFloat absIndex = fabs(index - self.currentIndex);
        if (absIndex >= 1) {
            //”快速滑动的时候，只响应最外层VC持有的scrollView“，说实话，完全可以不用处理这种情况。如果你们的产品经理坚持认为这是个问题，就把这块代码加上吧。
            //嵌套使用的时候，最外层的VC持有的scrollView在翻页之后，就断掉一次手势。解决快速滑动的时候，只响应最外层VC持有的scrollView。子VC持有的scrollView却没有响应
            self.listContainerView.scrollView.panGestureRecognizer.enabled = NO;
            self.listContainerView.scrollView.panGestureRecognizer.enabled = YES;
            _currentIndex = floor(index);
        }
    }
}

@end
