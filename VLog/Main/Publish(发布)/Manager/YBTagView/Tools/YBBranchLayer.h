//
//  YBBranchLayer.h
//  YBTagView
//
//  Created by szy on 2020/9/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface YBBranchLayer : CAShapeLayer<CAAnimationDelegate>

@property (nonatomic, strong) CABasicAnimation *animation;

- (void)commitPathWithStartPoint:(CGPoint)startPoint midPoint:(CGPoint)midPoint endPoint:(CGPoint)endPoint withBlock:(void(^)(CGFloat time))block;

//- (void)animationDelay:(NSTimeInterval)delay With:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
