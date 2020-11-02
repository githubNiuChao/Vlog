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
        _titleImageView.image = kNameImage(@"5.jpg");
        kViewRadius(_titleImageView, 25);
    }
    return _titleImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontBMedium;
        _titleLabel.text = @"龙龙 收藏了你的笔记";
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLabel.textColor = kGreyColor;
        _subTitleLabel.font = kFontBSmall;
        _subTitleLabel.text = @"刚刚";
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

//- (void)setLieModel:(VLMessageLikeResponse *)lieModel{
//    
//}
//
//- (void)setFollowModel:(VLMessageFansResponse *)followModel{
//    
//    
//}
@end
