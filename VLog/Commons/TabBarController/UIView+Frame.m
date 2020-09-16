//
//  UIView+Frame.m
//  iOSProject
//
//  Created by szy on 2020/8/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)_x {
    return self.frame.origin.x;
}

- (void)set_x:(CGFloat)_x {
    CGRect frame = self.frame;
    frame.origin.x = _x;
    self.frame = frame;
}

- (CGFloat)_y {
    return self.frame.origin.y;
}

- (void)set_y:(CGFloat)_y {
    CGRect frame = self.frame;
    frame.origin.y = _y;
    self.frame = frame;
}

- (CGFloat)_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)set_right:(CGFloat)_right {
    CGRect frame = self.frame;
    frame.origin.x = _right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)set_bottom:(CGFloat)_bottom {
    
    CGRect frame = self.frame;
    
    frame.origin.y = _bottom - frame.size.height;
    
    self.frame = frame;
}

- (CGFloat)_width {
    return self.frame.size.width;
}

- (void)set_width:(CGFloat)_width {
    CGRect frame = self.frame;
    frame.size.width = _width;
    self.frame = frame;
}

- (CGFloat)_height {
    return self.frame.size.height;
}

- (void)set_height:(CGFloat)_height {
    CGRect frame = self.frame;
    frame.size.height = _height;
    self.frame = frame;
}

- (CGFloat)_centerX {
    return self.center.x;
}

- (void)set_centerX:(CGFloat)_centerX {
    self.center = CGPointMake(_centerX, self.center.y);
}

- (CGFloat)_centerY {
    return self.center.y;
}

- (void)set_centerY:(CGFloat)_centerY {
    self.center = CGPointMake(self.center.x, _centerY);
}

- (CGPoint)_origin {
    return self.frame.origin;
}

- (void)set_origin:(CGPoint)_origin {
    CGRect frame = self.frame;
    frame.origin = _origin;
    self.frame = frame;
}

- (CGSize)_size {
    return self.frame.size;
}

- (void)set_size:(CGSize)_size {
    CGRect frame = self.frame;
    frame.size = _size;
    self.frame = frame;
}

@end
