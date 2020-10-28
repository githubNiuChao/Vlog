//
//  VLMessageLikeListViewController.m
//  VLog
//
//  Created by szy on 2020/10/25.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLMessageLikeListViewController.h"
#import "VLMessageLikeTableViewCell.h"

@interface VLMessageLikeListViewController ()

@property (nonatomic, strong) NSArray *dataArray;


//navsubView
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation VLMessageLikeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCommon];
    [self initSubView];
}

- (void)initCommon{
    self.dataArray = [[NSArray alloc] init];
    
}

- (void)loadMore:(BOOL)isMore{
    VLMessageLikeRequest *request = [[VLMessageLikeRequest alloc] init];
    
    self.dataArray = @[@"",@"",@"",@""];
    [self endHeaderFooterRefreshing];
    [self.tableView reloadData];
    
    self.namelabel.text = @"我是傻逼少时诵诗书所所所";
    
    NCWeakSelf(self);
    [request nch_startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
        VLMessageLikeResponse *model = [VLMessageLikeResponse yy_modelWithJSON:baseResponse.data];
        
        weakself.dataArray = @[@"",@"",@"",@""];
        [weakself endHeaderFooterRefreshing];
        
        [weakself.tableView reloadData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request, NCHBaseRequestResponse * _Nonnull baseResponse) {
        
    }];
    
}

- (void)initSubView{
    [self setNavigationsSubViews];
    [self setLeftBarButton:@"niv_back_dark"];
    
//    [self setNavigationBarTitle:@"赞和收藏"];
    [self setBackgroundColor:kWhiteColor];
    [self.tableView registerClass:[VLMessageLikeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VLMessageLikeTableViewCell class])];
}

- (void)setNavigationsSubViews{
    
    //    [self addNavigationItemWithTitles:(NSArray *) isLeft:(BOOL) target:(id) action:(SEL) tags:(NSArray *)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"niv_back_dark"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    kViewRadius(_headImage, 15);
    self.headImage.image = [UIImage jk_imageWithColor:kOrangeColor];
//    self.headImage.alignmentRectInsetsOverride = UIEdgeInsetsMake(0, 10, 0, -(10));
//      self.headImage.translatesAutoresizingMaskIntoConstraints = NO;
//      [self.headImage.widthAnchor constraintEqualToConstant:30].active = YES;
//      [self.headImage.heightAnchor constraintEqualToConstant:30].active = YES;
    

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = 10;
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc] initWithCustomView:self.headImage];
    self.namelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
    self.namelabel.font = kFontBSmall;
    self.namelabel.textColor = kBlackColor;
    self.namelabel.text = @"你是傻逼吗";
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc] initWithCustomView:self.namelabel];
    self.navigationItem.leftBarButtonItems = @[leftButton,item1,item2];
    
    
    _followButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    [_followButton setTitle:@"关注" forState:UIControlStateNormal];
    [_followButton setTitle:@"已关注" forState:UIControlStateSelected];
    _followButton.titleLabel.font = kFontBSmall;
    [_followButton setTitleColor:kCOLOR_THEME forState:UIControlStateNormal];
    [_followButton setTitleColor:kGreyColor forState:UIControlStateSelected];
    kViewBorderRadius(_followButton, 12.5, 1.0, kCOLOR_THEME);
    
    [_followButton addTarget:self action:@selector(followClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item3 = [[UIBarButtonItem alloc] initWithCustomView:_followButton];
    _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30,30)];
    [_shareButton setImageEdgeInsets:UIEdgeInsetsMake(3,0,3,0)];
    _shareButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_shareButton setImage:kNameImage(@"detail_share_icon") forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item4 = [[UIBarButtonItem alloc] initWithCustomView:_shareButton];
    self.navigationItem.rightBarButtonItems = @[item4,item3];
    //    [self addNavigationItemWithImageNames:@[@"",@""] isLeft:NO target:self action:@selector(right.) tags:<#(NSArray *)#>]
    
    
}


//
//- (void)setNavigationItemWithFreeBuyEnable:(BOOL)freeBuyEnable {
//    self.navigationItem.rightBarButtonItem = nil;
//    self.navigationItem.rightBarButtonItems = nil;
//    YSC_WEAK_SELF
//    UIButton *moreButton = [YSCCommonViewManager barButtonItemCustomButton];
//    [moreButton addTarget:weakSelf action:@selector(navigationBarButtonItemOnclick:) forControlEvents:UIControlEventTouchUpInside];
//    moreButton.imageEdgeInsets = YSCCommonBarRightButtonImageEdgeInsets;
//    [moreButton setImage:[UIImage imageNamed:@"btn_more_white"] forState:UIControlStateNormal];
//    UIBarButtonItem *moreBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
//    moreButton.tag = 3000;
//
//    if(isTakeoutStyle) {
//        UIButton *buttonScan = [UIButton buttonWithType:UIButtonTypeCustom];
//        [buttonScan setBackgroundImage:[UIImage imageNamed:@"btn_scan_white"] forState:UIControlStateNormal];
//        [buttonScan addTarget:weakSelf action:@selector(navigationBarButtonItemOnclick:) forControlEvents:UIControlEventTouchUpInside];
//        buttonScan.tag = 3001;
//        // 设置导航栏右边的按钮
//        UIBarButtonItem *scanButton = [[UIBarButtonItem alloc] initWithCustomView:buttonScan];
//        self.buttonFollow = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.buttonFollow addTarget:weakSelf action:@selector(navigationBarButtonItemOnclick:) forControlEvents:UIControlEventTouchUpInside];
//        self.buttonFollow.tag = 3002;
//
//        #ifdef __IPHONE_9_0
//
//        if ([self.buttonFollow respondsToSelector:@selector(widthAnchor)]) {
//            [self.buttonFollow.widthAnchor constraintEqualToConstant:22].active = YES;
//        }
//        if ([self.buttonFollow respondsToSelector:@selector(heightAnchor)]) {
//            [self.buttonFollow.heightAnchor constraintEqualToConstant:22].active = YES;
//        }
//        #endif
//        [self updateFollowState:false];
//        // 设置导航栏右边的按钮
//        UIBarButtonItem *followButton = [[UIBarButtonItem alloc] initWithCustomView:self.buttonFollow];
//        //创建一个空白占位bar
//        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        spaceItem.width = 15;
//        if (freeBuyEnable) {
//            //钱桥定制，是否显示...更多按钮，默认是YES
//            if([YSCApp sharedInstance].is_show_more_button){
//                self.navigationItem.rightBarButtonItems = @[moreBarButtonItem,spaceItem,followButton,spaceItem,scanButton,spaceItem];
//            }else{
//                self.navigationItem.rightBarButtonItems = @[spaceItem,followButton,spaceItem,scanButton,spaceItem];
//            }
//        }else{
//            //钱桥定制，是否显示...更多按钮，默认是YES
//            if([YSCApp sharedInstance].is_show_more_button){
//                self.navigationItem.rightBarButtonItems = @[moreBarButtonItem,spaceItem,followButton,spaceItem];
//            }else{
//                self.navigationItem.rightBarButtonItems = @[spaceItem,followButton,spaceItem];
//            }
//        }
//
//    } else {
//        if (freeBuyEnable) {
//            CGFloat buttonWidth = [@"扫一扫" sizeWithAttributes:@{NSFontAttributeName: [YSCUiUtils fontEight]}].width * 1.2;
//            YSCShopScanButton *scanButton = [[YSCShopScanButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, 44.0)];
//            YSC_WEAK_SELF
//            [scanButton addTarget:weakSelf action:@selector(navigationBarButtonItemOnclick:) forControlEvents:UIControlEventTouchUpInside];
//            UIBarButtonItem *scanBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scanButton];
//            scanButton.tag = 3001;
//            //钱桥定制，是否显示...更多按钮，默认是YES
//            if([YSCApp sharedInstance].is_show_more_button){
//                self.navigationItem.rightBarButtonItems = @[moreBarButtonItem, scanBarButtonItem];
//            }else{
//                NSArray *rightBarButtonItems = @[scanBarButtonItem];
//                self.navigationItem.rightBarButtonItems = rightBarButtonItems;
//            }
//
//        } else {
//            //钱桥定制，是否显示...更多按钮，默认是YES
//            if([YSCApp sharedInstance].is_show_more_button){
//                self.navigationItem.rightBarButtonItem = moreBarButtonItem;
//            }else{
//                self.navigationItem.rightBarButtonItem = nil;
//            }
//        }
//    }
//
//    [self setNavSearchTextField];
//}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VLMessageLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VLMessageLikeTableViewCell class])];
    NSObject *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.followButton.hidden = YES;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *model = [self.dataArray objectAtIndex:indexPath.row];
}

@end
