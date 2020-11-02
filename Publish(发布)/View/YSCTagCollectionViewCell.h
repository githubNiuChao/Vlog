//
//  YSCTagCollectionViewCell.h
//  VLog
//
//  Created by szy on 2020/9/18.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSCTagModel.h"

NS_ASSUME_NONNULL_BEGIN

@class YSCTagCollectionViewCell;
@protocol TagCollectionViewCellDelegate <NSObject>

- (void)tagCollectionViewCell:(YSCTagCollectionViewCell *)cell didClickImageViewWithTap:(CGPoint)tapPoint;

@end

@interface YSCTagCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id< TagCollectionViewCellDelegate> delegate;
@property (nonatomic, strong) HXPhotoModel *model;

//添加标签视图
- (void)addTagWithPusblishTagModel:(YSCTagModel *)tagModel;


@end

NS_ASSUME_NONNULL_END
