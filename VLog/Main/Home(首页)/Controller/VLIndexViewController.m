//
//  VLIndexViewController.m
//  VLog
//
//  Created by szy on 2020/9/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLIndexViewController.h"
#import "VLIndexListManager.h"
//#import "PersonListCollectionViewCell.h"
#import "VLIndexListCollectionViewCell.h"
#import "ProfileViewController.h"
#import "VLPhotoDetailViewController.h"

@interface VLIndexViewController ()
<
VLIndexListManagerDelegate,
NCHVerticalFlowLayoutDelegate
>
@property (strong, nonatomic) VLIndexListManager *manager;

@end

@implementation VLIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [[VLIndexListManager alloc] init];
    self.manager.delegagte = self;
    [self.collectionView registerClass:[VLIndexListCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([VLIndexListCollectionViewCell class])];
}

- (void)viewDidLayoutSubviews{
    [self.collectionView setFrame:CGRectMake(0, 0, self.view.jk_width, self.view.jk_height-kTabbarH)];
}
#pragma mark - Super
-(void)loadMore:(BOOL)isMore{
    self.manager.page = isMore? self.manager.page+=1:0;
    [self.manager loadData];
}

#pragma mark - <VLIndexListManagerDelegate>
-(void)requestDataCompleted{
    [self.collectionView reloadData];
    [self endHeaderFooterRefreshing];
}

#pragma mark — UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.manager.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VLIndexListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([VLIndexListCollectionViewCell class]) forIndexPath:indexPath];
    cell.personModel = self.manager.dataArray[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VLIndexListCollectionViewCell *cell =(VLIndexListCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    VLPhotoDetailViewController *photoDetaiVC = [VLPhotoDetailViewController new];
//    profileVC.headerImage = cell.imgView.image;
//    profileVC.isTransition = YES;
    photoDetaiVC.imageArray = cell.personModel.imageArray;
    [self.navigationController pushViewController:photoDetaiVC animated:YES];
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
    VLIndexModel *personModel = self.manager.dataArray[indexPath.row];
      if (personModel.imageCacheHeight == 0 || personModel.hobbysCacheHeight == 0) {
        personModel.hobbysCacheHeight = [personModel.hobbys jk_heightWithFont:kFontSmall constrainedToWidth:itemWidth];
        personModel.imageCacheHeight = personModel.imageHeight * itemWidth / personModel.imageWidth;
      }
    return personModel.imageCacheHeight + personModel.hobbysCacheHeight + 70;
}

#pragma mark - <JXCategoryListContentViewDelegate>
- (void)listDidAppear{
}

- (UIView *)listView {
    return self.view;
}


@end
