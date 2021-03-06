//
//  NCHCollectionViewController.m
//  VLog
//
//  Created by szy on 2020/9/12.
//  Copyright © 2020 niuchao. All rights reserved.
//

//

#import "NCHCollectionViewController.h"
#import "NCHAutoRefreshFooter.h"

@interface NCHCollectionViewController ()<NCHVerticalFlowLayoutDelegate>

@end

@implementation NCHCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBaseNCHCollectionViewControllerUI];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
}

- (void)setupBaseNCHCollectionViewControllerUI
{
//    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
//        UIEdgeInsets contentInset = self.collectionView.contentInset;
//        contentInset.top += self.jk_navgationBar.jk_height;
//        self.collectionView.contentInset = contentInset;
//    }

    UICollectionViewLayout *myLayout = [self collectionViewController:self layoutForCollectionView:self.collectionView];
    self.collectionView.collectionViewLayout = myLayout;
    self.collectionView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor yellowColor];
    cell.contentView.clipsToBounds = YES;
    return cell;
}

#pragma mark - scrollDeleggate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    contentInset.bottom -= self.collectionView.mj_footer.jk_height;
    self.collectionView.scrollIndicatorInsets = contentInset;
    [self.view endEditing:YES];
}


#pragma mark - getter
- (UICollectionView *)collectionView
{
    if(_collectionView == nil){
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
        [self.view addSubview:_collectionView];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}


#pragma mark - NCHCollectionViewControllerDataSource
- (UICollectionViewLayout *)collectionViewController:(NCHCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView
{
    NCHVerticalFlowLayout *myLayout = [[NCHVerticalFlowLayout alloc] initWithDelegate:self];
    return myLayout;
}


#pragma mark - NCHVerticalFlowLayoutDelegate

- (CGFloat)waterflowLayout:(NCHVerticalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    return itemWidth * (arc4random() % 4 + 1);
}


@end
