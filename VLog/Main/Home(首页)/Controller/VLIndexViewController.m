//
//  VLIndexViewController.m
//  VLog
//
//  Created by szy on 2020/9/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLIndexViewController.h"
#import "VLIndexListManager.h"
#import "VLIndexListCollectionViewCell.h"
#import "VLPhotoDetailViewController.h"
#import "VLVideoDetailViewController.h"

@interface VLIndexViewController ()
<
NCHBaseModelManagerDelegate,
NCHVerticalFlowLayoutDelegate
>
@property (strong, nonatomic) VLIndexListManager *manager;

@end

@implementation VLIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
}
- (void)initCommon{
    self.manager = [[VLIndexListManager alloc] init];
    self.manager.delegagte = self;
    [self.collectionView registerClass:[VLIndexListCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([VLIndexListCollectionViewCell class])];
}

- (void)viewDidLayoutSubviews{
//    [self.collectionView setFrame:CGRectMake(0, 0, self.view.jk_width, self.view.jk_height-kTabbarH)];
    self.collectionView.frame = self.view.bounds;
}
#pragma mark - Super
-(void)loadMore:(BOOL)isMore{
    self.manager.page = isMore? self.manager.page+=1:0;
    self.manager.isfollow = self.isfollow;
    [self.manager loadDataWithCatId:self.catId];
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
    cell.listModel = self.manager.dataArray[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    VLIndexListCollectionViewCell *cell =(VLIndexListCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    VLPhotoDetailViewController *photoDetaiVC = [VLPhotoDetailViewController new];
    VLVideoInfoModel *listModel = self.manager.dataArray[indexPath.row];
    photoDetaiVC.video_id = listModel.video_id;
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
    VLVideoInfoModel *listModel = self.manager.dataArray[indexPath.row];
      if (listModel.imageCacheHeight == 0 || listModel.hobbysCacheHeight == 0) {
        listModel.hobbysCacheHeight = [listModel.video_title jk_heightWithFont:kFontSmall constrainedToWidth:itemWidth];
        listModel.imageCacheHeight = listModel.height * itemWidth / listModel.width;
      }
    return listModel.imageCacheHeight + listModel.hobbysCacheHeight + 70;
}

#pragma mark - <JXCategoryListContentViewDelegate>
- (void)listDidAppear{
    
}

- (UIView *)listView {
    return self.view;
}

@end
