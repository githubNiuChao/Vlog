//
//  ChatTextView.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

//chat edit message type enum
typedef NS_ENUM(NSUInteger,ChatEditMessageType) {
    EditTextMessage        = 0,
    EditPhotoMessage       = 1,
    EditEmotionMessage     = 2,
    EditNoneMessage        = 3,
};


@protocol ChatTextViewDelegate

@required
-(void)onSendText:(NSString *)text;
-(void)onSendImages:(NSMutableArray<UIImage *> *)images;
-(void)onEditBoardHeightChange:(CGFloat)height;

@end


@interface ChatTextView : UIView
@property (nonatomic, strong) UIView                 *container;
@property (nonatomic, strong) UITextView             *textView;
@property (nonatomic, assign) ChatEditMessageType    editMessageType;
@property (nonatomic, weak) id<ChatTextViewDelegate> delegate;

- (void)show;
- (void)dismiss;

@end

