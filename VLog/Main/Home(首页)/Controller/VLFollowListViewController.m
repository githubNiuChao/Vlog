//
//  VLFollowListViewController.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLFollowListViewController.h"
#import "VLFollowListRequest.h"
#import "VLFollowResponse.h"
#import "VLNestSubjectViewController.h"

#import "NCHPopView.h"
#import "VLIndexRequest.h"
#import "VLIndexViewController.h"

static NSString *const kVLFollowListTableViewCell = @"VLFollowListTableViewCell";

static const CGFloat CategoryViewHeight = 40;

@interface VLFollowListViewController ()

KProStrongType(UIView, headerView)
KProNSArrayType(VLFollowListModel, dataArray)

@property (nonatomic, strong) JXCategoryTitleView   *myCategoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, strong) UIButton              *catSelector;
@property (nonatomic, strong) UIView                *catSelectorView;
@property (nonatomic, strong) NCHPopView            *popView;
@property (nonatomic, strong) VLIndexResponse       *indexData;
@property (nonatomic, strong) NSMutableArray        *tittleArray;
@property (nonatomic, strong) NSMutableArray        *catIdArray;



@end

@implementation VLFollowListViewController

#pragma mark - Super
- (void)loadMore:(BOOL)isMore{
    
    VLFollowListRequest *request =  [[VLFollowListRequest alloc]init];
    NSLog(@"%@%@",request.baseUrl,request.requestUrl);
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
        VLFollowResponse *dataModel = [VLFollowResponse yy_modelWithJSON:baseResponse.data];
        weakself.dataArray =dataModel.list;
        weakself.tableView.tableHeaderView = [weakself createHeaderView];
        [weakself.tableView reloadData];
        [weakself endHeaderFooterRefreshing];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        [weakself endHeaderFooterRefreshing];
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    self.dataArray = [[NSArray alloc] init];
    self.tittleArray = [[NSMutableArray alloc] init];
    self.catIdArray = [[NSMutableArray alloc] init];
}

- (void)initSubView{
    [self setBackgroundColor:[UIColor whiteColor]];
    self.tableView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[VLFollowListTableViewCell class] forCellReuseIdentifier:kVLFollowListTableViewCell];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLFollowListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVLFollowListTableViewCell];
    VLFollowListModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.followListTableViewCellDelegate = self;
    cell.indexPathRow  = indexPath.row;
    [cell setDataModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)followListTableViewCell:(VLFollowListTableViewCell *)cell didClickFollowButton:(UIButton *)button{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView removeFromSuperview];
        [self loadCategorySubViewData];
        
    });
    
}


- (UIView *)createHeaderView{
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.jk_width, 120)];
    _headerView.backgroundColor = kWhiteColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    label.jk_centerX = _headerView.jk_centerX;
    label.jk_centerY = _headerView.jk_centerY - 10;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"还没有关注的人";
    label.font = kFontBMedium;
    label.textColor = kBlackColor;
    [_headerView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
    label1.jk_centerX = _headerView.jk_centerX;
    label1.jk_centerY = _headerView.jk_centerY + 10;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"关注后可以在这里查看对方的最新动态";
    label1.font = kFontBSmall;
    label1.textColor = kGreyColor;
    [_headerView addSubview:label1];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 90,self.view.jk_width, 0.4)];
    view.backgroundColor = kSysGroupBGColor;
    [_headerView addSubview:view];
    
    UILabel *labe2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 150, 20)];
    labe2.textAlignment = NSTextAlignmentLeft;
    labe2.text = @"为您推荐：";
    labe2.font = kFontBMedium;
    labe2.textColor = kBlackColor;
    [_headerView addSubview:labe2];
    
    
    NCWeakSelf(self);
//    [_headerView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
//        if (weakself.delegate &&[weakself.delegate respondsToSelector:@selector(topicListView:didSelectCatid:SelectCatTitle:)]) {
//            [weakself.delegate topicListView:self didSelectCatid:0 SelectCatTitle:@"不选择话题"];
//        }
//    }];
    return _headerView;
}
















- (void)initCategorySubView{
    [self.view addSubview:self.catSelector];
    [self.view addSubview:self.myCategoryView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _myCategoryView.frame = CGRectMake(0, 0, kkSCREEN_WIDTH - 50, CategoryViewHeight);
    _catSelector.frame = CGRectMake(kkSCREEN_WIDTH - 50, 0, 50, CategoryViewHeight);
    _listContainerView.frame = CGRectMake(0, CategoryViewHeight, kkSCREEN_WIDTH, self.view.jk_height-kTabbarH);
}

- (void)loadCategorySubViewData{
    VLIndexRequest *request =  [[VLIndexRequest alloc]init];
    request.isFolllow = YES;
    NSLog(@"%@%@",request.baseUrl,request.requestUrl);
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        self.indexData = [VLIndexResponse yy_modelWithJSON:baseResponse.data];
        for (VLIndex_Cat_InfoResponse* catInfo in self.indexData.cat_list) {
            [weakself.tittleArray addObject:catInfo.cat_name];
            [weakself.catIdArray addObject:@(catInfo.cat_id)];
        }
        [weakself initCategorySubView];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {

    }];
}


#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //作为嵌套的子容器，不需要处理侧滑手势处理。示例demo因为是继承，所以直接覆盖掉该代理方法，达到父类不调用下面一行处理侧滑手势的代码。
    //    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}


#pragma mark - JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    VLIndexViewController * indexViewController = [[VLIndexViewController alloc] init];
    indexViewController.catId = [self.catIdArray jk_integerWithIndex:index];
    indexViewController.isfollow = YES;
    return indexViewController;
}
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.tittleArray.count;
}

#pragma mark -Action
- (void)actionCatSelectorClick:(UIButton *)buttton{
    buttton.selected = !buttton.selected;
        if (buttton.selected) {
            [self initPopView];
        }else{
            [self.popView dismiss];
        }
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

- (void)initPopView{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kOrangeColor;
    view.frame = CGRectMake(0, 0, kkSCREEN_WIDTH,(kkSCREEN_WIDTH)/2.0);
    _popView = [NCHPopView initWithCustomView:view
                                   parentView:_listContainerView
                                     popStyle:NCHPopStyleSmoothFromTop
                                 dismissStyle:NCHDismissStyleSmoothToTop];
    _popView.hemStyle = NCHHemStyleTop;
    _popView.adjustY = 0;
    _popView.popDuration = 0.5;
    _popView.dismissDuration = 0.5;
    _popView.bgAlpha = 0.0;
    _popView.isSingle = YES;
    _popView.isClickFeedback = YES;
    
    NCWeakSelf(_popView);
    _popView.bgClickBlock = ^{
        [weak_popView dismiss];
    };
    NCWeakSelf(self);
    _popView.popViewWillDismissBlock = ^{
        weakself.catSelector.selected = NO;
    };
    //       [view addTapGestureEventHandle:^(id  _Nonnull sender, UITapGestureRecognizer * _Nonnull gestureRecognizer) {
    //           [wk_popView dismiss];
    //       }];
    //    }
    [_popView pop];
}


#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end
