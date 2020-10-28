//
//  VLPhotoDetailHeadICollectionViewCell.h
//  VLog
//
//  Created by szy on 2020/10/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLDetailResponse.h"
#import "YBTagView.h"

NS_ASSUME_NONNULL_BEGIN

@class VLPhotoDetailHeadICollectionViewCell;
@protocol VLPhotoDetailHeadICollectionViewCellDelegate <NSObject>

- (void)photoDetailHeadICollectionViewCell:(VLPhotoDetailHeadICollectionViewCell *)cell didClickTagForViewModel:(VLDetail_TagListResponse *)tagListModel;

@end

@interface VLPhotoDetailHeadICollectionViewCell : UICollectionViewCell<YBTagViewDelegate>

@property (weak, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) NSString *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, assign) NSTextAlignment titleLabelTextAlignment;

@property (nonatomic, assign) BOOL hasConfigured;

/** 只展示文字轮播 */
@property (nonatomic, assign) BOOL onlyDisplayText;


@property (nonatomic, weak) id<VLPhotoDetailHeadICollectionViewCellDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *tagViewarray;
- (void)addTagWithPointWithTagModel:(VLDetail_TagListResponse *)tagListModel;

@end

NS_ASSUME_NONNULL_END
