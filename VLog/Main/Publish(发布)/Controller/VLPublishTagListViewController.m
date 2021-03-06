//
//  VLPublishTagListViewController.m
//  VLog
//
//  Created by szy on 2020/10/20.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPublishTagListViewController.h"
#import "JXCategoryView.h"
#import "VLTagListView.h"
#import "VLPublishTagRequest.h"
#import "VLPublishTagResponse.h"


static const CGFloat CategoryViewHeight = 40;

@interface VLPublishTagListViewController ()
<UISearchBarDelegate,
JXCategoryListContentViewDelegate,
JXCategoryListContainerViewDelegate,
JXCategoryViewDelegate,
VLTagListViewDelegate>


KProStrongType(UISearchBar, searchBar)
KProStrongType(JXCategoryTitleView, myCategoryView)
KProStrongType(JXCategoryListContainerView, listContainerView)

KProNSMutableArray(dataArray)
KProStrongType(VLTagListView, brandList)
KProStrongType(VLTagListView, goodsList)

@end

@implementation VLPublishTagListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    self.dataArray = [[NSMutableArray alloc] init];
}
- (void)initSubView{
    [self setTranslucentCoverWtih:UIBlurEffectStyleDark];
    [self initLeftCoverDismissButton:@"niv_back_dark"];
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).inset(10);
        make.height.equalTo(@(45));
    }];
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
        _searchBar.placeholder = @"请输入品牌或商品"; // 设置提示文字
        _searchBar.delegate = self; // 设置代理
        //        _searchBar.text = @"呵呵"; // 设置默认的文字
        //        _searchBar.prompt = @"提示信息"; // 设置提示
        //        _searchBar.showsCancelButton = YES; // 设置时候显示关闭按钮
        //         _searchBar.showsScopeBar = YES; // 设置显示范围框
        // _searchBar.showsSearchResultsButton = YES; // 设置显示搜索结果
        // _searchBar.showsBookmarkButton = YES; // 设置显示书签按钮
        
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
    [self loadData];
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
    VLPublishTagRequest *request = [[VLPublishTagRequest alloc] init];
    NSString *searchStr = self.searchBar.searchTextField.text;
    BOOL select = self.myCategoryView.selectedIndex;
    request.isGoods = select;
    if (select) {
        [request setArgument:searchStr forKey:@"goods_name"];
    }else{
        [request setArgument:searchStr forKey:@"brand_name"];
    }
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
        if (weakself.myCategoryView.selectedIndex == 0) {
            VLPublishBrandTagResponse * dataModel = [VLPublishBrandTagResponse yy_modelWithJSON:baseResponse.data];
            weakself.dataArray = [dataModel.list mutableCopy];
            [weakself.brandList setInfoData:weakself.dataArray tagInfo:weakself.searchBar.searchTextField.text isGoods:NO];
        }else{
            VLPublishGoodsTagResponse * dataModel = [VLPublishGoodsTagResponse yy_modelWithJSON:baseResponse.data];
            weakself.dataArray = [dataModel.list mutableCopy];
            [weakself.goodsList setInfoData:weakself.dataArray tagInfo:weakself.searchBar.searchTextField.text isGoods:YES];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
    }];
}


#pragma mark - VLTagListViewDelegate
//品牌
- (void)tagListView:(VLTagListView *)tagListView didSelectBrandTagModel:(VLPublishBrandTagModel *)brandModel{
    YSCTagModel *model = [[YSCTagModel alloc] init];
    model.path_index = self.path_index;
    model.brand_id = [brandModel.brand_id integerValue];
    model.tag_text = brandModel.brand_name;
    model.top = self.tapPoint.y;
    model.left = self.tapPoint.x;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishTagListViewController:pusblishTagModel:)]) {
        [self.delegate publishTagListViewController:self pusblishTagModel:model];
    }
    
    
    VLVideoInfo_DescModel *descModel = [[VLVideoInfo_DescModel alloc] init];
    descModel.is_tag = YES;
    descModel.name = brandModel.brand_name;
    descModel.tagId = brandModel.brand_id;
    descModel.type  = @"2";
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishTagListViewController:pusblishDescTagModel:)]) {
        [self.delegate publishTagListViewController:self pusblishDescTagModel:descModel];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//商品
- (void)tagListView:(VLTagListView *)tagListView didSelectBGoodsTagModel:(VLPublishGoodsTagModel *)goodsModel{
 
    YSCTagModel *model = [[YSCTagModel alloc] init];
    model.path_index = self.path_index;
    model.goods_id = [goodsModel.goods_id integerValue];
    model.tag_text = goodsModel.goods_name;
    model.top = self.tapPoint.y;
    model.left = self.tapPoint.x;
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishTagListViewController:pusblishTagModel:)]) {
        [self.delegate publishTagListViewController:self pusblishTagModel:model];
    }
    
    
    VLVideoInfo_DescModel *descModel = [[VLVideoInfo_DescModel alloc] init];
    descModel.is_tag = YES;
    descModel.name = goodsModel.goods_name;
    descModel.tagId = goodsModel.goods_id;
    descModel.type  = @"3";
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishTagListViewController:pusblishDescTagModel:)]) {
        [self.delegate publishTagListViewController:self pusblishDescTagModel:descModel];
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//自定义
- (void)tagListView:(VLTagListView *)tagListView didSelectCustomizeWithTitle:(NSString *)title isGoods:(BOOL)isGoods{
    YSCTagModel *model = [[YSCTagModel alloc] init];
    model.path_index = self.path_index;
    model.tag_text = title;
    model.top = self.tapPoint.y;
    model.left = self.tapPoint.x;
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishTagListViewController:pusblishTagModel:)]) {
        [self.delegate publishTagListViewController:self pusblishTagModel:model];
    }
    
    
    VLVideoInfo_DescModel *descModel = [[VLVideoInfo_DescModel alloc] init];
    descModel.is_tag = YES;
    descModel.name = title;
    if (isGoods) {
        descModel.type  = @"3";
    }else{
        descModel.type  = @"2";
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishTagListViewController:pusblishDescTagModel:)]) {
        [self.delegate publishTagListViewController:self pusblishDescTagModel:descModel];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
}

#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        self.brandList = [[VLTagListView alloc] init];
        self.brandList.delegate = self;
        return self.brandList;
    }else{
        self.goodsList = [[VLTagListView alloc] init];
        self.goodsList.delegate = self;
        return self.goodsList;
    }
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 2;
}

- (JXCategoryTitleView *)myCategoryView {
    if (_myCategoryView == nil) {
        
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc ]init];
        _myCategoryView = [[JXCategoryTitleView alloc] init];
        kViewBorderRadius(_myCategoryView, 0, 0.5, kColorWhiteAlpha40);
        _myCategoryView.listContainer = self.listContainerView;
        _myCategoryView.delegate = self;
        _myCategoryView.titles = @[@"品牌",@"商品"];
        _myCategoryView.indicators = @[lineView];
        _myCategoryView.titleColor = kWhiteColor;
        _myCategoryView.titleSelectedColor = kCOLOR_THEME;
        _myCategoryView.titleFont = [UIFont boldSystemFontOfSize:15];
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
