//
//  VLPhotoDetailHeadView.h
//  VLog
//
//  Created by szy on 2020/9/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VLPhotoDetailHeadView : UIView 

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)array;

KProStrongType(NSArray, imageArrays);

@end

NS_ASSUME_NONNULL_END
