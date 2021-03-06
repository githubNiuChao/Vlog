//
//  VLUserHomeFansTableViewCell.m
//  VLog
//
//  Created by szy on 2020/11/2.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLUserHomeFansTableViewCell.h"


@interface VLUserHomeFansTableViewCell ()

KProStrongType(UIImageView, titleImageView)
KProStrongType(UILabel, titleLabel)
KProStrongType(UILabel, subTitleLabel)

@end

@implementation VLUserHomeFansTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}


- (void)initSubView{
    [self.contentView addSubview:self.titleImageView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView.mas_right).offset(5);
        make.top.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.titleLabel);
    }];
    
    
    [self.contentView addSubview:self.followButton];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).inset(15);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 25));
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel);
        make.height.equalTo(@0.5);
    }];
}

- (UIImageView *)titleImageView{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        kViewRadius(_titleImageView, 25);
    }
    return _titleImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontBBig;
        _titleLabel.text = @"";
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLabel.textColor = kGreyColor;
        _subTitleLabel.font = kFontBSmall;
        _subTitleLabel.text = @"";
    }
    return _subTitleLabel;
}

- (UIButton *)followButton{
    
    if (!_followButton) {
        _followButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_followButton setTitle:@"回粉" forState:UIControlStateNormal];
        [_followButton setTitle:@"已关注" forState:UIControlStateSelected];
        _followButton.titleLabel.font = kFontBSmall;
        [_followButton setTitleColor:kCOLOR_THEME forState:UIControlStateNormal];
        [_followButton setTitleColor:kGreyColor forState:UIControlStateSelected];
        kViewBorderRadius(_followButton, 12.5, 1.0, kCOLOR_THEME);
        
        [_followButton addTarget:self action:@selector(followClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followButton;
}

- (void)followClicked :(UIButton *)button{
    _followButton.selected = !button.selected;
    
    if (_followButton.selected) {
        kViewBorderRadius(_followButton, 12.5, 1.0, kGreyColor);
    }else{
        kViewBorderRadius(_followButton, 12.5, 1.0, kCOLOR_THEME);
    }
    VLFollowUnFollowRequest *request = [[VLFollowUnFollowRequest alloc] init];
    request.isFolleow = !_followButton.selected;
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
    }];
    
}
//关注列表
- (void)setFollowModel:(VLUserHomeFansListModel *)followModel{
    _followModel = followModel;
    self.followButton.selected = YES;
    if (_followButton.selected) {
        kViewBorderRadius(_followButton, 12.5, 1.0, kGreyColor);
    }else{
        kViewBorderRadius(_followButton, 12.5, 1.0, kCOLOR_THEME);
    }
    
    if (followModel.nickname.length) {
        self.titleLabel.text = followModel.nickname;
    }else{
        self.titleLabel.text = followModel.user_name;
    }
    
    self.subTitleLabel.text = [NSString stringWithFormat:@"笔记·%@ | 粉丝·%@",followModel.video_count,followModel.fans_count];
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:followModel.headimg] placeholderImage:[UIImage jk_imageWithColor:kOrangeColor]];
}


- (void)setFansModel:(VLUserHomeFansListModel *)fansModel{
    _fansModel = fansModel;
    self.followButton.selected = fansModel.is_follow;
    if (_followButton.selected) {
        kViewBorderRadius(_followButton, 12.5, 1.0, kGreyColor);
    }else{
        kViewBorderRadius(_followButton, 12.5, 1.0, kCOLOR_THEME);
    }
    
    if (fansModel.nickname.length) {
        self.titleLabel.text = fansModel.nickname;
    }else{
        self.titleLabel.text = fansModel.user_name;
    }

    self.subTitleLabel.text = [NSString stringWithFormat:@"笔记·%@ | 粉丝·%@",fansModel.video_count,fansModel.fans_count];
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:fansModel.headimg] placeholderImage:[UIImage jk_imageWithColor:kOrangeColor]];
    
}


//- (void)setLieModel:(VLMessageLikeResponse *)lieModel{
//    
//}
//
//- (void)setFollowModel:(VLMessageFansResponse *)followModel{
//    
//    
//}
@end
