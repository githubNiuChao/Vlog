//
//  VLPhotoDetailHeadView.h
//  VLog
//
//  Created by szy on 2020/9/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLDetailResponse.h"

NS_ASSUME_NONNULL_BEGIN
@class VLPhotoDetailHeadView;
@protocol VLPhotoDetailHeadViewDelegate <NSObject>
- (void)detailHeadView:(VLPhotoDetailHeadView *)detailHeadView;
@end

@interface VLPhotoDetailHeadView : UIView 

@property (nonatomic,weak) id<VLPhotoDetailHeadViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)array;
- (void)setInfo:(VLDetailResponse *)info;

@end

NS_ASSUME_NONNULL_END
