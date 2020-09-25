//
//  NCHCollectionViewController.h
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/11.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "NCHBaseViewController.h"
#import "NCHElementsFlowLayout.h"
#import "NCHVerticalFlowLayout.h"
#import "NCHHorizontalFlowLayout.h"


@class NCHCollectionViewController;
@protocol NCHCollectionViewControllerDataSource <NSObject>

@required
// 需要返回对应的布局
- (UICollectionViewLayout *)collectionViewController:(NCHCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView;

@end

@interface NCHCollectionViewController : NCHBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, NCHCollectionViewControllerDataSource>

/**  */
@property (strong, nonatomic) UICollectionView *collectionView;

@end
