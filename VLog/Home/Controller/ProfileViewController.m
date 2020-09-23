//
//  ProfileViewController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/6/14.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "ProfileViewController.h"
#import "XYTransitionProtocol.h"

@interface ProfileViewController ()<XYTransitionProtocol>

@property (nonatomic, strong) SDAnimatedImageView *headerImageView;
@property (nonatomic, strong) UIView *detailsView;//详情view
@property (nonatomic, strong) UIScrollView *parentView;//容器

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人信息";
    [self initUI];
    self.isHidenNaviBar = YES;
    self.StatusBarStyle = UIStatusBarStyleLightContent;
    self.automaticallyAdjustsScrollViewInsets = false;//解决scrollview被自动ContentOffset.y = -20 问题
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self createDetails];
}

#pragma mark -  初始化UI
-(void)initUI{
    
    _parentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [self.view addSubview:_parentView];
    _parentView.contentSize = CGSizeMake(KScreenWidth, KScreenHeight+100);
    
    
    _headerImageView = [SDAnimatedImageView new];
    _headerImageView.frame = CGRectMake(0, 0, self.view.jk_width , KScreenWidth/_headerImage.size.width * _headerImage.size.height);
    [_parentView addSubview:_headerImageView];
    [_headerImageView setImage:_headerImage];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(12, kStatusBarHeight+12, 20, 20);
    [backBtn setImage:IMAGE_NAMED(@"back_icon") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}

#pragma mark -  信息详情
-(void)createDetails{
    if (_detailsView) {
        return;
    }
    _detailsView = [[UIView alloc] initWithFrame:CGRectMake(0, _headerImageView.jk_width, KScreenWidth, 1000)];
    [_parentView addSubview:_detailsView];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, KScreenWidth-30, 230)];
    lbl.numberOfLines = 0;
    lbl.text = @"个人信息\n\n\n昵称：萌萌哒小萌新\n\n性别：女\n\n个人爱好：琴棋书画我样样不会，只会打王者荣耀😜";
    //    [lbl sizeToFit];
    lbl.font = SYSTEMFONT(20);
    lbl.textColor = KBlackColor;
    [_detailsView addSubview:lbl];
    
    _detailsView.alpha = 0;
    _detailsView.transform = CGAffineTransformMakeTranslation(0, 50);
    kWeakSelf(self)
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseInOut animations:^{
        weakself.detailsView.alpha = 1;
        weakself.detailsView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

-(UIView *)targetTransitionView{
    return self.headerImageView;
}
-(BOOL)isNeedTransition{
    return _isTransition;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
