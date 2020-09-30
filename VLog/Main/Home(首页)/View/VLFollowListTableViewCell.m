//
//  VLFollowListTableViewCell.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLFollowListTableViewCell.h"


@interface VLFollowListTableViewCell ()

KProStrongType(UIImageView, iconImageView);
KProStrongType(UILabel, nickLabel);
KProStrongType(UILabel, summaryLabel);
KProStrongType(UIButton, followButton);

KProStrongType(NSArray, stackSubViews);
KProStrongType(UIStackView, stackView);
@end

@implementation VLFollowListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    [self addSubview:self.iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self addSubview:self.nickLabel];
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.top.equalTo(self.iconImageView);
        make.width.equalTo (@100);
    }];
    
    [self addSubview:self.summaryLabel];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.top.equalTo(self.nickLabel.mas_bottom);
        make.width.equalTo(@150);
    }];
    
    [self addSubview:self.followButton];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.right.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView).offset(10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self);
    }];
    
}


- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        kViewRadius(_iconImageView, 20);
    }
    return _iconImageView;
}

-(UILabel *)nickLabel{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickLabel.font = kFontBMedium;
        _nickLabel.textColor = kBlackColor;
        _nickLabel.text= @"昵称昵称";
    }
    return _nickLabel;
}

- (UILabel *)summaryLabel{
    if (!_summaryLabel) {
        _summaryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _summaryLabel.font = kFontSmall;
        _summaryLabel.textColor = kGreyColor;
        _summaryLabel.text = @"笔记：111";
    }
    return _nickLabel;
}

- (UIButton *)followButton{
    if (!_followButton) {
        _followButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        [_followButton setTitleColor:kCOLOR_THEME forState:UIControlStateNormal];
        kViewBorderRadius(_followButton, 15, 1.0, kCOLOR_THEME);
        [_followButton addTarget:self action:@selector(followClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followButton;
}


- (UIStackView *)stackView{
    if(!_stackView){
        _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.alignment = UIStackViewAlignmentFill;
        _stackView.distribution = UIStackViewDistributionFillEqually;
    }
    return _stackView;
}

- (void)followClicked:(UIButton *)button{
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end




@implementation StackSubView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setupView{
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = kOrangeColor;
    kViewRadius(_imageView, 5);
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.textColor = kBlackColor;
    _titleLabel.text = @"tttttttttt";
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(_imageView.mas_bottom).offset(10);
        make.bottom.right.equalTo(self).offset(-10);
    }];
    
}
@end
