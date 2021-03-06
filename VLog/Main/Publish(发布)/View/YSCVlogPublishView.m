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

@interface YSCVlogPublishView ()<YYTextViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UIButton *topicButton;
@property (strong, nonatomic) UIButton *loctionButon;
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
        make.height.equalTo(@150);
    }];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectZero];
    line2.backgroundColor = [UIColor systemGroupedBackgroundColor];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleField);
        make.top.equalTo(self.bodyText.mas_bottom).offset(5);
        make.height.equalTo(@0.6);
    }];
    
    UIView *topic = [[UIView alloc] initWithFrame:CGRectZero];
    //        topic.backgroundColor = [UIColor systemGroupedBackgroundColor];
    topic.userInteractionEnabled = YES;
    [self addSubview:topic];
    
    [topic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleField);
        make.top.equalTo(line2.mas_bottom).offset(5);
        make.height.equalTo(@40);
    }];
    [topic jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self actionTopicButtonClicked];
    }];
    {//参与话题
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [leftButton setImage:[UIImage imageNamed:@"publish_topic_s"] forState:UIControlStateNormal];
        [leftButton setTitle:@"参与话题" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftButton.titleLabel.font = kFontBMedium;
        //        [leftButton jk_setImagePosition:LXMImagePositionLeft spacing:5];
        leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(12,0,12,0)];
        leftButton.userInteractionEnabled = NO;
        [topic addSubview:leftButton];
        
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topic);
            make.centerY.equalTo(topic);
            make.size.mas_equalTo(CGSizeMake(100, 45));
        }];
        
        self.topicButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.topicButton  setImage:[UIImage imageNamed:@"common_arrow_right_dark"] forState:UIControlStateNormal];
        [self.topicButton  setTitle:@"选择适当的话题会有更多的赞" forState:UIControlStateNormal];
        [self.topicButton  setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.topicButton .titleLabel.font = kFontBSmall;
        self.topicButton .titleLabel.textAlignment = NSTextAlignmentRight;
        [self.topicButton  jk_setImagePosition:LXMImagePositionRight spacing:10];
        [self.topicButton  addTarget:self action:@selector(actionTopicButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [topic addSubview:self.topicButton ];
        
        [self.topicButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
            make.height.equalTo(@0.6);
        }];
    }
    
    
    UIView *location = [[UIView alloc] initWithFrame:CGRectZero];
    location.userInteractionEnabled = YES;
    [self addSubview:location];
    
    [location mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleField);
        make.top.equalTo(topic.mas_bottom).offset(5);
        make.height.equalTo(@40);
    }];
    {//选择地点
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [leftButton setImage:[UIImage imageNamed:@"publish_location_s"] forState:UIControlStateNormal];
        [leftButton setTitle:@"添加地点" forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftButton.titleLabel.font = kFontBMedium;
        //        [leftButton jk_setImagePosition:LXMImagePositionLeft spacing:5];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(12,0,12,0)];
        leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        leftButton.userInteractionEnabled = NO;
        [location addSubview:leftButton];
        
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(location);
            make.centerY.equalTo(location);
            make.size.mas_equalTo(CGSizeMake(100, 45));
        }];
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [rightButton setImage:[UIImage imageNamed:@"common_arrow_right_dark"] forState:UIControlStateNormal];
        [rightButton setTitle:@"选择准确的地址会用更多的赞" forState:UIControlStateNormal];
        [rightButton setTitleColor:location.backgroundColor forState:UIControlStateNormal];
        rightButton.titleLabel.font = kFontBSmall;
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
            make.height.equalTo(@0.6);
        }];
    }
}

- (void)refreshIndfo:(NSString *)title{
    [self.topicButton setTitle:[NSString stringWithFormat:@"# %@",title] forState:UIControlStateNormal];
    [self.topicButton setTitleColor:kBuleColor forState:UIControlStateNormal];
}


- (void)actionTopicButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didTopicViewClicked)]) {
        [self.delegate didTopicViewClicked];
    }
}

- (void)actionLocationButtonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didLocationViewClicked)]) {
        [self.delegate didLocationViewClicked];
    }
}

- (YYTextView *)bodyText{
    if (!_bodyText) {
        _bodyText = [[YYTextView alloc] initWithFrame:CGRectZero];
        _bodyText.returnKeyType = UIReturnKeyDefault;
        _bodyText.placeholderText = @"添加正文";
        _bodyText.placeholderFont = [UIFont boldSystemFontOfSize:15];
        _bodyText.font = kFontBMedium;
        _bodyText.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1.0];
        _bodyText.layer.cornerRadius = 5.0;
        
        _bodyText.textContainerInset = UIEdgeInsetsMake(15, 5, 15, 5);
        _bodyText.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _bodyText.extraAccessoryViewHeight = 45;
        _bodyText.showsVerticalScrollIndicator = NO;
        _bodyText.alwaysBounceVertical = YES;
        _bodyText.allowsCopyAttributedString = NO;
        _bodyText.textParser = [VLTextViewComposeParser new];
        _bodyText.delegate = self;
    }
    return _bodyText;
}


//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];//取消第一响应者
    return YES;
}
- (UITextField *)titleField{
    if (!_titleField) {
        _titleField = [[UITextField alloc] initWithFrame:CGRectZero];
        _titleField.placeholder = @"填写标题会有更多赞哦";
        _titleField.textColor = [UIColor blackColor];
        _titleField.returnKeyType = UIReturnKeyDone;
//        _titleField.delegate = self;
        _titleField.font = kFontBBig;
    }
    return _titleField;
}

@end
