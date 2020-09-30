//
//  PersonListCollectionViewCell.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/7/14.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "PersonListCollectionViewCell.h"

@interface PersonListCollectionViewCell()

KProStrongType(UIImageView, videoIcon);//视频标志
KProStrongType(UILabel, lblHobby);//标题
KProStrongType(UIImageView, imgHead);//头像
KProStrongType(UILabel, lblNickName);//昵称
KProStrongType(UIButton, like);//喜欢
KProStrongType(UIView, line);//分割线

//@property (strong, nonatomic) UILabel *juli;//距离

@end
@implementation PersonListCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor= [UIColor whiteColor];
        
        kViewRadius(self, 5);
        _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-20)];
        _imgView.contentMode=UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds=YES;
        _imgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_imgView];
        
        _videoIcon = [[UIImageView alloc] initWithImage:kNameImage(@"home_video_icon")];
        [self addSubview:_videoIcon];
        [_videoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        _lblHobby=[[UILabel alloc]initWithFrame:CGRectMake(10, _imgView.jk_bottom, frame.size.width-20, 20)];
        _lblHobby.numberOfLines=0;
        _lblHobby.textColor=kHexColor(@"1f1f1f");
        _lblHobby.font= kFontBSmall;
        [self addSubview:_lblHobby];

        _line=[[UIView alloc]initWithFrame:CGRectMake(0, _lblHobby.jk_bottom+10, frame.size.width, 0.5)];
        _line.backgroundColor= kSysGroupBGColor;
        [self addSubview:_line];

        _imgHead=[[UIImageView alloc]initWithFrame:CGRectMake(10, _line.jk_bottom+10, 30, 30)];
        kViewRadius(_imgHead, 15);
        _imgHead.contentMode=UIViewContentModeScaleAspectFill;
        _imgHead.clipsToBounds=YES;
        [self addSubview:_imgHead];
        
        _lblNickName=[[UILabel alloc]initWithFrame:CGRectMake(_imgHead.jk_right+5, _imgHead.jk_top+5, 80, 15)];
        _lblNickName.textColor=kBlackColor;
        _lblNickName.font= kFontSmall;
        [self addSubview:_lblNickName];

        _like = [[UIButton alloc]initWithFrame:CGRectZero];
        [_like setImage:kNameImage(@"home_like_n") forState:UIControlStateNormal];
        [_like setImage:kNameImage(@"home_like_s") forState:UIControlStateSelected];
        [_like setTitleColor:kBlackColor forState:UIControlStateNormal];
        [_like addTarget:self action:@selector(likeClicked:) forControlEvents:UIControlEventTouchUpInside];
        _like.titleLabel.font = kFontSmall;
        [self addSubview:_like];
        [_like mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_imgHead);
            make.right.equalTo(self).offset(-10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
//        _lblAge=[[UILabel alloc]initWithFrame:CGRectMake(_lblNickName.jk_left, 0, _lblNickName.jk_right, 15)];
//        _lblAge.textColor=kBlackColor;
//        _lblAge.font=kFontSmall;
//        [self addSubview:_lblAge];

//        _line2=[[UIView alloc]initWithFrame:CGRectMake(0, _imgHead.jk_bottom+10, frame.size.width, 0.5)];
//        _line2.backgroundColor=kSysGroupBGColor;
//        [self addSubview:_line2];

//        _lblFrom=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, frame.size.width-80, 15)];
//        _lblFrom.textColor=kBlackColor;
//        _lblFrom.font=kFontSmall;
//        [self addSubview:_lblFrom];

//        _juli=[[UILabel alloc]initWithFrame:CGRectMake(self.jk_width - 80, 0, 70, 15)];
//        _juli.textAlignment = NSTextAlignmentRight;
//        _juli.textColor=kBlackColor;
//        _juli.font=kFontSmall;
//        [self addSubview:_juli];
    }
    return self;
}

- (void)likeClicked:(UIButton *)button{
    _like.selected = !_like.selected;
    _personModel.islike = _like.selected;
}

-(void)setPersonModel:(VLIndexModel *)personModel{
    _personModel=personModel;
    _imgView.backgroundColor=kWhiteColor;
//    [_imgView sd_setImageWithURL:[NSURL URLWithString:personModel.picture] placeholderImage:[UIImage jk_imageWithColor:KGrayColor]];
//    [_imgHead sd_setImageWithURL:[NSURL URLWithString:personModel.headImg] placeholderImage:[UIImage jk_imageWithColor:KGrayColor]];
    _like.selected = _personModel.islike;
    _videoIcon.hidden = !_personModel.isvideo;
    _lblHobby.text=personModel.hobbys;
    _lblNickName.text=personModel.nickName;
    [_imgHead setImage:[UIImage imageNamed:personModel.picture]];
    [_imgView setImage:[UIImage imageNamed:personModel.picture]];
    
    _imgView.frame=CGRectMake(0, 0, self.jk_width, personModel.imageCacheHeight);
    _lblHobby.frame=CGRectMake(10, _imgView.jk_height+10, self.jk_width-20, personModel.hobbysCacheHeight);
    
    _line.jk_top=_lblHobby.jk_bottom+10;
    _imgHead.jk_top=_line.jk_bottom+10;
    _lblNickName.jk_top=_imgHead.jk_top+5;
}
@end
