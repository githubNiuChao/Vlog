//
//  VLPhotoDetailBottomView.h
//  VLog
//
//  Created by szy on 2020/10/23.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VLDetailResponse.h"
#import "VLVideoInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@class VLPhotoDetailBottomView;
@protocol VLPhotoDetailBottomViewDelegate <NSObject>

- (void)photoDetailBottomViewShowComment:(VLPhotoDetailBottomView *)bottomView;

@end

@interface VLPhotoDetailBottomView : UIView
@property (nonatomic,weak) id<VLPhotoDetailBottomViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame infoModel:(VLDetailResponse *)infoModel;

@end

NS_ASSUME_NONNULL_END
