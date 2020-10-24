//
//  VLPhotoDetailBottomView.h
//  VLog
//
//  Created by szy on 2020/10/23.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class VLPhotoDetailBottomView;
@protocol VLPhotoDetailBottomViewDelegate <NSObject>

- (void)detailHeadView:(VLPhotoDetailBottomView *)detailHeadView;
@end

@interface VLPhotoDetailBottomView : UIView

@property (nonatomic,weak) id<VLPhotoDetailBottomViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
