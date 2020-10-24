//
//  VLSendCommentTextView.h
//  VLog
//
//  Created by szy on 2020/10/23.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SendCommentTextDelegate

@required
-(void)onSendText:(NSString *)text;

@end

@protocol VLSendCommentTextViewDelegate

@required
-(void) hoverTextViewStateChange:(BOOL)isHover;

@end

@interface VLSendCommentTextView : UIView

@property (nonatomic, strong) UITextView                     *textView;
@property (nonatomic, weak) id<SendCommentTextDelegate>             delegate;
@property (nonatomic, weak) id<VLSendCommentTextViewDelegate>        hoverDelegate;

@end


NS_ASSUME_NONNULL_END
