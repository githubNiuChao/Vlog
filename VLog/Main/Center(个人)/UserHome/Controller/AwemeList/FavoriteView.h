//
//  FavoriteView.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteView : UIView

@property (nonatomic, strong) UIImageView      *favoriteBefore;
@property (nonatomic, strong) UIImageView      *favoriteAfter;

- (void)resetViewWithIsLike:(BOOL)islike;

@end
