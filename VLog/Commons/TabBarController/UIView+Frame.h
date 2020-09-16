//
//  UIView+Frame.h
//  iOSProject
//
//  Created by szy on 2020/8/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)
@property (nonatomic) CGFloat _x;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat _y;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat _right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat _bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat _width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat _height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat _centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat _centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint _origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  _size;        ///< Shortcut for frame.size.
@end

NS_ASSUME_NONNULL_END
