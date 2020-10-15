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
#import "VLVideoInfoModel.h"
#import "VLIndexResponse.h"


static CGFloat const TopViewHeitgh = 450;

@interface VLPhotoDetailHeadView ()<SDCycleScrollViewDelegate>

KProStrongType(SDCycleScrollView,cycleScrollView);
KProStrongType(NSArray,imageArrays);
KProStrongType(YYLabel,titleLabel);
KProStrongType(UIButton,topicButton);
KProStrongType(UIView,tagView);
KProStrongType(YYLabel,tagLabel);
KProStrongType(YYLabel,detailLabel);

@end

@implementation VLPhotoDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
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
        make.top.equalTo(self).offset(TopViewHeitgh+10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@40);
    }];
    
    [self addSubview:self.topicButton];
    [_topicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.equalTo(@30);
    }];
    
    [self addSubview:self.tagLabel];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.topicButton.mas_bottom);
    }];
    
    [self addSubview:self.detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLabel.mas_bottom).offset(10);
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

- (void)setInfo:(VLPhotoDetailResponse *)dataModel{
    self.titleLabel.attributedText = [self appendAttributedString:dataModel.video_info.video_title font:kFontBBig];
    self.detailLabel.attributedText =  [self appendAttributedString:dataModel.video_info.video_desc font:kFontBMedium];
    [self.topicButton setTitle:[NSString stringWithFormat:@"%@ ",dataModel.video_cat_info.cat_name] forState:UIControlStateNormal];
    
    NSMutableArray<VLDetail_TagListResponse*> *muArray = [[NSMutableArray alloc]init];
    [dataModel.tag_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (VLDetail_TagListResponse *tagmModel in obj) {
            [muArray addObject:tagmModel];
        }
    }];
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    NCWeakSelf(self);
    [muArray enumerateObjectsUsingBlock:^(VLDetail_TagListResponse * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [text appendAttributedString:[weakself appendTagAttributedString:obj.tag_text]];
    }];
    self.tagLabel.attributedText = text;
}

- (NSAttributedString *)appendAttributedString:(NSString *)string font:(UIFont *)font{
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:string];
        one.yy_font = font;
        one.yy_color = kBlackColor;
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.5];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.yy_textShadow = shadow;
        [text appendAttributedString:one];
    }
    return text;
}

- (NSAttributedString *)appendTagAttributedString:(NSString *)string{
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIImage *image = [UIImage imageNamed:@"publish_tag_icon"];
    NSMutableAttributedString *attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:kFontBSmall alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString: attachment];
    
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:string];
        one.yy_font = kFontBMedium;
        one.yy_color = kBuleColor;
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.0 alpha:0.5];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.yy_textShadow = shadow;
    
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//            [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        };
        [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
        
        [text appendAttributedString:one];
        [text appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"  "]];
    }
    return text;
}


- (YYLabel *)tagLabel{
    if (!_tagLabel) {
        _tagLabel = [[YYLabel alloc] init];
         _tagLabel.textColor = kBlackColor;
         _tagLabel.font = kFontBSmall;
         _tagLabel.backgroundColor = kWhiteColor;
         _tagLabel.textAlignment = NSTextAlignmentLeft;
         _tagLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
         _tagLabel.numberOfLines = 0;
    }
    return _tagLabel;
}


- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.jk_width, TopViewHeitgh) delegate:self placeholderImage:[UIImage new]];
        _cycleScrollView.autoScroll = NO;
        kViewRadius(_cycleScrollView, 5);
        _cycleScrollView.imageURLStringsGroup = self.imageArrays;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleScrollView.currentPageDotColor = kWhiteColor;
        _cycleScrollView.pageDotColor = kWhiteColor;
        _cycleScrollView.backgroundColor = kWhiteColor;
    }
    return _cycleScrollView;
}

- (YYLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[YYLabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontBBig;
        _titleLabel.backgroundColor = kWhiteColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"";
        _titleLabel.alpha = 0;
        _titleLabel.transform = CGAffineTransformMakeTranslation(0, 50);
        
    }
    return _titleLabel;
}
- (YYLabel *)detailLabel{
    
    if (!_detailLabel) {
        _detailLabel = [[YYLabel alloc] init];
        _detailLabel.textColor = kBlackColor;
        _detailLabel.font = kFontBMedium;
        _detailLabel.backgroundColor = kWhiteColor;
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (UIButton *)topicButton{
    if (!_topicButton) {
        _topicButton = [[UIButton alloc] initWithFrame:CGRectZero];
        kViewRadius(_topicButton, 15);
        //        [_topicButton jk_setImagePosition:LXMImagePositionLeft spacing:1.0];
        _topicButton.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        [_topicButton setImage:kNameImage(@"detail_topic_icon") forState:UIControlStateNormal];
        [_topicButton setTitle:@"" forState:UIControlStateNormal];
        [_topicButton setTitleColor:kBuleColor forState:UIControlStateNormal];
        [_topicButton setImageEdgeInsets:UIEdgeInsetsMake(5,0,5,0)];
        _topicButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _topicButton.titleLabel.font = kFontBMedium;
    }
    return _topicButton;
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
