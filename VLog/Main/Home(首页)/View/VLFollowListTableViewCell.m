//
//  VLFollowListTableViewCell.m
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLFollowListTableViewCell.h"
#import "VLIndexResponse.h"


@implementation StackSubView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setupView{
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = kColorClear;
    kViewRadius(_imageView, 5);
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 5, 40, 5));
    }];
    
    _videoIcon = [[UIImageView alloc] initWithImage:kNameImage(@"home_video_icon")];
    _videoIcon.hidden = YES;
    [self addSubview:_videoIcon];
    [_videoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = kFontBMedium;
    _titleLabel.textColor = kBlackColor;
    _titleLabel.text = @"";
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(_imageView.mas_bottom).offset(10);
        make.bottom.right.equalTo(self).offset(-10);
    }];
    
}
- (void)setVideoModel:(VLVideoInfoModel *)videoModel{
    _videoModel = videoModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_videoModel.video_img] placeholderImage:[UIImage jk_imageWithColor:kOrangeColor]];
    self.titleLabel.text = _videoModel.video_title;
    self.videoIcon.hidden = !_videoModel.videoType;
    
}

@end


@interface VLFollowListTableViewCell ()

KProStrongType(UIImageView, iconImageView);
KProStrongType(UILabel, nickLabel);
KProStrongType(UILabel, summaryLabel);
KProStrongType(UIButton, followButton);
KProNSMutableArrayType(StackSubView, stackSubViews)

KProStrongType(UIStackView, stackView);
@end

@implementation VLFollowListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor= [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kWhiteColor;
        kViewRadius(self.contentView, 8);
        
        [self setupView];
    }
    return self;
}

- (NSMutableArray<StackSubView *> *)stackSubViews{
    if (!_stackSubViews) {
        _stackSubViews = [[NSMutableArray alloc]init];
        [_stackSubViews addObject:[[StackSubView alloc] init]];
        [_stackSubViews addObject:[[StackSubView alloc] init]];
        [_stackSubViews addObject:[[StackSubView alloc] init]];

        for (int i = 0; i<_stackSubViews.count; i++) {
            StackSubView *subView = [_stackSubViews objectAtIndex:i];
            [subView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                [self clickVideo:subView.videoModel];
            }];
        }
    }
    return _stackSubViews;
}

- (void)clickVideo:(VLVideoInfoModel*)infoModel{
    if (infoModel!=nil) {
        
    }
}

- (void)setupView{

    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.contentView addSubview:self.nickLabel];
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.top.equalTo(self.iconImageView);
        make.width.equalTo (@100);
    }];
    
    [self.contentView addSubview:self.summaryLabel];
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.top.equalTo(self.nickLabel.mas_bottom);
        make.width.equalTo(@150);
    }];
    
    [self.contentView addSubview:self.followButton];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 25));
    }];
    
    [self.contentView addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self);
    }];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kSysGroupBGColor;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        kViewRadius(_iconImageView, 20);
        _iconImageView.backgroundColor = kOrangeColor;
    }
    return _iconImageView;
}

-(UILabel *)nickLabel{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickLabel.font = kFontBBig;
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
    return _summaryLabel;
}

- (UIButton *)followButton{
    if (!_followButton) {
        _followButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        _followButton.titleLabel.font = kFontBMedium;
        [_followButton setTitleColor:kCOLOR_THEME forState:UIControlStateNormal];
        kViewBorderRadius(_followButton, 12.5, 1.0, kCOLOR_THEME);
        [_followButton addTarget:self action:@selector(followClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followButton;
}


- (UIStackView *)stackView{
    if(!_stackView){
        _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.alignment = UIStackViewAlignmentFill;
        _stackView.distribution = UIStackViewDistributionFillEqually;
        for (StackSubView *subView in self.stackSubViews) {
            [_stackView addArrangedSubview:subView];
        }
    }
    return _stackView;
}

- (void)setDataModel:(VLFollowListModel *)dataModel{
    _dataModel = dataModel;
    self.summaryLabel.text = [NSString stringWithFormat:@"笔记：%@",dataModel.video_count];
    
    VLIndex_Context_UserInfoResponse *userinfo = [_dataModel.user_info objectAtIndex:self.indexPathRow];
    self.nickLabel.text = userinfo.user_name;
    NCWeakSelf(self);

    [_dataModel.video_list enumerateObjectsUsingBlock:^(VLVideoInfoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        StackSubView *subview = [weakself.stackSubViews objectAtIndex:idx];
        [subview setVideoModel:obj];
    }];
}


- (void)followClicked:(UIButton *)button{
    
    
}

@end
