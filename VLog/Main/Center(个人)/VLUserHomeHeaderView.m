//
//  VLUserHomeHeaderView.m
//  VLog
//
//  Created by szy on 2020/10/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLUserHomeHeaderView.h"

@interface VLUserHomeHeaderView ()
KProStrongType(UIImageView,bottomBackground)
KProStrongType(UIView,bgView)
KProStrongType(UIImageView,avatar)//头像
KProStrongType(UILabel,follow)//关注
KProStrongType(UILabel,fans)//粉丝
KProStrongType(UILabel,like)//喜欢
KProStrongType(UIButton,informationButton)//编辑资料

KProStrongType(UIImageView,sexImageView)//性别
KProStrongType(UIButton,cityButton)//城市
KProStrongType(UIButton,sexButton)//性别
KProStrongType(UIButton,rankButton)//会员

KProStrongType(UILabel,descLabel)//标签

@end

@implementation VLUserHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.bottomBackground = [[UIImageView alloc] initWithFrame:self.frame];
    self.bottomBackground.contentMode = UIViewContentModeScaleAspectFill;
    self.bottomBackground.layer.masksToBounds = YES;
    [self.bottomBackground setImage:[UIImage imageNamed:@"5.jpg"]];
    [self addSubview:self.bottomBackground];

    UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualEffectView.frame = self.bottomBackground.bounds;
    visualEffectView.alpha = 0.95;
    [self.bottomBackground addSubview:visualEffectView];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.bgView.backgroundColor = kOrangeColor;
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    [self.bgView addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(20);
        make.left.equalTo(self.bgView).offset(15);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    UIStackView *stackBgView = [[UIStackView alloc] initWithFrame:CGRectZero];
    stackBgView.axis = UILayoutConstraintAxisHorizontal;
    stackBgView.distribution = UIStackViewDistributionFillEqually;
    stackBgView.spacing = 5;
    stackBgView.alignment = UIStackViewAlignmentFill;
    [self.bgView addSubview:stackBgView];
    [stackBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar);
        make.right.equalTo(self.bgView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(250, 40));
    }];
    [stackBgView addArrangedSubview:[self setupViewWithLabel:self.follow infoText:@"关注" actionTag:VLUserHomeHeaderFollowTag]];
    [stackBgView addArrangedSubview:[self setupViewWithLabel:self.fans infoText:@"粉丝" actionTag:VLUserHomeHeaderFansTag]];
    [stackBgView addArrangedSubview:[self setupViewWithLabel:self.like infoText:@"获赞与收藏" actionTag:VLUserHomeHeaderLikeTag]];
    
    [self.bgView addSubview:self.informationButton];
    [self.informationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stackBgView.mas_bottom).offset(10);
        make.centerX.equalTo(stackBgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    [self.bgView addSubview:self.sexImageView];
    [self.sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_left);
        make.top.equalTo(self.avatar.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    [self setupSeparateViewWithView:self.sexImageView];
    
    [self.bgView addSubview:self.cityButton];
    [self.cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (self.sexImageView.mas_right).offset(10);
        make.centerY.equalTo(self.sexImageView);
    }];
    
    [self setupSeparateViewWithView:self.cityButton];
    
    [self.bgView addSubview:self.sexButton];
     [self.sexButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo (self.cityButton.mas_right).offset(10);
         make.centerY.equalTo(self.sexImageView);
     }];
     
     [self setupSeparateViewWithView:self.sexButton];
    
    [self.bgView addSubview:self.rankButton];
    [self.rankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (self.sexButton.mas_right).offset(10);
        make.centerY.equalTo(self.sexImageView);
    }];

    [self setupSeparateViewWithView:self.rankButton];
    
    [self.bgView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_left);
        make.top.equalTo(self.sexImageView.mas_bottom).offset(20);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
    }];
}

- (void)onTapAction:(UITapGestureRecognizer *)sender {
    if(self.delegate) {
        [self.delegate onUserActionTap:sender.view.tag];
    }
}

- (UIView *)setupSeparateViewWithView:(UIView *)view{
    UIView *separateView = [[UIView alloc] initWithFrame:CGRectZero];
    separateView.backgroundColor = kSysGroupBGColor;
    [self.bgView addSubview:separateView];
    [separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_right).offset(5);
        make.centerY.equalTo(self.sexImageView);
        make.size.mas_equalTo(CGSizeMake(1.0, 15));
    }];
    return separateView;
}


- (UIView *)setupViewWithLabel:(UILabel *)label infoText:(NSString *)text actionTag:(NSInteger)tag{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = kFontBBig;
    label.text = @"88";
    label.textColor = kColorBlackAlpha80;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view);
    }];
    UILabel *infoTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    infoTextLabel.textAlignment = NSTextAlignmentCenter;
    infoTextLabel.font = kFontBSmall;
    infoTextLabel.text = text;
    infoTextLabel.textColor = kColorBlackAlpha80;
    [view addSubview:infoTextLabel];
    [infoTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(view);
    }];
    
    view.tag = tag;
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)]];
    return view;
}



- (UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] initWithFrame:CGRectZero];
        kViewRadius(_avatar, 45);
        _avatar.image = kNameImage(@"img_find_default");
    }
    return _avatar;
}

- (UIButton *)informationButton{
    if (!_informationButton) {
        _informationButton = [[UIButton alloc] initWithFrame:CGRectZero];
        kViewBorderRadius(_informationButton, 15, 1.0, kSysGroupBGColor);
        [_informationButton setTitle:@"编辑资料" forState:UIControlStateNormal];
        [_informationButton setTitleColor:kColorBlackAlpha80 forState:UIControlStateNormal];
//        [_informationButton addTarget:self action:@selector(actionPublish:) forControlEvents:UIControlEventTouchUpInside];
        _informationButton.titleLabel.font = kFontBMedium;
        _informationButton.tag = VLUserHomeHeaderSettingTag;
        [_informationButton addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)]];
    }
    return _informationButton;
}

- (UIImageView *)sexImageView{
    if (!_sexImageView) {
        _sexImageView = [[UIImageView alloc] initWithImage: kNameImage(@"user_sex_girl")];
    }
    return _sexImageView;
}

- (UIButton *)cityButton{
    if (!_cityButton) {
        _cityButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cityButton setImage:kNameImage(@"user_city_icon") forState:UIControlStateNormal];
        [_cityButton setTitleColor:kColorBlackAlpha80 forState:UIControlStateNormal];
        [_cityButton setTitle:@"黑龙江 哈尔滨" forState:UIControlStateNormal];
        [_cityButton setImageEdgeInsets:UIEdgeInsetsMake(5,0,5,0)];
        _cityButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _cityButton.titleLabel.font = kFontBSmall;
        
    }
    return _cityButton;
}

- (UIButton *)sexButton{
    if (!_sexButton) {
        _sexButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_sexButton setImage:kNameImage(@"user_sex_girl") forState:UIControlStateNormal];
        [_sexButton setTitleColor:kColorBlackAlpha80 forState:UIControlStateNormal];
        [_sexButton setTitle:@"女" forState:UIControlStateNormal];
        [_sexButton setImageEdgeInsets:UIEdgeInsetsMake(5,0,5,0)];
        _sexButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _sexButton.titleLabel.font = kFontBSmall;
    }
    return _sexButton;
}

- (UIButton *)rankButton{
    if (!_rankButton) {
        _rankButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_rankButton setImage:kNameImage(@"user_rank_icon") forState:UIControlStateNormal];
        [_rankButton setTitleColor:kColorBlackAlpha80 forState:UIControlStateNormal];
        [_rankButton setTitle:@"银牌会员" forState:UIControlStateNormal];
        [_rankButton setImageEdgeInsets:UIEdgeInsetsMake(5,0,5,0)];
        _rankButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _rankButton.titleLabel.font = kFontBSmall;
    }
    return _rankButton;
}


- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.text = @"本宝宝暂时还没想到个性的签名";
        _descLabel.font = kFontMedium;
        _descLabel.textColor = kColorBlackAlpha80;
    }
    return _descLabel;
}




@end
