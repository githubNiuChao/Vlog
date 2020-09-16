//
//  PersonListCollectionViewCell.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/7/14.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "PersonListCollectionViewCell.h"

@interface PersonListCollectionViewCell()

@property (strong, nonatomic) UILabel *lblHobby;//爱好
@property (strong, nonatomic) UIImageView *imgHead;//头像
@property (strong, nonatomic) UILabel *lblNickName;//昵称
@property (strong, nonatomic) UILabel *lblAge;//年龄
@property (strong, nonatomic) UILabel *lblFrom;//来自哪里
@property (strong, nonatomic) UILabel *juli;//距离
@property (strong, nonatomic) UIView *line1;//线1
@property (strong, nonatomic) UIView *line2;//线2

@end
@implementation PersonListCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor= [UIColor whiteColor];
        ViewRadius(self, 5);
        NSLog(@"-------");
        _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-20)];
        _imgView.contentMode=UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds=YES;
        _imgView.backgroundColor=[UIColor whiteColor];
        //        _imgView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:_imgView];
        _lblHobby=[[UILabel alloc]initWithFrame:CGRectMake(10, _imgView.jk_bottom, frame.size.width-20, 20)];
        _lblHobby.numberOfLines=0;
        _lblHobby.textColor=[UIColor jk_colorWithHexString:@"1f1f1f"];
        _lblHobby.font=FFont1;
        [self addSubview:_lblHobby];
        
        _line1=[[UIView alloc]initWithFrame:CGRectMake(0, _lblHobby.jk_bottom+10, frame.size.width, 0.5)];
        _line1.backgroundColor=CLineColor;
        [self addSubview:_line1];
        
        _imgHead=[[UIImageView alloc]initWithFrame:CGRectMake(10, _line1.jk_bottom+10, 30, 30)];
        ViewRadius(_imgHead, 15);
        
        _imgHead.contentMode=UIViewContentModeScaleAspectFill;
        _imgHead.clipsToBounds=YES;
        _imgHead.backgroundColor=CViewBgColor;
        [self addSubview:_imgHead];
        
        _lblNickName=[[UILabel alloc]initWithFrame:CGRectMake(_imgHead.jk_right+5, _imgHead.jk_top+5, self.jk_width-_imgHead.jk_right-20, 15)];
        _lblNickName.textColor=KBlackColor;
        _lblNickName.font=FFont1;
        [self addSubview:_lblNickName];
        
        _lblAge=[[UILabel alloc]initWithFrame:CGRectMake(_lblNickName.jk_left, 0, _lblNickName.jk_right, 15)];
        _lblAge.textColor=CFontColor1;
        _lblAge.font=FFont1;
        [self addSubview:_lblAge];
        
        _line2=[[UIView alloc]initWithFrame:CGRectMake(0, _imgHead.jk_bottom+10, frame.size.width, 0.5)];
        _line2.backgroundColor=CLineColor;
        [self addSubview:_line2];
        
        _lblFrom=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, frame.size.width-80, 15)];
        _lblFrom.textColor=CFontColor2;
        _lblFrom.font=FFont1;
        [self addSubview:_lblFrom];
        
        _juli=[[UILabel alloc]initWithFrame:CGRectMake(self.jk_width - 80, 0, 70, 15)];
        _juli.textAlignment = NSTextAlignmentRight;
        _juli.textColor=CFontColor2;
        _juli.font=FFont1;
        [self addSubview:_juli];
    }
    return self;
}
-(void)setPersonModel:(PersonModel *)personModel{
    _personModel=personModel;
//    _imgView.backgroundColor=[UIColor colorWithHexString:personModel.imageAve];
    _imgView.backgroundColor=KWhiteColor;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:personModel.picture] placeholderImage:[UIImage jk_imageWithColor:KGrayColor]];
    _lblHobby.text=personModel.hobbys;
    [_imgHead sd_setImageWithURL:[NSURL URLWithString:personModel.headImg] placeholderImage:[UIImage jk_imageWithColor:KGrayColor]];
    _lblNickName.text=personModel.nickName;
    _lblAge.text=personModel.age;
    _lblFrom.text=personModel.city;
    _juli.text = personModel.juli;

    CGFloat itemH = personModel.height * self.jk_width / personModel.width;
    _imgView.frame=CGRectMake(0, 0, self.frame.size.width, itemH);

    _lblHobby.frame=CGRectMake(10, _imgView.jk_bottom+10, self.frame.size.width-20, personModel.hobbysHeight);

    _line1.jk_top=_lblHobby.jk_bottom+10;
    _imgHead.jk_top=_line1.jk_bottom+10;
    _lblNickName.jk_top=_imgHead.jk_top;
    _lblAge.jk_top=_lblNickName.jk_bottom+2;
    _line2.jk_top=_imgHead.jk_bottom+10;
    _lblFrom.jk_top=_line2.jk_bottom+10;
    _juli.jk_top = _lblFrom.jk_top;
}
@end
