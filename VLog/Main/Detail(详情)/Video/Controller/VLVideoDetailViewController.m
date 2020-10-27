//
//  VLVideoDetailViewController.m
//  VLog
//
//  Created by szy on 2020/10/20.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLVideoDetailViewController.h"
#import <AVKit/AVKit.h>
#import "VLVideoListTableViewCell.h"
#import "AVPlayerView.h"
#import "NetworkHelper.h"
#import "LoadMoreControl.h"
#import "AVPlayerManager.h"

#import "VLPhotoDetailManager.h"

NSString * const kVideoListTableViewCell   = @"VideoListTableViewCell";

@interface VLVideoDetailViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,NCHBaseModelManagerDelegate>

@property (nonatomic, assign) BOOL                              isCurPlayerPause;
@property (nonatomic, assign) NSInteger                         pageIndex;
@property (nonatomic, assign) NSInteger                         pageSize;
@property (nonatomic, copy) NSString                            *uid;

//@property (nonatomic, strong) NSMutableArray<VLVideoInfoModel *>           *data;
@property (nonatomic, strong) NSMutableArray<VLVideoInfoModel *>           *awemes;
//@property (nonatomic, strong) LoadMoreControl                      *loadMore;

@property (nonatomic, strong) UIView                   *playerStatusBar;



@property (nonatomic, strong) NSMutableArray<VLDetailResponse *>           *dataArray;
KProStrongType(VLPhotoDetailManager, manager)
KProStrongType(VLDetailResponse, dataModel)
KProStrongType(VLVideoInfoModel, videoIndfoModel)
@end

@implementation VLVideoDetailViewController

-(instancetype)initWithVideoData:(NSMutableArray<VLVideoInfoModel *> *)data currentIndex:(NSInteger)currentIndex pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize uid:(NSString *)uid {
    self = [super init];
    if(self) {
        _isCurPlayerPause = NO;
        _currentIndex = currentIndex;
        _pageIndex = pageIndex;
        _pageSize = pageSize;
        _uid = uid;
        
        _awemes = [data mutableCopy];
        //        _data = [[NSMutableArray alloc] initWithObjects:[_awemes objectAtIndex:_currentIndex], nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarTouchBegin) name:@"StatusBarTouchBeginNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
    [self initCommon];
    self.fd_prefersNavigationBarHidden = YES;
    
}

- (void)initCommon{
    [self initLeftBackButton:@"niv_back_white"];
    self.manager = [[VLPhotoDetailManager alloc] init];
    self.manager.delegagte = self;
    self.dataArray = [[NSMutableArray alloc] init];
    //读数据
    [self startLoadingPlayItemAnim:YES];
    [self.manager loadDataWithVideoId:self.video_id];
}

- (void)requestDataCompleted{
    [self startLoadingPlayItemAnim:NO];
    self.dataModel = self.manager.dataModel;
    self.videoIndfoModel = self.manager.dataModel.video_info;
    [self.dataArray addObject:self.dataModel];
    [self.tableView reloadData];
}


- (void)initSubView{
    [self setBackgroundImage:@"img_video_loading"];
    self.view.layer.masksToBounds = YES;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.backgroundColor = ColorClear;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerClass:VLVideoListTableViewCell.class forCellReuseIdentifier:kVideoListTableViewCell];
    [self.view addSubview:self.tableView];

    _playerStatusBar = [[UIView alloc]init];
    _playerStatusBar.backgroundColor = ColorWhite;
    [_playerStatusBar setHidden:YES];
    [self.view addSubview:_playerStatusBar];
    [_playerStatusBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).inset(49.5f + SafeAreaBottomHeight);
         make.width.mas_equalTo(1.0f);
         make.height.mas_equalTo(0.5f);
     }];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_tableView.layer removeAllAnimations];
    NSArray<VLVideoListTableViewCell *> *cells = [_tableView visibleCells];
    for(VLVideoListTableViewCell *cell in cells) {
        [cell.playerView cancelLoading];
    }
    [[AVPlayerManager shareManager] removeAllPlayers];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    [self removeObserver:self forKeyPath:@"currentIndex"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //填充视频数据
    VLVideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVideoListTableViewCell forIndexPath:indexPath];
    [cell initData:self.dataArray[indexPath.row]];
    [cell startDownloadBackgroundTask];
    //判断当前cell的视频源是否已经准备播放
    NCWeakSelf(self);
    NCWeakSelf(cell);
    if(cell.isPlayerReady) {
        //播放视频
        [cell replay];
    }else {
        [[AVPlayerManager shareManager] pauseAll];
        //当前cell的视频源还未准备好播放，则实现cell的OnPlayerReady Block 用于等待视频准备好后通知播放
        cell.onPlayerReady = ^{
            NSIndexPath *indexPath = [weakself.tableView indexPathForCell:weakcell];
            if(!weakself.isCurPlayerPause && indexPath && indexPath.row == weakself.currentIndex) {
                [weakcell play];
            }
        };
    }
    
    return cell;
}

#pragma ScrollView delegate
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
//        //UITableView禁止响应其他滑动手势
//        scrollView.panGestureRecognizer.enabled = NO;
//
//        if(translatedPoint.y < -50 && self.currentIndex < (self.data.count - 1)) {
//            self.currentIndex ++;   //向下滑动索引递增
//        }
//        if(translatedPoint.y > 50 && self.currentIndex > 0) {
//            self.currentIndex --;   //向上滑动索引递减
//        }
//        [UIView animateWithDuration:0.15
//                              delay:0.0
//                            options:UIViewAnimationOptionCurveEaseOut animations:^{
//                                //UITableView滑动到指定cell
//                                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//                            } completion:^(BOOL finished) {
//                                //UITableView可以响应其他滑动手势
//                                scrollView.panGestureRecognizer.enabled = YES;
//                            }];
//
//    });
//}

#pragma KVO
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    //观察currentIndex变化
//    if ([keyPath isEqualToString:@"currentIndex"]) {
//        //设置用于标记当前视频是否播放的BOOL值为NO
//        _isCurPlayerPause = NO;
//        //获取当前显示的cell
//        VLVideoListTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
//        [cell startDownloadHighPriorityTask];
//        __weak typeof (cell) wcell = cell;
//        __weak typeof (self) wself = self;
//        //判断当前cell的视频源是否已经准备播放
//        if(cell.isPlayerReady) {
//            //播放视频
//            [cell replay];
//        }else {
//            [[AVPlayerManager shareManager] pauseAll];
//            //当前cell的视频源还未准备好播放，则实现cell的OnPlayerReady Block 用于等待视频准备好后通知播放
//            cell.onPlayerReady = ^{
//                NSIndexPath *indexPath = [wself.tableView indexPathForCell:wcell];
//                if(!wself.isCurPlayerPause && indexPath && indexPath.row == wself.currentIndex) {
//                    [wcell play];
//                }
//            };
//        }
//    } else {
//        return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}

//- (void)statusBarTouchBegin {
//    _currentIndex = 0;
//}

- (void)applicationBecomeActive {
    VLVideoListTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
    if(!_isCurPlayerPause) {
        [cell.playerView play];
    }
}

- (void)applicationEnterBackground {
    VLVideoListTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
    _isCurPlayerPause = ![cell.playerView rate];
    [cell.playerView pause];
}

#pragma load data
//- (void)loadData:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
//    __weak __typeof(self) wself = self;
//    AwemeListRequest *request = [AwemeListRequest new];
//    request.page = pageIndex;
//    request.size = pageSize;
//    request.uid = _uid;
//        [NetworkHelper getWithUrlPath:FindAwemePostByPagePath request:request success:^(id data) {
//            AwemeListResponse *response = [[AwemeListResponse alloc] initWithDictionary:data error:nil];
//            NSArray<Aweme *> *array = response.data;
//            if(array.count > 0) {
//                wself.pageIndex++;
//                [wself.tableView beginUpdates];
//                [wself.data addObjectsFromArray:array];
//                NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
//                for(NSInteger row = wself.data.count - array.count; row<wself.data.count; row++) {
//                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
//                    [indexPaths addObject:indexPath];
//                }
//                [wself.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:NO];
//                [wself.tableView endUpdates];
//
//                [wself.loadMore endLoading];
//            }else {
//                [wself.loadMore loadingAll];
//            }
//        } failure:^(NSError *error) {
//            [wself.loadMore loadingFailed];
//        }];
//    }else {
//        [NetworkHelper getWithUrlPath:FindAwemeFavoriteByPagePath request:request success:^(id data) {
//            AwemeListResponse *response = [[AwemeListResponse alloc] initWithDictionary:data error:nil];
//            NSArray<Aweme *> *array = response.data;
//            if(array.count > 0) {
//                wself.pageIndex++;
//                [wself.tableView beginUpdates];
//                [wself.data addObjectsFromArray:array];
//                NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
//                for(NSInteger row = wself.data.count - array.count; row<wself.data.count; row++) {
//                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
//                    [indexPaths addObject:indexPath];
//                }
//                [wself.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:NO];
//                [wself.tableView endUpdates];
//                [wself.loadMore endLoading];
//            }else {
//                [wself.loadMore loadingAll];
//            }
//        } failure:^(NSError *error) {
//            [wself.loadMore loadingFailed];
//        }];
//    }
//}

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


- (void)dealloc {
    NSLog(@"======== dealloc =======");
}

@end

