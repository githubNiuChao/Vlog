//
//  VLTextViewComposeParser.m
//  VLog
//
//  Created by szy on 2020/10/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLTextViewComposeParser.h"

@implementation VLTextViewComposeParser

- (instancetype)init {
    self = [super init];
    _font = kFontBMedium;
    _textColor = [UIColor colorWithWhite:0.2 alpha:1];
    _highlightTextColor = kBuleColor;
    return self;
}

- (BOOL)parseText:(NSMutableAttributedString *)text selectedRange:(NSRangePointer)selectedRange {
     text.yy_color = _textColor;
    {
        static NSArray *topicExts, *topicExtImages;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            topicExts = @[VLTextViewComposeParserBrandKey,VLTextViewComposeParserGoodsKey];
            topicExtImages = @[
                [UIImage imageNamed:@"publish_tag_goodsicon"],
                [UIImage imageNamed:@"publish_tag_brandicon"],
            ];
        });
        
        NSArray<NSTextCheckingResult *> *topicResults = [[self regexTopic] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
        NSUInteger clipLength = 0;
        for (NSTextCheckingResult *topic in topicResults) {
            if (topic.range.location == NSNotFound && topic.range.length <= 1) continue;
            NSRange range = topic.range;
            range.location -= clipLength;
            
            __block BOOL containsBindingRange = NO;
            [text enumerateAttribute:YYTextBindingAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
                if (value) {
                    containsBindingRange = YES;
                    *stop = YES;
                }
            }];
            if (containsBindingRange) continue;
            
            BOOL hasExt = NO;
            NSString *subText = [text.string substringWithRange:range];
            for (NSUInteger i = 0; i < topicExts.count; i++) {
                NSString *ext = topicExts[i];
                if ([subText hasSuffix:ext] && subText.length > ext.length + 1) {
                    
                    NSMutableAttributedString *replace = [[NSMutableAttributedString alloc] initWithString:[subText substringWithRange:NSMakeRange(1, subText.length - 1 - ext.length)]];
                    NSAttributedString *pic = [self _attachmentWithFontSize:_font.pointSize image:topicExtImages[i] shrink:YES];
                    [replace insertAttributedString:pic atIndex:0];
                    replace.yy_font = _font;
                    replace.yy_color = _highlightTextColor;
                    
                    // original text, used for text copy
                    YYTextBackedString *backed = [YYTextBackedString stringWithString:subText];
                    [replace yy_setTextBackedString:backed range:NSMakeRange(0, replace.length)];
                    
                    [text replaceCharactersInRange:range withAttributedString:replace];
                    [text yy_setTextBinding:[YYTextBinding bindingWithDeleteConfirm:YES] range:NSMakeRange(range.location, replace.length)];
                    [text yy_setColor:_highlightTextColor range:NSMakeRange(range.location, replace.length)];
                    if (selectedRange) {
                        *selectedRange = [self _replaceTextInRange:range withLength:replace.length selectedRange:*selectedRange];
                    }
                    
                    clipLength += range.length - replace.length;
                    hasExt = YES;
                    break;
                }
            }
            
            if (!hasExt) {
                [text yy_setColor:_highlightTextColor range:range];
            }
        }
    }
    
     [text enumerateAttribute:YYTextBindingAttributeName inRange:text.yy_rangeOfAll options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            if (value && range.length > 1) {
                [text yy_setColor:_highlightTextColor range:range];
            }
        }];
    text.yy_font = _font;
    return YES;
}

// correct the selected range during text replacement
- (NSRange)_replaceTextInRange:(NSRange)range withLength:(NSUInteger)length selectedRange:(NSRange)selectedRange {
    // no change
    if (range.length == length) return selectedRange;
    // right
    if (range.location >= selectedRange.location + selectedRange.length) return selectedRange;
    // left
    if (selectedRange.location >= range.location + range.length) {
        selectedRange.location = selectedRange.location + length - range.length;
        return selectedRange;
    }
    // same
    if (NSEqualRanges(range, selectedRange)) {
        selectedRange.length = length;
        return selectedRange;
    }
    // one edge same
    if ((range.location == selectedRange.location && range.length < selectedRange.length) ||
        (range.location + range.length == selectedRange.location + selectedRange.length && range.length < selectedRange.length)) {
        selectedRange.length = selectedRange.length + length - range.length;
        return selectedRange;
    }
    selectedRange.location = range.location + length;
    selectedRange.length = 0;
    return selectedRange;
}


- (NSAttributedString *)_attachmentWithFontSize:(CGFloat)fontSize image:(UIImage *)image shrink:(BOOL)shrink {
    
    //    CGFloat ascent = YYEmojiGetAscentWithFontSize(fontSize);
    //    CGFloat descent = YYEmojiGetDescentWithFontSize(fontSize);
    //    CGRect bounding = YYEmojiGetGlyphBoundingRectWithFontSize(fontSize);
    
    // Heiti SC 字体。。
    CGFloat ascent = fontSize * 0.86;
    CGFloat descent = fontSize * 0.14;
    CGRect bounding = CGRectMake(0, -0.14 * fontSize, fontSize, fontSize);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(ascent - (bounding.size.height + bounding.origin.y), 0, descent + bounding.origin.y, 0);
    
    YYTextRunDelegate *delegate = [YYTextRunDelegate new];
    delegate.ascent = ascent;
    delegate.descent = descent;
    delegate.width = bounding.size.width;
    
    YYTextAttachment *attachment = [YYTextAttachment new];
    attachment.contentMode = UIViewContentModeScaleAspectFit;
    attachment.contentInsets = contentInsets;
    attachment.content = image;
    attachment.userInfo = [NSDictionary dictionaryWithObject:@"10" forKey:@"keyy"];
    
    if (shrink) {
        // 缩小~
        CGFloat scale = 1 / 10.0;
        contentInsets.top += fontSize * scale;
        contentInsets.bottom += fontSize * scale;
        contentInsets.left += fontSize * scale;
        contentInsets.right += fontSize * scale;
        contentInsets = YYTextUIEdgeInsetPixelFloor(contentInsets);
        attachment.contentInsets = contentInsets;
    }
    
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:YYTextAttachmentToken];
    [atr yy_setTextAttachment:attachment range:NSMakeRange(0, atr.length)];
    CTRunDelegateRef ctDelegate = delegate.CTRunDelegate;
    [atr yy_setRunDelegate:ctDelegate range:NSMakeRange(0, atr.length)];
    if (ctDelegate) CFRelease(ctDelegate);
    
    return atr;
}


- (NSRegularExpression *)regexTopic {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"#[^@#]+?#" options:kNilOptions error:NULL];
    });
    return regex;
}


@end
