//
//  PhotoView.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CircleProgressView;

@interface PhotoView:UIView

@property (nonatomic, strong) CircleProgressView        *progressView;
@property (nonatomic, strong) UIView                    *container;
@property (nonatomic, strong) UIImageView               *imageView;

- (instancetype)initWithUrl:(NSString *)urlPath;
- (instancetype)initWithImage:(UIImage *)image urlPath:(NSString *)urlPath;
- (instancetype)initWithImage:(UIImage *)image;

- (void)show;
- (void)dismiss;

@end
