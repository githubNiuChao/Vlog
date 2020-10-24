//
//  YSCVlogPublishView.h
//  VLog
//
//  Created by szy on 2020/9/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLTextViewComposeParser.h"

NS_ASSUME_NONNULL_BEGIN

@class YSCVlogPublishView;
@protocol YSCVlogPublishViewDelegate <NSObject>

//- (void)publishView:(YSCVlogPublishView *)publishView didTopicButtonClicked:(UIButton *)button{
//}

//参与话题
- (void)didTopicViewClicked;
//选择地点
- (void)didLocationViewClicked;

@end

@interface YSCVlogPublishView : UIView

@property (weak, nonatomic) id<YSCVlogPublishViewDelegate> delegate;

@property (strong, nonatomic) UITextField *titleField;
@property (strong, nonatomic) YYTextView *bodyText;
- (void)refreshIndfo:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
