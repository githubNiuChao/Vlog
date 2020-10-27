//
//  VLVideoListTableViewCell.m
//  VLog
//
//  Created by szy on 2020/10/18.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLVideoListTableViewCell.h"
#import "Aweme.h"
#import "AVPlayerView.h"
#import "HoverTextView.h"
#import "CircleTextView.h"
#import "FocusView.h"
#import "MusicAlbumView.h"
#import "FavoriteView.h"
#import "CommentsPopView.h"
#import "SharePopView.h"
#import "NetworkHelper.h"

static const NSInteger kAwemeListLikeCommentTag = 0x01;
static const NSInteger kAwemeListLikeShareTag   = 0x02;

@interface VLVideoListTableViewCell()<SendTextDelegate, HoverTextViewDelegate, AVPlayerUpdateDelegate>

@property (nonatomic, strong) UIView                   *container;
@property (nonatomic ,strong) CAGradientLayer          *gradientLayer;
@property (nonatomic ,strong) UIImageView              *pauseIcon;
@property (nonatomic, strong) UIView                   *playerStatusBar;
//@property (nonatomic ,strong) UIImageView              *musicIcon;
@property (nonatomic, strong) UITapGestureRecognizer   *singleTapGesture;
@property (nonatomic, assign) NSTimeInterval           lastTapTime;
@property (nonatomic, assign) CGPoint                  lastTapPoint;

@end

@implementation VLVideoListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = ColorBlackAlpha1;
        _lastTapTime = 0;
        _lastTapPoint = CGPointZero;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    //init player view;
    _playerView = [AVPlayerView new];
    _playerView.delegate = self;
    [self.contentView addSubview:_playerView];
    
    //init hover on player view container
    _container = [UIView new];
    [self.contentView addSubview:_container];
    
    _singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [_container addGestureRecognizer:_singleTapGesture];
    
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.colors = @[(__bridge id)ColorClear.CGColor, (__bridge id)ColorBlackAlpha20.CGColor, (__bridge id)ColorBlackAlpha40.CGColor];
    _gradientLayer.locations = @[@0.3, @0.6, @1.0];
    _gradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
    _gradientLayer.endPoint = CGPointMake(0.0f, 1.0f);
    [_container.layer addSublayer:_gradientLayer];
    
    _pauseIcon = [[UIImageView alloc] init];
    _pauseIcon.image = [UIImage imageNamed:@"icon_play_pause"];
    _pauseIcon.contentMode = UIViewContentModeCenter;
    _pauseIcon.layer.zPosition = 3;
    _pauseIcon.hidden = YES;
    [_container addSubview:_pauseIcon];
    
    //init hoverTextView
    _hoverTextView = [HoverTextView new];
    _hoverTextView.delegate = self;
    _hoverTextView.hoverDelegate = self;
    [self addSubview:_hoverTextView];
    
    //init player status bar
    _playerStatusBar = [[UIView alloc]init];
    _playerStatusBar.backgroundColor = ColorWhite;
    [_playerStatusBar setHidden:YES];
    [_container addSubview:_playerStatusBar];
    
//
//    _musicName = [[CircleTextView alloc]init];
//    _musicName.textColor = ColorWhite;
//    _musicName.font = MediumFont;
//    [_container addSubview:_musicName];
    
    
    _desc = [[UILabel alloc]init];
    _desc.numberOfLines = 0;
    _desc.textColor = ColorWhiteAlpha80;
    _desc.font = MediumBoldFont;
    [_container addSubview:_desc];
    
    _tagLabel = [[YYLabel alloc] init];
        _tagLabel.textColor = kBlackColor;
        _tagLabel.font = kFontBSmall;
        _tagLabel.backgroundColor = kWhiteColor;
        _tagLabel.textAlignment = NSTextAlignmentLeft;
        _tagLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _tagLabel.numberOfLines = 0;
    [_container addSubview:_tagLabel];
    
    
    _topicButton = [[UIButton alloc] initWithFrame:CGRectZero];
     kViewRadius(_topicButton, 30/2);
     _topicButton.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.8];
     [_topicButton setImage:kNameImage(@"detail_topic_icon") forState:UIControlStateNormal];
     [_topicButton setTitle:@"" forState:UIControlStateNormal];
     [_topicButton setTitleColor:kBuleColor forState:UIControlStateNormal];
     [_topicButton setImageEdgeInsets:UIEdgeInsetsMake(5,0,5,0)];
     _topicButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
     _topicButton.titleLabel.font = kFontBMedium;
    
    [_container addSubview:_topicButton];
    
    _nickName = [[UILabel alloc]init];
    _nickName.textColor = ColorWhite;
    _nickName.font = BigBoldFont;
    [_container addSubview:_nickName];

    _share = [[UIImageView alloc]init];
    _share.contentMode = UIViewContentModeCenter;
    _share.image = [UIImage imageNamed:@"icon_home_share"];
    _share.userInteractionEnabled = YES;
    _share.tag = kAwemeListLikeShareTag;
    [_share addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
    [_container addSubview:_share];
    
    _collectNum = [[UILabel alloc]init];
    _collectNum.text = @"收藏";
    _collectNum.textColor = ColorWhite;
    _collectNum.font = SmallFont;
    [_container addSubview:_collectNum];
    
    _comment = [[UIImageView alloc]init];
    _comment.contentMode = UIViewContentModeCenter;
    _comment.image = [UIImage imageNamed:@"icon_home_comment"];
    _comment.userInteractionEnabled = YES;
    _comment.tag = kAwemeListLikeCommentTag;
    [_comment addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
    [_container addSubview:_comment];
    
    _commentNum = [[UILabel alloc]init];
    _commentNum.text = @"评论";
    _commentNum.textColor = ColorWhite;
    _commentNum.font = SmallFont;
    [_container addSubview:_commentNum];
    
    _favorite = [FavoriteView new];
    [_container addSubview:_favorite];
    
    _favoriteNum = [[UILabel alloc]init];
     [_favoriteNum setText:@"赞"];
    _favoriteNum.textColor = ColorWhite;
    _favoriteNum.font = SmallFont;
    [_container addSubview:_favoriteNum];
    
    _collect = [[UIButton alloc] initWithFrame:CGRectZero];
    [_collect setImage:kNameImage(@"detail_collect_n") forState:UIControlStateNormal];
    [_collect setImage:kNameImage(@"detail_collect_s") forState:UIControlStateSelected];
    [_collect setTitleColor:kGreyColor forState:UIControlStateNormal];
    _collect.selected = self.detailModel.is_collection;
    _collect.titleLabel.font = kFontBBig;
    [_collect addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
    [_container addSubview:_collect];
    
    
    //init avatar
    CGFloat avatarRadius = 25;
    _avatar = [[UIImageView alloc] init];
    _avatar.image = [UIImage imageNamed:@"img_find_default"];
    _avatar.layer.cornerRadius = avatarRadius;
    _avatar.layer.borderColor = ColorWhiteAlpha80.CGColor;
    _avatar.layer.borderWidth = 1;
    [_container addSubview:_avatar];
    
    //init focus action
    _focus = [FocusView new];
    [_container addSubview:_focus];
    
    [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_pauseIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(100);
    }];

    [_playerStatusBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).inset(49.5f + SafeAreaBottomHeight);
        make.width.mas_equalTo(1.0f);
        make.height.mas_equalTo(0.5f);
    }];

    
    [_topicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.playerStatusBar.mas_top).offset(-20);
        make.left.equalTo(self).offset(10);
        make.height.equalTo(@(30));
    }];
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topicButton.mas_bottom);
        make.left.right.equalTo(self).offset(10);
        
    }];
    
    [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self.tagLabel.mas_top).offset(-30);
        make.width.mas_lessThanOrEqualTo(ScreenWidth/5*3);
    }];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self.desc.mas_top).inset(20);
        make.width.height.mas_equalTo(avatarRadius*2);
    }];
    
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(10);
        make.centerY.equalTo(self.avatar.mas_centerY);
        make.width.mas_lessThanOrEqualTo(ScreenWidth/4*3 + 30);
    }];

    [_collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.playerStatusBar.mas_top).offset(-30);
        make.right.equalTo(self).inset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(45);
    }];
    [_collectNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collect.mas_bottom);
        make.centerX.equalTo(self.collect);
    }];
    [_comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.collect.mas_top).inset(25);
        make.right.equalTo(self).inset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(45);
    }];
    [_commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.comment.mas_bottom);
        make.centerX.equalTo(self.comment);
    }];
    [_favorite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.comment.mas_top).inset(25);
        make.right.equalTo(self).inset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(45);
    }];
    
    [_favoriteNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.favorite.mas_bottom);
        make.centerX.equalTo(self.favorite);
    }];

    [_focus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.avatar);
        make.centerY.equalTo(self.avatar.mas_bottom);
        make.width.height.mas_equalTo(24);
    }];
}

-(void)prepareForReuse {
    [super prepareForReuse];
    
    _isPlayerReady = NO;
    [_playerView cancelLoading];
    [_pauseIcon setHidden:YES];
    
    [_hoverTextView.textView setText:@""];
    [_avatar setImage:[UIImage imageNamed:@"img_find_default"]];
    [_favorite resetView];
    [_focus resetView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _gradientLayer.frame = CGRectMake(0, self.frame.size.height - 500, self.frame.size.width, 500);
    [CATransaction commit];
}

//SendTextDelegate delegate
- (void)onSendText:(NSString *)text {
    __weak __typeof(self) wself = self;
    PostCommentRequest *request = [PostCommentRequest new];
//    request.aweme_id = _aweme.aweme_id;
    request.udid = UDID;
    request.text = text;
    [NetworkHelper postWithUrlPath:PostComentPath request:request success:^(id data) {
        [UIWindow showTips:@"评论成功"];
    } failure:^(NSError *error) {
        wself.hoverTextView.textView.text = text;
        [UIWindow showTips:@"评论失败"];
    }];
}

//HoverTextViewDelegate delegate
-(void)hoverTextViewStateChange:(BOOL)isHover {
    _container.alpha = isHover ? 0.0f : 1.0f;
}

//gesture
- (void)handleGesture:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case kAwemeListLikeCommentTag: {
            CommentsPopView *popView = [[CommentsPopView alloc] initWithAwemeId:@"1"];
            [popView show];
            break;
        }
        case kAwemeListLikeShareTag: {
            SharePopView *popView = [[SharePopView alloc] init];
            [popView show];
            break;
        }
        default: {
            //获取点击坐标，用于设置爱心显示位置
            CGPoint point = [sender locationInView:_container];
            //获取当前时间
            NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
            //判断当前点击时间与上次点击时间的时间间隔
            if(time - _lastTapTime > 0.25f) {
                //推迟0.25秒执行单击方法
                [self performSelector:@selector(singleTapAction) withObject:nil afterDelay:0.25f];
            }else {
                //取消执行单击方法
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTapAction) object: nil];
                //执行连击显示爱心的方法
                [self showLikeViewAnim:point oldPoint:_lastTapPoint];
            }
            //更新上一次点击位置
            _lastTapPoint = point;
            //更新上一次点击时间
            _lastTapTime =  time;
            break;
        }
    }
    
}

- (void)singleTapAction {
    if([_hoverTextView isFirstResponder]) {
        [_hoverTextView resignFirstResponder];
    }else {
        [self showPauseViewAnim:[_playerView rate]];
        [_playerView updatePlayerState];
    }
}

//暂停播放动画
- (void)showPauseViewAnim:(CGFloat)rate {
    if(rate == 0) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             self.pauseIcon.alpha = 0.0f;
                         } completion:^(BOOL finished) {
                             [self.pauseIcon setHidden:YES];
                         }];
    }else {
        [_pauseIcon setHidden:NO];
        _pauseIcon.transform = CGAffineTransformMakeScale(1.8f, 1.8f);
        _pauseIcon.alpha = 1.0f;
        [UIView animateWithDuration:0.25f delay:0
                            options:UIViewAnimationOptionCurveEaseIn animations:^{
                                self.pauseIcon.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                            } completion:^(BOOL finished) {
                            }];
    }
}

//连击爱心动画
- (void)showLikeViewAnim:(CGPoint)newPoint oldPoint:(CGPoint)oldPoint {
    UIImageView *likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_home_like_after"]];
    CGFloat k = ((oldPoint.y - newPoint.y)/(oldPoint.x - newPoint.x));
    k = fabs(k) < 0.5 ? k : (k > 0 ? 0.5f : -0.5f);
    CGFloat angle = M_PI_4 * -k;
    likeImageView.frame = CGRectMake(newPoint.x, newPoint.y, 80, 80);
    likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 0.8f, 1.8f);
    [_container addSubview:likeImageView];
    [UIView animateWithDuration:0.2f
                          delay:0.0f
         usingSpringWithDamping:0.5f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 1.0f, 1.0f);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5f
                                               delay:0.5f
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 3.0f, 3.0f);
                                              likeImageView.alpha = 0.0f;
                                          }
                                          completion:^(BOOL finished) {
                                              [likeImageView removeFromSuperview];
                                          }];
                     }];
}

//加载动画
-(void)startLoadingPlayItemAnim:(BOOL)isStart {
    if (isStart) {
        _playerStatusBar.backgroundColor = ColorWhite;
        [_playerStatusBar setHidden:NO];
        [_playerStatusBar.layer removeAllAnimations];
        
        CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc]init];
        animationGroup.duration = 0.5;
        animationGroup.beginTime = CACurrentMediaTime() + 0.5;
        animationGroup.repeatCount = MAXFLOAT;
        animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation * scaleAnimation = [CABasicAnimation animation];
        scaleAnimation.keyPath = @"transform.scale.x";
        scaleAnimation.fromValue = @(1.0f);
        scaleAnimation.toValue = @(1.0f * ScreenWidth);
        
        CABasicAnimation * alphaAnimation = [CABasicAnimation animation];
        alphaAnimation.keyPath = @"opacity";
        alphaAnimation.fromValue = @(1.0f);
        alphaAnimation.toValue = @(0.5f);
        [animationGroup setAnimations:@[scaleAnimation, alphaAnimation]];
        [self.playerStatusBar.layer addAnimation:animationGroup forKey:nil];
    } else {
        [self.playerStatusBar.layer removeAllAnimations];
        [self.playerStatusBar setHidden:YES];
    }
    
}

// AVPlayerUpdateDelegate
-(void)onProgressUpdate:(CGFloat)current total:(CGFloat)total {
    //播放进度更新
}

-(void)onPlayItemStatusUpdate:(AVPlayerItemStatus)status {
    switch (status) {
        case AVPlayerItemStatusUnknown:
            [self startLoadingPlayItemAnim:YES];
            break;
        case AVPlayerItemStatusReadyToPlay:
            [self startLoadingPlayItemAnim:NO];
            _isPlayerReady = YES;
            if(_onPlayerReady) {
                _onPlayerReady();
            }
            break;
        case AVPlayerItemStatusFailed:
            [self startLoadingPlayItemAnim:NO];
            [UIWindow showTips:@"加载失败"];
            break;
        default:
            break;
    }
}

// update method
- (void)initData:(VLDetailResponse *)detailModel {
    _detailModel = detailModel;
    
    [_nickName setText:[NSString stringWithFormat:@"@%@",detailModel.current_user.nickname]];
    [_desc setText:detailModel.video_info.video_title];
    [_avatar sd_setImageWithURL:[NSURL URLWithString:detailModel.current_user.headimg] placeholderImage:kNameImage(@"img_find_default")];
    
    NSMutableAttributedString *detailLabelAText = [NSMutableAttributedString new];
    NCWeakSelf(self);
    [detailModel.video_info.video_desc enumerateObjectsUsingBlock:^(VLVideoInfo_DescModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.is_tag) {
            [detailLabelAText appendAttributedString:[weakself appendDescTagAttributedStringWithInfoModel:obj]];
        }else{
            [detailLabelAText appendAttributedString:[weakself appendAttributedString:obj.name font:kFontBMedium]];
        }
    }];
    self.tagLabel.attributedText = detailLabelAText;
    CGFloat detailLabelHeight = [self getTextHeight:detailLabelAText andLabel:self.tagLabel];
    [self.tagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(detailLabelHeight));
    }];
    
}

- (void)play {
    [_playerView play];
    [_pauseIcon setHidden:YES];
}

- (void)pause {
    [_playerView pause];
    [_pauseIcon setHidden:NO];
}

- (void)replay {
    [_playerView replay];
    [_pauseIcon setHidden:YES];
}

- (void)startDownloadBackgroundTask {
//    NSString *playUrl = [NetworkHelper isWifiStatus] ? _aweme.video.play_addr.url_list.firstObject : _aweme.video.play_addr_lowbr.url_list.firstObject;
    [_playerView setPlayerWithUrl:[self.detailModel.video_info.video_path firstObject]];
}

- (void)startDownloadHighPriorityTask {
//    NSString *playUrl = [NetworkHelper isWifiStatus] ? _aweme.video.play_addr.url_list.firstObject : _aweme.video.play_addr_lowbr.url_list.firstObject;
    [_playerView startDownloadTask:[[NSURL alloc] initWithString:[self.detailModel.video_info.video_path firstObject]] isBackground:NO];
}








#pragma mark - NSAttributedString
-(CGFloat)getTextHeight:(NSAttributedString *)text andLabel:(YYLabel *)lable
{
    CGSize introSize = CGSizeMake(self.jk_width-10, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:text];
    lable.textLayout = layout;
    CGFloat introHeight = layout.textBoundingSize.height;
    return introHeight;
}


- (NSAttributedString *)appendAttributedString:(NSString *)string font:(UIFont *)font{
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:string];
        one.yy_font = font;
        one.yy_color = kBlackColor;
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.000 alpha:0.5];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.yy_textShadow = shadow;
        [text appendAttributedString:one];
    }
    return text;
}

- (NSAttributedString *)appendDescTagAttributedStringWithInfoModel:(VLVideoInfo_DescModel *)infoModel{
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIImage *image = [UIImage imageNamed:@"publish_tag_goodsicon"];
    if ([infoModel.type isEqualToString:@"2"]) {
        image = [UIImage imageNamed:@"publish_tag_brandicon"];
    }else if([infoModel.type isEqualToString:@"3"]){
        image = [UIImage imageNamed:@"publish_tag_goodsicon"];
    }
    NSMutableAttributedString *attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:kFontBSmall alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString: attachment];
    
    {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:infoModel.name];
        one.yy_font = kFontBMedium;
        one.yy_color = kBuleColor;
        
        YYTextShadow *shadow = [YYTextShadow new];
        shadow.color = [UIColor colorWithWhite:0.0 alpha:0.5];
        shadow.offset = CGSizeMake(0, 1);
        shadow.radius = 5;
        one.yy_textShadow = shadow;
    
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
        NCWeakSelf(self);
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            [weakself actiondidTagClickWithInfoModel:infoModel];
        };
        [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
        
        [text appendAttributedString:one];
        [text appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"  "]];
    }
    return text;
}


- (void)actiondidTagClickWithInfoModel:(VLVideoInfo_DescModel *)infoModel{
    
    
}



@end
