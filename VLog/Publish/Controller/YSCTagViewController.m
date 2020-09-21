//
//  YSCTagViewController.m
//  VLog
//
//  Created by szy on 2020/9/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "YSCTagViewController.h"
#import "YSCTagCollectionViewCell.h"
#import "HXPhotoCustomNavigationBar.h"

@interface YSCTagViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) HXPhotoModel *currentModel;
@property (strong, nonatomic) HXPhotoCustomNavigationBar *navBar;
@property (strong, nonatomic) UIView *tagBottomView;
@property (strong, nonatomic) UIButton *nextBtn;//完成

@end

@implementation YSCTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupUI];
    [self changeColor];
}

- (void)setupUI{
    self.title = @"点击图片添加标签";
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.navBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.nextBtn];
    
}

- (void)changeColor{
    
    UIColor *themeColor;
    UIColor *navBarBackgroudColor;
    UIColor *navigationTitleColor;
    themeColor = self.manager.configuration.themeColor;
    navBarBackgroudColor = self.manager.configuration.navBarBackgroudColor;
    navigationTitleColor = self.manager.configuration.navigationTitleColor;
    
    if (!self.outside) {
        [self.navigationController.navigationBar setTintColor:themeColor];
        self.navigationController.navigationBar.barTintColor = navBarBackgroudColor;
        self.navigationController.navigationBar.barStyle = self.manager.configuration.navBarStyle;
        
    }else {
        [self.navBar setTintColor:themeColor];
        self.navBar.barTintColor = navBarBackgroudColor;
        self.navBar.barStyle = self.manager.configuration.navBarStyle;
        if (self.manager.configuration.navBarBackgroundImage) {
            [self.navBar setBackgroundImage:self.manager.configuration.navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
        }
    }
    
    UIColor *doneBtnDarkBgColor = self.manager.configuration.bottomDoneBtnDarkBgColor ?: [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    UIColor *doneBgColor = self.manager.configuration.bottomDoneBtnBgColor ?: self.manager.configuration.themeColor;
    self.nextBtn.backgroundColor = [HXPhotoCommon photoCommon].isDark ? doneBtnDarkBgColor : doneBgColor;
    
}

#pragma mark - < UICollectionViewDataSource >
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.modelArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXPhotoModel *model = self.modelArray[indexPath.item];
    YSCTagCollectionViewCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YSCTagCollectionViewCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}


#pragma mark - Action
- (void)didDoneClick:(UIButton *)button{
    
    
    
}

- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitle:[NSBundle hx_localizedStringForKey:@"完成"] forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont hx_mediumPingFangOfSize:15];
        _nextBtn.hx_size = CGSizeMake(65, 18);
        _nextBtn.layer.cornerRadius = 3;
        [_nextBtn addTarget:self action:@selector(didDoneClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.itemSize = CGSizeMake(self.view.hx_w, self.view.hx_h);
        _flowLayout.minimumLineSpacing = 20;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, 0,self.view.hx_w + 20, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[YSCTagCollectionViewCell class] forCellWithReuseIdentifier:@"YSCTagCollectionViewCell"];
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _collectionView;
}
    
- (HXPhotoCustomNavigationBar *)navBar {
    if (!_navBar) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _navBar = [[HXPhotoCustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, width, hxNavigationBarHeight)];
        _navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return _navBar;
}


- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if ([HXPhotoCommon photoCommon].isDark) {
        return UIStatusBarStyleLightContent;
    }
    return self.manager.configuration.statusBarStyle;
}
//- (BOOL)prefersStatusBarHidden {
//    if (!self) {
//        return [super prefersStatusBarHidden];
//    }
//    return self.statusBarShouldBeHidden;
//}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

@end
