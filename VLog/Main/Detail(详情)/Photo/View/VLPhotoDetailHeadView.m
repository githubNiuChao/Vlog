//
//  VLPhotoDetailHeadView.m
//  VLog
//
//  Created by szy on 2020/9/28.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPhotoDetailHeadView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import <YYText/YYLabel.h>

@interface VLPhotoDetailHeadView ()<SDCycleScrollViewDelegate>

KProStrongType(SDCycleScrollView, cycleScrollView);
KProStrongType(UILabel, titleLabel);
KProStrongType(YYLabel, detailLabel);

@end

@implementation VLPhotoDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kOrangeColor;
        self.imageArrays = array;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    [self addSubview:self.cycleScrollView];
    //    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.top.right.equalTo(self);
    //        make.width.equalTo(@300);
    //    }];
    
    [self addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(310);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@40);
    }];
    
    [self addSubview:self.detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-40);
    }];
    
    _detailLabel.alpha = 0;
    _detailLabel.transform = CGAffineTransformMakeTranslation(0, 50);
    NCWeakSelf(self);
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseInOut animations:^{
        weakself.titleLabel.alpha = 1;
        weakself.titleLabel.transform = CGAffineTransformIdentity;
        weakself.detailLabel.alpha = 1;
        weakself.detailLabel.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.jk_width, 300) delegate:self placeholderImage:[UIImage new]];
        _cycleScrollView.localizationImageNamesGroup = self.imageArrays;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    }
    return _cycleScrollView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFontBBig;
        _titleLabel.textColor = kBlackColor;
        _titleLabel.text = @"标题标题标题标题标题标题标题标题标题标题标题标题";
        _titleLabel.alpha = 0;
        _titleLabel.transform = CGAffineTransformMakeTranslation(0, 50);
    }
    return _titleLabel;
}
- (YYLabel *)detailLabel{
    
    if (!_detailLabel) {
        
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Shadow"];
            one.yy_font = [UIFont boldSystemFontOfSize:30];
            one.yy_color = [UIColor whiteColor];
            YYTextShadow *shadow = [YYTextShadow new];
            shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
            shadow.offset = CGSizeMake(0, 1);
            shadow.radius = 5;
            one.yy_textShadow = shadow;
            [text appendAttributedString:one];
            [text appendAttributedString:[self padding]];
        }
        
        {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Inner Shadow"];
            one.yy_font = [UIFont boldSystemFontOfSize:30];
            one.yy_color = [UIColor whiteColor];
            YYTextShadow *shadow = [YYTextShadow new];
            shadow.color = [UIColor colorWithWhite:0.000 alpha:0.40];
            shadow.offset = CGSizeMake(0, 1);
            shadow.radius = 1;
            one.yy_textInnerShadow = shadow;
            [text appendAttributedString:one];
            [text appendAttributedString:[self padding]];
        }
        
        {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Multiple Shadows"];
            one.yy_font = [UIFont boldSystemFontOfSize:30];
            one.yy_color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];
            
            YYTextShadow *shadow = [YYTextShadow new];
            shadow.color = [UIColor colorWithWhite:0.000 alpha:0.20];
            shadow.offset = CGSizeMake(0, -1);
            shadow.radius = 1.5;
            YYTextShadow *subShadow = [YYTextShadow new];
            subShadow.color = [UIColor colorWithWhite:1 alpha:0.99];
            subShadow.offset = CGSizeMake(0, 1);
            subShadow.radius = 1.5;
            shadow.subShadow = subShadow;
            one.yy_textShadow = shadow;
            
            YYTextShadow *innerShadow = [YYTextShadow new];
            innerShadow.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
            innerShadow.offset = CGSizeMake(0, 1);
            innerShadow.radius = 1;
            one.yy_textInnerShadow = innerShadow;
            
            [text appendAttributedString:one];
            [text appendAttributedString:[self padding]];
        }
        
        {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Background Image"];
            one.yy_font = [UIFont boldSystemFontOfSize:30];
            one.yy_color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];
            
            //               CGSize size = CGSizeMake(20, 20);
            //               UIImage *background = [UIImage yy_imageWithSize:size drawBlock:^(CGContextRef context) {
            //                   UIColor *c0 = [UIColor colorWithRed:0.054 green:0.879 blue:0.000 alpha:1.000];
            //                   UIColor *c1 = [UIColor colorWithRed:0.869 green:1.000 blue:0.030 alpha:1.000];
            //                   [c0 setFill];
            //                   CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
            //                   [c1 setStroke];
            //                   CGContextSetLineWidth(context, 2);
            //                   for (int i = 0; i < size.width * 2; i+= 4) {
            //                       CGContextMoveToPoint(context, i, -2);
            //                       CGContextAddLineToPoint(context, i - size.height, size.height + 2);
            //                   }
            //                   CGContextStrokePath(context);
            //               }];
            //               one.yy_color = [UIColor colorWithPatternImage:background];
            one.yy_color = [UIColor colorWithPatternImage:[UIImage jk_imageWithColor:[UIColor orangeColor]]];
            
            [text appendAttributedString:one];
            [text appendAttributedString:[self padding]];
        }
        
        {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Border"];
            one.yy_font = [UIFont boldSystemFontOfSize:30];
            one.yy_color = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
            
            YYTextBorder *border = [YYTextBorder new];
            border.strokeColor = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
            border.strokeWidth = 3;
            border.lineStyle = YYTextLineStylePatternCircleDot;
            border.cornerRadius = 3;
            border.insets = UIEdgeInsetsMake(0, -4, 0, -4);
            one.yy_textBackgroundBorder = border;
            
            [text appendAttributedString:[self padding]];
            [text appendAttributedString:one];
            [text appendAttributedString:[self padding]];
            [text appendAttributedString:[self padding]];
            [text appendAttributedString:[self padding]];
            [text appendAttributedString:[self padding]];
        }
        
        {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Link"];
            one.yy_font = [UIFont boldSystemFontOfSize:30];
            one.yy_underlineStyle = NSUnderlineStyleSingle;
            
            /// 1. you can set a highlight with these code
            /*
             one.yy_color = [UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000];
             
             YYTextBorder *border = [YYTextBorder new];
             border.cornerRadius = 3;
             border.insets = UIEdgeInsetsMake(-2, -1, -2, -1);
             border.fillColor = [UIColor colorWithWhite:0.000 alpha:0.220];
             
             YYTextHighlight *highlight = [YYTextHighlight new];
             [highlight setBorder:border];
             highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
             [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
             };
             [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
             */
            
            /// 2. or you can use the convenience method
            [one yy_setTextHighlightRange:one.yy_rangeOfAll
                                    color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                          backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                                tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                [self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
            }];
            
            [text appendAttributedString:one];
            [text appendAttributedString:[self padding]];
        }
        
        {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Another Link"];
            one.yy_font = [UIFont boldSystemFontOfSize:30];
            one.yy_color = [UIColor redColor];
            
            YYTextBorder *border = [YYTextBorder new];
            border.cornerRadius = 50;
            border.insets = UIEdgeInsetsMake(0, -10, 0, -10);
            border.strokeWidth = 0.5;
            border.strokeColor = one.yy_color;
            border.lineStyle = YYTextLineStyleSingle;
            one.yy_textBackgroundBorder = border;
            
            YYTextBorder *highlightBorder = border.copy;
            highlightBorder.strokeWidth = 0;
            highlightBorder.strokeColor = one.yy_color;
            highlightBorder.fillColor = one.yy_color;
            
            YYTextHighlight *highlight = [YYTextHighlight new];
            [highlight setColor:[UIColor whiteColor]];
            [highlight setBackgroundBorder:highlightBorder];
            highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                [self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
            };
            [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
            
            [text appendAttributedString:one];
            [text appendAttributedString:[self padding]];
        }
        
        {
            NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Yet Another Link"];
            one.yy_font = [UIFont boldSystemFontOfSize:30];
            one.yy_color = [UIColor whiteColor];
            
            YYTextShadow *shadow = [YYTextShadow new];
            shadow.color = [UIColor colorWithWhite:0.000 alpha:0.490];
            shadow.offset = CGSizeMake(0, 1);
            shadow.radius = 5;
            one.yy_textShadow = shadow;
            
            YYTextShadow *shadow0 = [YYTextShadow new];
            shadow0.color = [UIColor colorWithWhite:0.000 alpha:0.20];
            shadow0.offset = CGSizeMake(0, -1);
            shadow0.radius = 1.5;
            YYTextShadow *shadow1 = [YYTextShadow new];
            shadow1.color = [UIColor colorWithWhite:1 alpha:0.99];
            shadow1.offset = CGSizeMake(0, 1);
            shadow1.radius = 1.5;
            shadow0.subShadow = shadow1;
            
            YYTextShadow *innerShadow0 = [YYTextShadow new];
            innerShadow0.color = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
            innerShadow0.offset = CGSizeMake(0, 1);
            innerShadow0.radius = 1;
            
            YYTextHighlight *highlight = [YYTextHighlight new];
            [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
            [highlight setShadow:shadow0];
            [highlight setInnerShadow:innerShadow0];
            [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
            
            [text appendAttributedString:one];
        }
        _detailLabel = [[YYLabel alloc] init];
        _detailLabel.attributedText = text;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _detailLabel.numberOfLines = 0;
        _detailLabel.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    }
    return _detailLabel;
}

- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.yy_font = [UIFont systemFontOfSize:4];
    return pad;
}

- (void)showMessage:(NSString *)msg {
    CGFloat padding = 10;
    
    YYLabel *label = [YYLabel new];
    label.text = msg;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.730];
    label.jk_width = self.jk_width;
    label.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    label.jk_height = 80+ 2 * padding;
    
    label.jk_bottom = 64;
    [self addSubview:label];
    [UIView animateWithDuration:0.3 animations:^{
        label.jk_top = 64;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.jk_bottom = 64;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}



@end
