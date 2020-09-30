//
//  VLNestSubjectViewController.m
//  VLog
//
//  Created by szy on 2020/9/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLNestSubjectViewController.h"
#import "JXCategoryTitleView.h"
#import "VLIndexViewController.h"

@interface VLNestSubjectViewController ()

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation VLNestSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myCategoryView.titles = self.titles;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc ]init];
    self.myCategoryView.indicators = @[lineView];
    self.myCategoryView.titleColor = [UIColor grayColor];
    self.myCategoryView.titleSelectedColor = [UIColor redColor];
    self.myCategoryView.titleFont = [UIFont boldSystemFontOfSize:15];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.myCategoryView.backgroundColor = [UIColor whiteColor];
}
- (CGFloat)preferredCategoryViewHeight{
    return 40.0;
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //作为嵌套的子容器，不需要处理侧滑手势处理。示例demo因为是继承，所以直接覆盖掉该代理方法，达到父类不调用下面一行处理侧滑手势的代码。
//    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    VLIndexViewController * indexViewController = [[VLIndexViewController alloc] init];
    return indexViewController;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

@end
