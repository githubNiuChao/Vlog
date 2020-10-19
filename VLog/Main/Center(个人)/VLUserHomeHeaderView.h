//
//  VLUserHomeHeaderView.h
//  VLog
//
//  Created by szy on 2020/10/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLUserHomeResponse.h"

NS_ASSUME_NONNULL_BEGIN


static const NSInteger VLUserHomeHeaderAvatarTag = 0x01;
static const NSInteger VLUserHomeHeaderFollowTag = 0x02;
static const NSInteger VLUserHomeHeaderFansTag = 0x03;
static const NSInteger VLUserHomeHeaderLikeTag = 0x04;
static const NSInteger VLUserHomeHeaderSettingTag = 0x05;
static const NSInteger VLUserHomeHeaderGithubTag = 0x06;

@protocol VLUserHomeHeaderViewDelegate

- (void)onUserActionTap:(NSInteger)tag;
@end

@interface VLUserHomeHeaderView : UIView
@property (nonatomic, weak)   id <VLUserHomeHeaderViewDelegate>        delegate;

- (void)setInfoData:(VLUserHomeResponse *)userHomeModel;
- (void)scrollViewDidScroll:(CGFloat)contentOffsetY;
@end

NS_ASSUME_NONNULL_END
