//
//  VLCommentTextView.h
//  VLog
//
//  Created by szy on 2020/10/23.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VLCommentTextViewDelegate

@required
-(void)onSendText:(NSString *)text;

@end

@interface VLCommentTextView : UIView

@property (nonatomic, strong) UIView                         *container;
@property (nonatomic, strong) UITextView                     *textView;
@property (nonatomic, strong) id<VLCommentTextViewDelegate>    delegate;

- (void)show;
- (void)dismiss;

@end
NS_ASSUME_NONNULL_END
