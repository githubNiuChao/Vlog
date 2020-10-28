//
//  VLIndexListCollectionViewCell.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLIndexListCollectionViewCell.h"

@interface VLIndexListCollectionViewCell ()

KProStrongType(UIImageView, videoIcon);//视频标志
KProStrongType(UILabel, lblHobby);//标题
KProStrongType(UIImageView, imgHead);//头像
KProStrongType(UILabel, lblNickName);//昵称
KProStrongType(UIButton, like);//喜欢
KProStrongType(UIView, line);//分割线
KProStrongType(UIButton, locationButton)//距离

//@property (strong, nonatomic) UILabel *juli;//距离

@end
@implementation VLIndexListCollectionViewCell

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
        _lblHobby.textColor=kHexColor(1f1f1f);
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
        
        
        _locationButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_locationButton setImage:kNameImage(@"home_loction_icon") forState:UIControlStateNormal];
        [_locationButton setTitle:@"2KM" forState:UIControlStateNormal];
        [_locationButton setTitleColor:kGreyColor forState:UIControlStateNormal];

        [_locationButton setImageEdgeInsets:UIEdgeInsetsMake(2,0,2,0)];
        [_locationButton jk_setImagePosition:LXMImagePositionLeft spacing:-2];
        _locationButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _locationButton.titleLabel.font = kFontSmall;
        _locationButton.hidden = !self.isLoction;
        [self addSubview:_locationButton];
        [_locationButton sizeToFit];
        [_locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_imgHead);
            make.right.equalTo(self).offset(-5);
            make.height.equalTo(@20);
//            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
    }
    return self;
}

- (void)likeClicked:(UIButton *)button{
    _like.selected = !_like.selected;
    _listModel.is_like = _like.selected;
}

-(void)setListModel:(VLVideoInfoModel *)listModel{
    _listModel = listModel;
    _imgView.backgroundColor=kWhiteColor;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:listModel.video_img] placeholderImage:[UIImage jk_imageWithColor:kOrangeColor]];
    [_imgHead sd_setImageWithURL:[NSURL URLWithString:listModel.headimg] placeholderImage:[UIImage jk_imageWithColor:kOrangeColor]];
    _like.selected = listModel.is_like;
    _videoIcon.hidden = listModel.videoType;
    _lblHobby.text=listModel.video_title;
    _lblNickName.text=listModel.nickname;
    
    _imgView.frame=CGRectMake(0, 0, self.jk_width, listModel.imageCacheHeight);
    _lblHobby.frame=CGRectMake(10, _imgView.jk_height+10, self.jk_width-20, listModel.hobbysCacheHeight);
    _line.jk_top=_lblHobby.jk_bottom+10;
    _imgHead.jk_top=_line.jk_bottom+10;
    _lblNickName.jk_top=_imgHead.jk_top+5;
}
@end
