//
//  YSCVlogPublishView.h
//  VLog
//
//  Created by szy on 2020/9/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YSCVlogPublishView;
@protocol YSCVlogPublishViewDelegate <NSObject>

//参与话题
- (void)publishView:(YSCVlogPublishView *)publishView didTopicButtonClicked:(UIButton *)button;
//选择地点
- (void)publishView:(YSCVlogPublishView *)publishView didLocationButtonClicked:(UIButton *)button;

@end

@interface YSCVlogPublishView : UIView

@property (weak, nonatomic) id<YSCVlogPublishViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
