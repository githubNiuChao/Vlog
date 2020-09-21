//
//  YSCTagViewController.h
//  VLog
//
//  Created by szy on 2020/9/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPhotoPicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface YSCTagViewController : UIViewController<HXCustomNavigationControllerDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (assign, nonatomic) NSInteger currentModelIndex;
@property (strong, nonatomic) NSMutableArray *modelArray;
@property (strong, nonatomic) UICollectionView *collectionView;

@property (assign, nonatomic) BOOL outside;

@end

NS_ASSUME_NONNULL_END
