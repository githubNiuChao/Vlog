//
//  VLCommentTextView.m
//  VLog
//
//  Created by szy on 2020/10/23.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLCommentTextView.h"

static const CGFloat kCommentTextViewLeftInset               = 15;
static const CGFloat kCommentTextViewRightInset              = 60;
static const CGFloat kCommentTextViewTopBottomInset          = 15;

@interface VLCommentTextView ()<UITextViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, assign) CGFloat            textHeight;
@property (nonatomic, assign) CGFloat            keyboardHeight;
@property (nonatomic, retain) UILabel            *placeholderLabel;
@property (nonatomic, strong) UIImageView        *atImageView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@end

@implementation VLCommentTextView
- (instancetype)init {
    self = [super init];
    if(self) {
        self.frame = ScreenFrame;
        self.backgroundColor = ColorClear;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)]];
        
        
        _container = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 50)];
        _container.backgroundColor = ColorBlackAlpha40;
        [self addSubview:_container];
        
        _keyboardHeight = kSafeHeightBottom;
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        _textView.backgroundColor = ColorClear;
        
        _textView.clipsToBounds = NO;
        _textView.textColor = ColorWhite;
        _textView.font = BigFont;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.scrollEnabled = NO;
        _textView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
        _textView.textContainerInset = UIEdgeInsetsMake(kCommentTextViewTopBottomInset, kCommentTextViewLeftInset, kCommentTextViewTopBottomInset, kCommentTextViewRightInset);
        _textView.textContainer.lineFragmentPadding = 0;
        _textHeight = ceilf(_textView.font.lineHeight);
        
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.text = @"说点什么~~~~";
        _placeholderLabel.textColor = ColorGray;
        _placeholderLabel.font = MediumFont;
        _placeholderLabel.frame = CGRectMake(kCommentTextViewLeftInset, 0, ScreenWidth - kCommentTextViewLeftInset - kCommentTextViewRightInset, 50);
        [_textView addSubview:_placeholderLabel];
        
//        _atImageView = [[UIImageView alloc] init];
//        _atImageView.contentMode = UIViewContentModeCenter;
//        _atImageView.image = [UIImage imageNamed:@"iconWhiteaBefore"];
//        [_textView addSubview:_atImageView];
        
        
        [_container addSubview:_textView];
        _textView.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    _atImageView.frame = CGRectMake(ScreenWidth - 50, 0, 50, 50);
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10.0f, 10.0f)];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    _container.layer.mask = shape;
    
    [self updateTextViewFrame];
}


- (void)updateTextViewFrame {
//    CGFloat textViewHeight = _keyboardHeight > kSafeHeightBottom ? _textHeight + 2*kCommentTextViewTopBottomInset : ceilf(_textView.font.lineHeight) + 2*kCommentTextViewTopBottomInset;
    CGFloat textViewHeight = _keyboardHeight > kSafeHeightBottom ? _textHeight + 2*kCommentTextViewTopBottomInset : 0;
    _textView.frame = CGRectMake(0, 0, ScreenWidth, textViewHeight);
    _container.frame = CGRectMake(0, ScreenHeight - _keyboardHeight - textViewHeight, ScreenWidth, textViewHeight + _keyboardHeight);
}

//keyboard notification
- (void)keyboardWillShow:(NSNotification *)notification {
    _keyboardHeight = [notification keyBoardHeight];
    [self updateTextViewFrame];
    _atImageView.image = [UIImage imageNamed:@"iconBlackaBefore"];
    _container.backgroundColor = ColorWhite;
    _textView.textColor = ColorBlack;
    self.backgroundColor = ColorBlackAlpha60;
}

- (void)keyboardWillHide:(NSNotification *)notification {
//    _keyboardHeight = kSafeHeightBottom;
    _keyboardHeight = 0;
    [self updateTextViewFrame];
    _atImageView.image = [UIImage imageNamed:@"iconWhiteaBefore"];
    _container.backgroundColor = ColorBlackAlpha40;
    _textView.textColor = ColorWhite;
    self.backgroundColor = ColorClear;
}

//textView delegate
-(void)textViewDidChange:(UITextView *)textView {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:textView.attributedText];
    
    if(!textView.hasText) {
        [_placeholderLabel setHidden:NO];
        _textHeight = ceilf(_textView.font.lineHeight);
    }else {
        [_placeholderLabel setHidden:YES];
        _textHeight = [attributedText multiLineSize:ScreenWidth - kCommentTextViewLeftInset - kCommentTextViewRightInset].height;
    }
    [self updateTextViewFrame];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        if(_delegate) {
            [_delegate onSendText:textView.text];
            [_placeholderLabel setHidden:NO];
            textView.text = @"";
            _textHeight = ceilf(textView.font.lineHeight);
            [textView resignFirstResponder];
        }
        return NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [self dismiss];
}

//handle guesture tap
- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:_textView];
    if(![_textView.layer containsPoint:point]) {
        [_textView resignFirstResponder];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        if(hitView.backgroundColor == ColorClear) {
            return nil;
        }
    }
    return hitView;
}

//update method
- (void)showWtihTitle:(NSString *)title{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    window.backgroundColor = kColorBlackAlpha60;
    [window addSubview:self];
    [self.textView becomeFirstResponder];
    self.placeholderLabel.text = [NSString stringWithFormat:@"回复：%@",title];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
