//
//  HoverTextView.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendTextDelegate

@required
-(void)onSendText:(NSString *)text;

@end

@protocol HoverTextViewDelegate

@required
-(void) hoverTextViewStateChange:(BOOL)isHover;

@end

@interface HoverTextView : UIView

@property (nonatomic, strong) UITextView                     *textView;
@property (nonatomic, weak) id<SendTextDelegate>             delegate;
@property (nonatomic, weak) id<HoverTextViewDelegate>        hoverDelegate;

@end

