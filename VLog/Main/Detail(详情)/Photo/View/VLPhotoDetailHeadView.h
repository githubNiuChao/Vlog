//
//  VLPhotoDetailHeadView.h
//  VLog
//
//  Created by szy on 2020/9/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLPhotoDetailResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface VLPhotoDetailHeadView : UIView 

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)array;

- (void)setInfo:(VLPhotoDetailResponse *)info;

@end

NS_ASSUME_NONNULL_END
