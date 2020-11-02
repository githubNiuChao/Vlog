//
//  YBCenterView.h
//  YBTagView
//
//  Created by szy on 2020/9/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YBCenterView : UIView

/**
 *  中心红点的按钮
 */
@property (nonatomic, strong) UIButton *button;
/**
 *  中心红点的按钮显示图片
 */
@property (nonatomic, strong) UIImageView *imageView;

- (void)show;
- (void)dismiss;

- (void)startAnimation;
- (void)stopAnimation;

//- (instancetype)initWithPoint:(CGPoint)point;

@end
