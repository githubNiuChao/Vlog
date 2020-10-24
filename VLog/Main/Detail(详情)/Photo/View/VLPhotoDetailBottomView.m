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

@end

@implementation VLPhotoDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setupView];
    }
    return self;
}

- (void)setupView{
 
    [self addSubview:self.textBGButton];
    [self.textBGButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 30));
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
        make.right.equalTo(self.textBGButton).offset(-5);
        make.centerY.equalTo(self.textBGButton);
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
        [_likeButton setImage:kNameImage(@"") forState:UIControlStateNormal];
        [_likeButton setTitle:@"000" forState:UIControlStateNormal];
        _likeButton.titleLabel.font = kFontBSmall;
    }
    return _likeButton;
}




@end
