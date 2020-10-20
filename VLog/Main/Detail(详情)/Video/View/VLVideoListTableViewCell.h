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
@class MusicAlbumView;
@class FavoriteView;

@interface VLVideoListTableViewCell : UITableViewCell

@property (nonatomic, strong) VLDetailResponse            *detailModel;

@property (nonatomic, strong) AVPlayerView     *playerView;
@property (nonatomic, strong) HoverTextView    *hoverTextView;

@property (nonatomic, strong) CircleTextView   *musicName;
@property (nonatomic, strong) UILabel          *desc;
@property (nonatomic, strong) UILabel          *nickName;

@property (nonatomic, strong) UIImageView      *avatar;
@property (nonatomic, strong) FocusView        *focus;
//@property (nonatomic, strong) MusicAlbumView   *musicAlum;

@property (nonatomic, strong) FavoriteView     *favorite;
@property (nonatomic, strong) UIImageView      *comment;
@property (nonatomic, strong) UIImageView      *share;
@property (nonatomic, strong) UILabel          *favoriteNum;
@property (nonatomic, strong) UILabel          *commentNum;
@property (nonatomic, strong) UILabel          *shareNum;

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
