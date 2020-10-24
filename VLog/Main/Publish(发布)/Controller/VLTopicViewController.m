//
//  VLTopicViewController.m
//  VLog
//
//  Created by szy on 2020/10/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLTopicViewController.h"
#import "JXCategoryView.h"
#import "VLTopicListView.h"
#import "VLTopicRequest.h"
#import "VLTopicResponse.h"
#import "VLIndexResponse.h"

static const CGFloat CategoryViewHeight = 45;

@interface VLTopicViewController ()
<UISearchBarDelegate,
JXCategoryListContentViewDelegate,
JXCategoryListContainerViewDelegate,
JXCategoryViewDelegate,
VLTopicListViewDelegate>

KProStrongType(UISearchBar,searchBar)
KProStrongType(JXCategoryTitleView, myCategoryView)
KProStrongType(JXCategoryListContainerView, listContainerView)

KProNSArrayType(VLIndex_Cat_InfoResponse, dataArray);
KProNSMutableArray(tittleArray)
KProNSMutableArray(catIdArray)

@end

@implementation VLTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    self.dataArray = [[NSMutableArray alloc] init];
    self.tittleArray = [[NSMutableArray alloc] init];
    self.catIdArray = [[NSMutableArray alloc] init];
    [self loadData];
}


- (void)initSubView{
    [self setBackgroundColor:kWhiteColor];
    [self setTranslucentCoverWtih:UIBlurEffectStyleLight];
    [self initLeftFullDismissButton:@"niv_back_dark"];
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarH);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).inset(10);
        make.height.equalTo(@(45));
    }];
}

- (void)initCategoryView {
    [self.view addSubview:self.myCategoryView];
    [self.myCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(self.searchBar.mas_bottom);
        make.height.equalTo(@(CategoryViewHeight));
    }];
    [self.view addSubview:self.listContainerView];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.myCategoryView.mas_bottom);
    }];
}
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
        _searchBar.keyboardType = UIKeyboardTypeEmailAddress; // 设置弹出键盘的类型
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.barStyle = UIBarStyleDefault; // 设置UISearchBar的样式
        _searchBar.tintColor = kCOLOR_THEME; // 设置UISearchBar的颜色 使用clearColor就是去掉背景
        _searchBar.searchTextField.textColor = kWhiteColor;
        _searchBar.searchTextField.font = kFontBMedium;
        _searchBar.placeholder = @"请输入相关话题"; // 设置提示文字
        _searchBar.delegate = self; // 设置代理
    }
    return _searchBar;
}

#pragma mark - 实现取消按钮的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"您点击了取消按钮");
    [searchBar resignFirstResponder]; // 丢弃第一使用者
    [searchBar setShowsCancelButton:NO animated:YES];
}
#pragma mark - 实现键盘上Search按钮的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"您点击了键盘上的Search按钮");
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
}
#pragma mark - 实现监听开始输入的方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
#pragma mark - 实现监听输入完毕的方法
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    NSLog(@"输入完毕");
    [searchBar setShowsCancelButton:NO animated:YES];
    
    return YES;
}

- (void)loadData{
    VLTopicRequest *request = [[VLTopicRequest alloc] init];
//    [request setArgument:@"4" forKey:@"parent_id"];
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[VLIndex_Cat_InfoResponse class] json:baseResponse.data];
        weakself.dataArray = [modelArray mutableCopy];
        for (VLIndex_Cat_InfoResponse* catInfo in weakself.dataArray) {
              [weakself.tittleArray addObject:catInfo.cat_name];
              [weakself.catIdArray addObject:@(catInfo.cat_id)];
          }
        [weakself initCategoryView];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
    }];
}


#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
}

#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    VLTopicListView *listView = [[VLTopicListView alloc] init];
    listView.parent_id = [NSString stringWithFormat:@"%@",self.catIdArray[index]];
    listView.delegate = self;
    return listView;
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.tittleArray.count;
}


#pragma mark - VLTopicListViewDelegate
- (void)topicListView:(VLTopicListView *)topicListView didSelectCatid:(NSInteger)catid SelectCatTitle:(NSString *)caTtitle{
    if (catid!=0) {
        self.selectTopicBlock(catid, caTtitle);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}


- (JXCategoryTitleView *)myCategoryView {
    if (_myCategoryView == nil) {
        
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc ]init];
        _myCategoryView = [[JXCategoryTitleView alloc] init];
        kViewBorderRadius(_myCategoryView, 0, 0.4, kColorBlackAlpha20);
        _myCategoryView.listContainer = self.listContainerView;
        _myCategoryView.delegate = self;
        _myCategoryView.titles = self.tittleArray;
        _myCategoryView.indicators = @[lineView];
        _myCategoryView.titleColor = kBlackColor;
        _myCategoryView.titleSelectedColor = kBlackColor;
        _myCategoryView.titleLabelZoomEnabled = YES;
        _myCategoryView.titleFont = kFontBBig;
        _myCategoryView.backgroundColor = [UIColor clearColor];
    }
    return _myCategoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}

@end

