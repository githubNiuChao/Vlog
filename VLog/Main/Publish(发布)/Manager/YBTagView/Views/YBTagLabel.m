//
//  YBTagLabel.m
//  YBTagView
//
//  //  Created by szy on 2020/9/16.
//  Copyright © 2020 niuchao. All rights reserved.
//
#import "YBTagLabel.h"
#import "YBTagHeader.h"

#define lineH 1

@implementation YBTagLabel

- (instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string
{
    if (self = [super initWithFrame:frame]) {
        
        //用Attribute添加带下划线的label
//        [self addAttributeLabelWithStr:string];
        
        //直接在label上加线
        [self addLineLabelWithStr:string withFrame:frame];
        
        //添加点击手势
        YBTagGestureRecognizer *gesture = [[YBTagGestureRecognizer alloc]initWithTarget:self action:@selector(tagGesture:)];
        gesture.gestureString = string;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
    }
    
    return self;
}



- (void)tagGesture:(YBTagGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagLabelDelegateMethod:)]) {
        [self.delegate tagLabelDelegateMethod:gesture.gestureString];
    }
    
    //TODO: 通知第一步
//    NSDictionary *text =[[NSDictionary alloc] initWithObjectsAndKeys:gesture.gestureString,@"gestureString",nil];
//    NSNotification *notification =[NSNotification notificationWithName:@"noticeMethod" object:self userInfo:text];
    //TODO: 通知第二步
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
}


/**
 *  用Attribute添加带下划线的label
 */
- (void)addAttributeLabelWithStr:(NSString *)string
{
    self.backgroundColor = [UIColor redColor];
    self.numberOfLines = 1;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange contentRange = NSMakeRange(0, [content length]);
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    self.attributedText = content;
}

/**
 *  直接在label上加线
 */
- (void)addLineLabelWithStr:(NSString *)string  withFrame:(CGRect)frame
{
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
    self.font = [UIFont boldSystemFontOfSize:12.0];
    self.alpha = 0;
    _selfW = frame.size.width;
    _selfStr = string;
}


- (void)delay
{
    [UIView animateWithDuration:1.0 animations:^{
        self.text = self->_selfStr;
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}


@end
