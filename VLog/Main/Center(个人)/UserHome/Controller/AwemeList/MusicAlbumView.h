//
//  MusicAlbumView.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Aweme;

@interface MusicAlbumView : UIView

@property (nonatomic, strong) UIImageView      *album;

- (void)startAnimation:(CGFloat)rate;
- (void)resetView;

@end
