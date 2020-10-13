//
//  VLNestSubjectViewController.m
//  VLog
//
//  Created by szy on 2020/9/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLNestSubjectViewController.h"
#import "VLIndexViewController.h"
#import "VLIndexRequest.h"
#import "VLIndexResponse.h"
#import "LSTPopView.h"

static const CGFloat CategoryViewHeight = 40;

@interface VLNestSubjectViewController ()

@property (nonatomic, strong) JXCategoryTitleView   *myCategoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, strong) UIButton              *catSelector;
@property (nonatomic, strong) UIView                *catSelectorView;

@property (nonatomic, strong) VLIndexResponse       *indexData;
@property (nonatomic, strong) NSMutableArray        *tittleArray;
@property (nonatomic, strong) NSMutableArray        *catIdArray;

@end

@implementation VLNestSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
    [self loadData];
}

- (void)initCommon{
    self.tittleArray = [[NSMutableArray alloc] init];
    self.catIdArray = [[NSMutableArray alloc] init];
}

- (void)initSubView{
    [self.view addSubview:self.catSelector];
    [self.view addSubview:self.myCategoryView];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _myCategoryView.frame = CGRectMake(0, 0, kSCREEN_WIDTH - 50, CategoryViewHeight);
    _catSelector.frame = CGRectMake(kSCREEN_WIDTH - 50, 0, 50, CategoryViewHeight);
}

- (void)loadData{
       VLIndexRequest *request =  [[VLIndexRequest alloc]init];
        NSLog(@"%@%@",request.baseUrl,request.requestUrl);
        [request setArgument:@"asthare" forKey:@"user_name"];
        [request setArgument:@"123456" forKey:@"password"];
//        [request setArgument:@"15" forKey:@"video_id"];
//    [request setArgument:@"2" forKey:@"cat_id"];
        NCWeakSelf(self);
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//            [weakself endHeaderFooterRefreshing];
            NCHBaseRequestResponse *baseRespose = [NCHBaseRequestResponse yy_modelWithJSON:request.responseObject];
            self.indexData = [VLIndexResponse yy_modelWithJSON:baseRespose.data];
            for (VLIndex_Cat_InfoResponse* catInfo in self.indexData.cat_list) {
                [weakself.tittleArray addObject:catInfo.cat_name];
                [weakself.catIdArray addObject:@(catInfo.cat_id)];
            }
            [weakself initSubView];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//            [weakself endHeaderFooterRefreshing];
        }];
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
    indexViewController.catId = [self.catIdArray jk_integerWithIndex:index];
//    NCWeakSelf(self);
//    indexViewController.reshblock = ^(NSArray * _Nonnull titles) {
//        weakself.myCategoryView.titles = titles;
//    };
    
    return indexViewController;
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.tittleArray.count;
}

#pragma mark -Action
- (void)actionCatSelectorClick:(UIButton *)buttton{
    [self showCatSelectorView];
    
}


#pragma mark - Set/Get


- (JXCategoryTitleView *)myCategoryView {
    if (_myCategoryView == nil) {
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc ]init];
        _myCategoryView = [[JXCategoryTitleView alloc] init];
        _myCategoryView.listContainer = self.listContainerView;
        _myCategoryView.delegate = self;
        _myCategoryView.titles = self.tittleArray;
        _myCategoryView.indicators = @[lineView];
        _myCategoryView.titleColor = [UIColor grayColor];
        _myCategoryView.titleSelectedColor = [UIColor redColor];
        _myCategoryView.titleFont = [UIFont boldSystemFontOfSize:15];
        _myCategoryView.backgroundColor = [UIColor whiteColor];
        }
      return _myCategoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
        [self.view addSubview:_listContainerView];
    }
    return _listContainerView;
}

- (UIButton *)catSelector{
    if (!_catSelector) {
        _catSelector = [[UIButton alloc]init];
        _catSelector.backgroundColor = kOrangeColor;
        [_catSelector addTarget:self action:@selector(actionCatSelectorClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _catSelector;
}

- (void)showCatSelectorView{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, kSCREEN_WIDTH,(kSCREEN_WIDTH)/2.0);
    LSTPopView *popView = [LSTPopView initWithCustomView:view
                                             parentView:self.view
                                               popStyle:LSTPopStyleSpringFromTop
                                           dismissStyle:LSTDismissStyleSmoothToTop];
    popView.hemStyle = LSTHemStyleTop;
    //       popView.adjustY = LSTNavBarHeight()+100;
    NCWeakSelf(popView);
    popView.popDuration = 0.5;
    popView.dismissDuration = 0.5;
    popView.isClickFeedback = YES;
    popView.bgClickBlock = ^{
       NSLog(@"点击了背景");
       [weakpopView dismiss];
    };
    //       [view addTapGestureEventHandle:^(id  _Nonnull sender, UITapGestureRecognizer * _Nonnull gestureRecognizer) {
    //           [wk_popView dismiss];
    //       }];

    [popView pop];

}



@end
