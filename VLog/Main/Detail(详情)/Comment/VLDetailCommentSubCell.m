//
//  VLDetailCommentSubCell.m
//  VLog
//
//  Created by szy on 2020/10/19.
//  Copyright © 2020 niuchao. All rights reserved.
//


#import "VLDetailCommentSubCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import <Masonry.h>
#import "VLDetailCommentModel.h"


@interface VLDetailCommentSubCell ()

@property (nonatomic, strong) UIImageView        *avatar;
@property (nonatomic, strong) UIImageView        *likeIcon;
@property (nonatomic, strong) UILabel            *nickName;
@property (nonatomic, strong) UILabel            *extraTag;
@property (nonatomic, strong) UILabel            *content;
@property (nonatomic, strong) UILabel            *likeNum;
@property (nonatomic, strong) UILabel            *date;


@end

@implementation VLDetailCommentSubCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
      [self initSubView];
  }
  
  return self;
}

- (void)initSubView{
      
    _avatar = [[UIImageView alloc] init];
    _avatar.image = [UIImage imageNamed:@"user_avatar_default"];
    _avatar.clipsToBounds = YES;
    _avatar.layer.cornerRadius = 14;
    [self.contentView addSubview:_avatar];
    
    _likeIcon = [[UIImageView alloc] init];
    _likeIcon.image = [UIImage imageNamed:@"home_like_n"];
    [self.contentView addSubview:_likeIcon];
    
    _nickName = [[UILabel alloc] init];
    _nickName.numberOfLines = 1;
    _nickName.textColor = [UIColor blackColor];
    _nickName.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:_nickName];
    _likeNum = [[UILabel alloc] init];
    _likeNum.numberOfLines = 1;
    _likeNum.textColor = [UIColor grayColor];
    _likeNum.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_likeNum];
    
    _content = [[UILabel alloc] init];
    _content.numberOfLines = 0;
    _content.textColor = [UIColor blackColor];
    _content.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_content];
    
    _date = [[UILabel alloc] init];
    _date.numberOfLines = 1;
    _date.textColor = [UIColor grayColor];
    _date.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_date];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatar);
        make.left.equalTo(self.avatar.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-35);
    }];
    
    [_likeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatar);
        make.right.equalTo(self.contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_likeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.likeIcon);
        make.top.equalTo(self.likeIcon.mas_bottom).offset(5);
    }];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickName.mas_bottom).offset(10);
        make.left.right.equalTo(self.nickName);
    }];
    [_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.content.mas_bottom).offset(5);
        make.left.right.equalTo(self.nickName);
    }];
    
    self.hyb_lastViewInCell = self.date;
    self.hyb_bottomOffsetToCell = 0;
    
}


- (void)configCellWithModel:(VLDetailCommentModel*)model {
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.headimg] placeholderImage:[UIImage jk_imageWithColor:kOrangeColor]];
     self.content.text = model.content;
     self.nickName.text= model.nickname;
    self.date.text = [NSDate formatTime:[model.add_time longLongValue]];
    NSString *str;
    if (model.reply_user.length) {
        str = [NSString stringWithFormat:@"回复%@：%@",
                         model.reply_user, model.content];
    }else{
        str = model.content;
    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    if (model.reply_user.length) {
        [text addAttribute:NSForegroundColorAttributeName
                     value:[UIColor orangeColor]
                     range:NSMakeRange(2, model.reply_user.length)];
    }
  self.content.attributedText = text;
}

@end
