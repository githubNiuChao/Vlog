//
//  AwemeCollectionCell.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebPImageView;
@class Aweme;

@interface AwemeCollectionCell : UICollectionViewCell

@property (nonatomic, strong) WebPImageView    *imageView;
@property (nonatomic, strong) UIButton         *favoriteNum;

- (void)initData:(Aweme *)aweme;

@end
