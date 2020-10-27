//
//  VLPhotoDetailBottomView.m
//  VLog
//
//  Created by szy on 2020/10/23.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLPhotoDetailBottomView.h"

@interface VLPhotoDetailBottomView ()
KProStrongType(UIButton,textBGButton);
KProStrongType(UIButton,likeButton);
KProStrongType(UIButton,collectButton);
KProStrongType(UIButton,commentButton);

KProStrongType(VLDetailResponse,infoModel);

@end

@implementation VLPhotoDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame infoModel:(VLDetailResponse *)infoModel
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        self.infoModel = infoModel;
        [self setupView];
        
    }
    return self;
}

- (void)setupView{
 
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = kSysGroupBGColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@0.5);
    }];
    
    [self addSubview:self.textBGButton];
    [self.textBGButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:kNameImage(@"")];
    [self.textBGButton addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textBGButton).offset(5);
        make.centerY.equalTo(self.textBGButton);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"说点什么…";
    label.textColor = [UIColor placeholderTextColor];
    label.font = kFontBSmall;
    [self.textBGButton addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textBGButton).offset(10);
        make.centerY.equalTo(self.textBGButton);
    }];
    
    
    CGFloat subWidth = (self.jk_width - 170)/3;
    CGFloat subHeight = self.jk_height-10;
    [self addSubview:self.likeButton];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textBGButton.mas_right).offset(5);
        make.centerY.equalTo(self.textBGButton);
        make.size.mas_equalTo(CGSizeMake(subWidth, subHeight));
        
    }];
    
    [self addSubview:self.collectButton];
    [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeButton.mas_right);
        make.centerY.equalTo(self.textBGButton);
        make.size.mas_equalTo(CGSizeMake(subWidth, subHeight));
        
    }];
    
    [self addSubview:self.commentButton];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectButton.mas_right);
        make.centerY.equalTo(self.textBGButton);
        make.size.mas_equalTo(CGSizeMake(subWidth, subHeight));
    }];
    
    
}
- (UIButton *)textBGButton{
    if (!_textBGButton) {
        _textBGButton = [[UIButton alloc] initWithFrame:CGRectZero];
        kViewRadius(_textBGButton, 15);
        [_textBGButton setBackgroundColor:kSysGroupBGColor];
    }
    return _textBGButton;;
}

- (UIButton *)likeButton{
    if (!_likeButton) {
        _likeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_likeButton setImage:kNameImage(@"detail_like_n") forState:UIControlStateNormal];
        [_likeButton setImage:kNameImage(@"detail_like_s") forState:UIControlStateSelected];
        [_likeButton setTitle:self.infoModel.like_count forState:UIControlStateNormal];
        [_likeButton setTitleColor:kGreyColor forState:UIControlStateNormal];
        _likeButton.selected = self.infoModel.is_like;
        _likeButton.titleLabel.font = kFontBBig;
        [_likeButton jk_setImagePosition:LXMImagePositionLeft spacing:10];
        [_likeButton addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}


- (UIButton *)collectButton{
    if (!_collectButton) {
        _collectButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_collectButton setImage:kNameImage(@"detail_collect_n") forState:UIControlStateNormal];
        [_collectButton setImage:kNameImage(@"detail_collect_s") forState:UIControlStateSelected];
        [_collectButton setTitle:self.infoModel.collection_count forState:UIControlStateNormal];
        [_collectButton setTitleColor:kGreyColor forState:UIControlStateNormal];
        _collectButton.selected = self.infoModel.is_collection;
        _collectButton.titleLabel.font = kFontBBig;
        [_collectButton jk_setImagePosition:LXMImagePositionLeft spacing:10];
        [_collectButton addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectButton;
}

- (UIButton *)commentButton{
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_commentButton setImage:kNameImage(@"detail_comment_icon") forState:UIControlStateNormal];
        [_commentButton setTitle:[NSString stringWithFormat:@"%ld",self.infoModel.comment_list.count] forState:UIControlStateNormal];
         [_commentButton setTitleColor:kGreyColor forState:UIControlStateNormal];
        [_commentButton jk_setImagePosition:LXMImagePositionLeft spacing:10];
        _commentButton.titleLabel.font = kFontBBig;
        [_commentButton setTitleColor:kGreyColor forState:UIControlStateNormal];
    }
    return _commentButton;
}

- (void)collectClick:(UIButton *)button{
    self.collectButton.selected = !button.selected;
    NSInteger count = [self.collectButton.titleLabel.text integerValue];
    count = self.collectButton.selected?(count+1):(count-1);
    [self.collectButton setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
    
    
    
}
- (void)likeClick:(UIButton *)button{
    self.likeButton.selected = !button.selected;
    NSInteger count = [self.likeButton.titleLabel.text integerValue];
       count = self.likeButton.selected?(count+1):(count-1);
       [self.likeButton setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
    
    
    
}

@end
