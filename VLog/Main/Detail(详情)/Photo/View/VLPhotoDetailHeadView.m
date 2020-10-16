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


static CGFloat const SpaceValue = 10;
static CGFloat const TopViewHeight = 450;
static CGFloat const TitleLabelHeight = 40;
static CGFloat const TopicButtonHeight = 30;

@interface VLPhotoDetailHeadView ()<SDCycleScrollViewDelegate>

KProStrongType(SDCycleScrollView,cycleScrollView);
KProStrongType(NSArray,imageArrays);
KProStrongType(YYLabel,titleLabel);
KProStrongType(UIButton,topicButton);
KProStrongType(UIView,bgView);
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
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.bgView.backgroundColor = kWhiteColor;
    [self addSubview:self.bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SpaceValue);
        make.top.equalTo(self).offset(TopViewHeight+SpaceValue);
        make.right.equalTo(self).offset(-SpaceValue);
        make.bottom.equalTo(self).offset(-SpaceValue);
    }];
    
    [self.bgView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.bgView);
        make.height.equalTo(@(TitleLabelHeight));
    }];
    
    [self.bgView addSubview:self.topicButton];
    [_topicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self.bgView);
        make.height.equalTo(@(TopicButtonHeight));
    }];
    
    [self.bgView addSubview:self.tagLabel];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topicButton.mas_bottom);
        make.left.right.equalTo(self.bgView);
    }];
    
    [self.bgView addSubview:self.detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLabel.mas_bottom).offset(SpaceValue);
        make.left.right.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-SpaceValue);
    }];
    
//    _detailLabel.alpha = 0;
//    _detailLabel.transform = CGAffineTransformMakeTranslation(0, 50);
    self.bgView.alpha = 0;
    self.bgView.transform = CGAffineTransformMakeTranslation(0, 50);
    NCWeakSelf(self);
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseInOut animations:^{
        weakself.bgView.alpha = 1;
        weakself.bgView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setInfo:(VLPhotoDetailResponse *)dataModel{
    self.titleLabel.attributedText = [self appendAttributedString:dataModel.video_info.video_title font:kFontBBig];
    NSAttributedString *detailLabelAText =[self appendAttributedString:dataModel.video_info.video_desc font:kFontBMedium];
    self.detailLabel.attributedText = detailLabelAText;
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
        [text appendAttributedString:[weakself appendTagAttributedStringWithInfoModel:obj]];
    }];
    self.tagLabel.attributedText = text;
    
    CGFloat detailLabelHeight = [self getTextHeight:detailLabelAText andLabel:self.detailLabel];
    CGFloat tagLabelHeight = [self getTextHeight:text andLabel:self.tagLabel];
    
    self.frame = CGRectMake(0, 0,self.superview.jk_width , TopViewHeight+10+TitleLabelHeight+10+TopicButtonHeight+10+tagLabelHeight+10+detailLabelHeight+10);
    
    
}

-(CGFloat)getTextHeight:(NSAttributedString *)text andLabel:(YYLabel *)lable
{
    CGSize introSize = CGSizeMake(self.jk_width-10, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:text];
    lable.textLayout = layout;
    CGFloat introHeight = layout.textBoundingSize.height;
    return introHeight;
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

- (NSAttributedString *)appendTagAttributedStringWithInfoModel:(VLDetail_TagListResponse *)infoModel{
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIImage *image = [UIImage imageNamed:@"publish_tag_icon"];
    NSMutableAttributedString *attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:kFontBSmall alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString: attachment];
    
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:infoModel.tag_text];
        one.yy_font = kFontBMedium;
        one.yy_color = kBuleColor;
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.0 alpha:0.5];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.yy_textShadow = shadow;
    
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
        NCWeakSelf(self);
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//            [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
            [weakself actiondidTagClickWithInfoModel:infoModel];
        };
        [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
        
        [text appendAttributedString:one];
        [text appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"  "]];
    }
    return text;
}

- (void)actiondidTagClickWithInfoModel:(VLDetail_TagListResponse *)infoModel{
    
    
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
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.jk_width, TopViewHeight) delegate:self placeholderImage:[UIImage new]];
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
//        _titleLabel.alpha = 0;
//        _titleLabel.transform = CGAffineTransformMakeTranslation(0, 50);
        
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
        kViewRadius(_topicButton, TopicButtonHeight/2);
        _topicButton.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.8];
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
