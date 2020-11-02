//
//  VLBodyTexToolbarView.h
//  VLog
//
//  Created by szy on 2020/10/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SendTextDelegate

@required
-(void)onSendText:(NSString *)text;

@end

@protocol VLBodyTexToolbarViewDelegate

@required
-(void) hoverTextViewStateChange:(BOOL)isHover;

@end

@interface VLBodyTexToolbarView : UIView

@property (nonatomic, weak) id<SendTextDelegate>             delegate;
@property (nonatomic, weak) id<VLBodyTexToolbarViewDelegate>        hoverDelegate;

@end

NS_ASSUME_NONNULL_END
