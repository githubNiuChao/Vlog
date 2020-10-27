//
//  VLVideoListTableViewCell.h
//  VLog
//
//  Created by szy on 2020/10/18.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLDetailResponse.h"
#import "VLVideoInfoModel.h"
#import "VLUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^OnPlayerReady)(void);

@class AVPlayerView;
@class HoverTextView;
@class CircleTextView;
@class FocusView;
@class FavoriteView;

@interface VLVideoListTableViewCell : UITableViewCell

@property (nonatomic, strong) VLDetailResponse            *detailModel;

@property (nonatomic, strong) AVPlayerView     *playerView;
@property (nonatomic, strong) HoverTextView    *hoverTextView;

//@property (nonatomic, strong) CircleTextView   *musicName;
@property (nonatomic, strong) UILabel          *desc;
@property (nonatomic, strong) UILabel          *nickName;

@property (nonatomic, strong) UIImageView      *avatar;
@property (nonatomic, strong) FocusView        *focus;//关注
@property (nonatomic, strong) FavoriteView     *favorite;//赞按钮

@property (nonatomic, strong) UIImageView      *comment;//评论
@property (nonatomic, strong) UIImageView      *share;
@property (nonatomic, strong) UIButton         *collect;//收藏

@property (nonatomic, strong) UILabel          *favoriteNum;
@property (nonatomic, strong) UILabel          *commentNum;
@property (nonatomic, strong) UILabel          *collectNum;

KProStrongType(UIButton,topicButton);//话题
KProStrongType(YYLabel,tagLabel);//详情


@property (nonatomic, strong) OnPlayerReady    onPlayerReady;
@property (nonatomic, assign) BOOL             isPlayerReady;

- (void)initData:(VLDetailResponse *)detailModel;
- (void)play;
- (void)pause;
- (void)replay;
- (void)startDownloadBackgroundTask;
- (void)startDownloadHighPriorityTask;

@end

NS_ASSUME_NONNULL_END
