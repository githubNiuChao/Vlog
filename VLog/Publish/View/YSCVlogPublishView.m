//
//  YSCVlogPublishView.m
//  VLog
//
//  Created by szy on 2020/9/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "YSCVlogPublishView.h"

#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor jk_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

@interface YSCVlogPublishView ()<YYTextViewDelegate>

@property (strong, nonatomic) UITextField *titleField;
@property (strong, nonatomic) YYTextView *bodyText;


@end


@implementation YSCVlogPublishView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    [self addSubview:self.titleField];
    [self addSubview:self.bodyText];
    
    [self.titleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(10);
        make.height.equalTo(@50);
    }];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectZero];
    line1.backgroundColor = [UIColor systemGroupedBackgroundColor];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleField);
        make.top.equalTo(self.titleField.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    
    [self.bodyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleField);
        make.top.equalTo(line1.mas_bottom).offset(5);
        make.height.equalTo(@200);
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectZero];
    line2.backgroundColor = [UIColor systemGroupedBackgroundColor];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleField);
        make.top.equalTo(self.bodyText.mas_bottom).offset(5);
        make.height.equalTo(@0.5);
    }];
    
        UIView *topic = [[UIView alloc] initWithFrame:CGRectZero];
        topic.backgroundColor = [UIColor systemGroupedBackgroundColor];
        [self addSubview:topic];
        
        [topic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleField);
            make.top.equalTo(line2.mas_bottom).offset(5);
            make.height.equalTo(@50);
        }];
    {//参与话题
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [leftButton setImage:[UIImage imageNamed:@"hx_original_selected_wx"] forState:UIControlStateNormal];
        [leftButton setTitle:@"参与话题" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        [leftButton jk_setImagePosition:LXMImagePositionLeft spacing:5];
        leftButton.userInteractionEnabled = NO;
        [topic addSubview:leftButton];
        
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topic);
            make.centerY.equalTo(topic);
            make.size.mas_equalTo(CGSizeMake(120, 45));
        }];
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [rightButton setImage:[UIImage imageNamed:@"hx_original_selected_wx"] forState:UIControlStateNormal];
        [rightButton setTitle:@"选择适当的话题会用更多的赞" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [rightButton jk_setImagePosition:LXMImagePositionRight spacing:10];
        [rightButton addTarget:self action:@selector(actionTopicButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [topic addSubview:rightButton];

        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topic);
            make.centerY.equalTo (topic);
            make.height.equalTo(@45);
        }];
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectZero];
        line3.backgroundColor = [UIColor systemGroupedBackgroundColor];
        [topic addSubview:line3];
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.right.equalTo(self.titleField);
          make.top.equalTo(topic.mas_bottom).offset(5);
          make.height.equalTo(@0.5);
        }];
    }
    
    
        UIView *location = [[UIView alloc] initWithFrame:CGRectZero];
        location.backgroundColor = [UIColor systemGroupedBackgroundColor];
        [self addSubview:location];
        
        [location mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleField);
            make.top.equalTo(topic.mas_bottom).offset(5);
            make.height.equalTo(@50);
        }];
    {//选择地点
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [leftButton setImage:[UIImage imageNamed:@"hx_original_selected_wx"] forState:UIControlStateNormal];
        [leftButton setTitle:@"添加地点" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        [leftButton jk_setImagePosition:LXMImagePositionLeft spacing:5];
        leftButton.userInteractionEnabled = NO;
        [location addSubview:leftButton];
        
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(location);
            make.centerY.equalTo(location);
            make.size.mas_equalTo(CGSizeMake(120, 45));
        }];
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [rightButton setImage:[UIImage imageNamed:@"hx_original_selected_wx"] forState:UIControlStateNormal];
        [rightButton setTitle:@"选择准确的地址会用更多的赞" forState:UIControlStateNormal];
        [rightButton setTitleColor:location.backgroundColor forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [rightButton jk_setImagePosition:LXMImagePositionRight spacing:10];
        [rightButton addTarget:self action:@selector(actionLocationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [location addSubview:rightButton];

        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(location);
            make.centerY.equalTo (location);
            make.height.equalTo(@45);
        }];
        
        UIView *line4 = [[UIView alloc] initWithFrame:CGRectZero];
        line4.backgroundColor = [UIColor systemGroupedBackgroundColor];
        [location addSubview:line4];
        [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.right.equalTo(self.titleField);
          make.top.equalTo(location.mas_bottom).offset(5);
          make.height.equalTo(@0.5);
        }];
    }
}


- (void)actionTopicButtonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(publishView:didTopicButtonClicked:)]) {
        [self.delegate publishView:self didTopicButtonClicked:button];
    }
}

- (void)actionLocationButtonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(publishView:didLocationButtonClicked:)]) {
        [self.delegate publishView:self didLocationButtonClicked:button];
    }
}

- (YYTextView *)bodyText{
    if (!_bodyText) {
        _bodyText = [[YYTextView alloc] initWithFrame:CGRectZero];
        _bodyText.placeholderText = @"添加正文";
        _bodyText.placeholderFont = [UIFont boldSystemFontOfSize:17];
        _bodyText.font = [UIFont systemFontOfSize:17];
        _bodyText.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
//
//        NSMutableAttributedString *text = [NSMutableAttributedString new];
//        NSArray *tags = @[@"◉red", @"◉orange", @"◉yellow", @"◉green", @"◉blue", @"◉purple", @"◉gray"];
//        NSArray *tagStrokeColors = @[
//            UIColorHex(fa3f39),
//            UIColorHex(f48f25),
//            UIColorHex(f1c02c),
//            UIColorHex(54bc2e),
//            UIColorHex(29a9ee),
//            UIColorHex(c171d8),
//            UIColorHex(818e91)
//        ];
//        NSArray *tagFillColors = @[
//            UIColorHex(fb6560),
//            UIColorHex(f6a550),
//            UIColorHex(f3cc56),
//            UIColorHex(76c957),
//            UIColorHex(53baf1),
//            UIColorHex(cd8ddf),
//            UIColorHex(a4a4a7)
//        ];
//
//        UIFont *font = [UIFont boldSystemFontOfSize:16];
//        for (int i = 0; i < tags.count; i++) {
//            NSString *tag = tags[i];
//            UIColor *tagStrokeColor = tagStrokeColors[i];
//            UIColor *tagFillColor = tagFillColors[i];
//            NSMutableAttributedString *tagText = [[NSMutableAttributedString alloc] initWithString:tag];
//            [tagText yy_insertString:@"   " atIndex:0];
//            [tagText yy_appendString:@"   "];
//            tagText.yy_font = font;
//            tagText.yy_color = [UIColor whiteColor];
//            [tagText yy_setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:tagText.yy_rangeOfAll];
//
//            YYTextBorder *border = [YYTextBorder new];
//            border.strokeWidth = 1.5;
//            border.strokeColor = tagStrokeColor;
//            border.fillColor = tagFillColor;
//            border.cornerRadius = 100; // a huge value
//            border.lineJoin = kCGLineJoinBevel;
//
//            border.insets = UIEdgeInsetsMake(-2, -5.5, -2, -8);
//            [tagText yy_setTextBackgroundBorder:border range:[tagText.string rangeOfString:tag]];
//
//            [text appendAttributedString:tagText];
//        }
//        text.yy_lineSpacing = 10;
//        text.yy_lineBreakMode = NSLineBreakByWordWrapping;
//
//        [text yy_appendString:@"\n"];
//        [text appendAttributedString:text]; // repeat for test
//
//        _bodyText = [YYTextView new];
//        _bodyText.attributedText = text;
//        _bodyText.textColor = [UIColor blackColor];
//
//        _bodyText.textContainerInset = UIEdgeInsetsMake(10 + 64, 10, 10, 10);
//        _bodyText.allowsCopyAttributedString = YES;
//        _bodyText.allowsPasteAttributedString = YES;
//        _bodyText.delegate = self;
////        if (kiOS7Later) {
////            textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
////        } else {
////            textView.height -= 64;
////        }
//        _bodyText.scrollIndicatorInsets = _bodyText.contentInset;
//        _bodyText.selectedRange = NSMakeRange(text.length, 0);
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [_bodyText becomeFirstResponder];
//        });
    }
 return _bodyText;
}

- (UITextField *)titleField{
    if (!_titleField) {
        _titleField = [[UITextField alloc] initWithFrame:CGRectZero];
        _titleField.placeholder = @"填写标题会有更多赞哦";
        _titleField.textColor = [UIColor blackColor];
        _titleField.font = [UIFont boldSystemFontOfSize:20];
    }
    return _titleField;
}

@end
