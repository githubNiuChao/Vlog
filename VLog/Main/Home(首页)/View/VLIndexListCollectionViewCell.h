//
//  VLIndexListCollectionViewCell.h
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLIndexModel.h"
#import "VLVideoInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLIndexListCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) VLVideoInfoModel *listModel;
@property (strong, nonatomic) UIImageView *imgView;

@end

NS_ASSUME_NONNULL_END
