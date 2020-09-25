//
//  VLIndexViewController.m
//  VLog
//
//  Created by szy on 2020/9/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLIndexViewController.h"
#import "VLIndexListManager.h"
#import "PersonListCollectionViewCell.h"

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
    
    [self.collectionView registerClass:[PersonListCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([PersonListCollectionViewCell class])];
}

#pragma mark - Super
-(void)loadMore:(BOOL)isMore{
    if (isMore) self.manager.page+=1;
    [self.manager loadData];
}

#pragma mark - <VLIndexListManagerDelegate>
-(void)requestDataCompleted{
    [self.collectionView reloadData];
    [self endHeaderFooterRefreshing];
}

#pragma mark ————— collection代理方法 —————
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.manager.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PersonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PersonListCollectionViewCell class]) forIndexPath:indexPath];
    cell.personModel = self.manager.dataArray[indexPath.row];
    
    return cell;
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
      if (personModel.height && personModel.hobbysHeight == 0) {
          CGFloat hobbyH=[personModel.hobbys jk_heightWithFont:FFont1 constrainedToWidth:itemWidth];
          personModel.hobbysHeight = hobbyH;
      }
      CGFloat imgH = personModel.height * itemWidth / personModel.width;
      
      return imgH + 110 + personModel.hobbysHeight;
}

#pragma mark - <JXCategoryListContentViewDelegate>
- (void)listDidAppear{
}

- (UIView *)listView {
    return self.view;
}


@end
