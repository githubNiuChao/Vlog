//
//  NCHNavigationBar.m
//  PLMMPRJK
//
//  Created by NCH on 2017/3/31.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "NCHNavigationBar.h"


#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

#define kDefaultNavBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)

#define kSmallTouchSizeHeight 44.0

#define kLeftRightViewSizeMinWidth 60.0

#define kLeftMargin 0.0

#define kRightMargin 0.0

#define kNavBarCenterY(H) ((self.frame.size.height - kStatusBarHeight - H) * 0.5 + kStatusBarHeight)

#define kViewMargin 5.0

@implementation NCHNavigationBar


#pragma mark - system

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupNCHNavigationBarUIOnce];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupNCHNavigationBarUIOnce];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.superview bringSubviewToFront:self];
    
    self.leftView.frame = CGRectMake(0, kStatusBarHeight, self.leftView.jk_width, self.leftView.jk_height);
    
    self.rightView.frame = CGRectMake(self.jk_width - self.rightView.jk_width, kStatusBarHeight, self.rightView.jk_width, self.rightView.jk_height);
    
    self.titleView.frame = CGRectMake(0, kStatusBarHeight + (44.0 - self.titleView.jk_height) * 0.5, MIN(self.jk_width - MAX(self.leftView.jk_width, self.rightView.jk_width) * 2 - kViewMargin * 2, self.titleView.jk_width), self.titleView.jk_height);
    
    self.titleView.jk_centerX = (self.jk_width * 0.5 - self.titleView.jk_width * 0.5);
    
    self.bottomBlackLineView.frame = CGRectMake(0, self.jk_height, self.jk_width, 0.5);

}



#pragma mark - Setter
- (void)setTitleView:(UIView *)titleView
{
    [_titleView removeFromSuperview];
    [self addSubview:titleView];
    
    _titleView = titleView;
    
    __block BOOL isHaveTapGes = NO;
    
    [titleView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
            isHaveTapGes = YES;
            *stop = YES;
        }
    }];
    
    if (!isHaveTapGes) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        [titleView addGestureRecognizer:tap];
    }
    [self layoutIfNeeded];
}

- (void)setTitle:(NSMutableAttributedString *)title
{
    // bug fix
    if ([self.dataSource respondsToSelector:@selector(NCHNavigationBarTitleView:)] && [self.dataSource NCHNavigationBarTitleView:self]) {
        return;
    }
    
    /**头部标题*/
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.jk_width * 0.4, 44)];
    
    navTitleLabel.numberOfLines=0;//可能出现多行的标题
    [navTitleLabel setAttributedText:title];
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.userInteractionEnabled = YES;
    navTitleLabel.lineBreakMode = NSLineBreakByClipping;
    
    self.titleView = navTitleLabel;
}


- (void)setLeftView:(UIView *)leftView
{
    [_leftView removeFromSuperview];
    
    [self addSubview:leftView];
    
    _leftView = leftView;
    
    
    if ([leftView isKindOfClass:[UIButton class]]) {
        
        UIButton *btn = (UIButton *)leftView;
        
        [btn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self layoutIfNeeded];
    
}


- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    
    self.layer.contents = (id)backgroundImage.CGImage;
}



- (void)setRightView:(UIView *)rightView
{
    [_rightView removeFromSuperview];
    
    [self addSubview:rightView];
    
    _rightView = rightView;
    
    if ([rightView isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)rightView;
        [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self layoutIfNeeded];
}

- (void)setDataSource:(id<NCHNavigationBarDataSource>)dataSource
{
    _dataSource = dataSource;
    [self setupDataSourceUI];
}


#pragma mark - getter

- (UIView *)bottomBlackLineView
{
    if(!_bottomBlackLineView)
    {
        CGFloat height = 0.5;
        UIView *bottomBlackLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, height)];
        [self addSubview:bottomBlackLineView];
        _bottomBlackLineView = bottomBlackLineView;
        bottomBlackLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomBlackLineView;
}

#pragma mark - event

- (void)leftBtnClick:(UIButton *)btn
{
    if ([self.NCHDelegate respondsToSelector:@selector(leftButtonEvent:navigationBar:)]) {
        
        [self.NCHDelegate leftButtonEvent:btn navigationBar:self];
    }
}


- (void)rightBtnClick:(UIButton *)btn
{
    if ([self.NCHDelegate respondsToSelector:@selector(rightButtonEvent:navigationBar:)]) {
        [self.NCHDelegate rightButtonEvent:btn navigationBar:self];
    }
}


-(void)titleClick:(UIGestureRecognizer*)Tap
{
    UILabel *view = (UILabel *)Tap.view;
    if ([self.NCHDelegate respondsToSelector:@selector(titleClickEvent:navigationBar:)]) {
        
        [self.NCHDelegate titleClickEvent:view navigationBar:self];
        
    }
}

#pragma mark - custom

- (void)setupDataSourceUI
{
    
    /** 导航条的高度 */
    
    if ([self.dataSource respondsToSelector:@selector(NCHNavigationHeight:)]) {
        self.jk_size = CGSizeMake(kSCREEN_WIDTH, [self.dataSource NCHNavigationHeight:self]);
    }else
    {
        self.jk_size = CGSizeMake(kSCREEN_WIDTH, kDefaultNavBarHeight);
    }
    
    /** 是否显示底部黑线 */
        if ([self.dataSource respondsToSelector:@selector(NCHNavigationIsHideBottomLine:)]) {
    
            if ([self.dataSource NCHNavigationIsHideBottomLine:self]) {
                self.bottomBlackLineView.hidden = YES;
            }
    
        }
    
    /** 背景图片 */
    if ([self.dataSource respondsToSelector:@selector(NCHNavigationBarBackgroundImage:)]) {
        
        self.backgroundImage = [self.dataSource NCHNavigationBarBackgroundImage:self];
    }
    
    /** 背景色 */
    if ([self.dataSource respondsToSelector:@selector(NCHNavigationBackgroundColor:)]) {
        self.backgroundColor = [self.dataSource NCHNavigationBackgroundColor:self];
    }
    
    
    /** 导航条中间的 View */
    if ([self.dataSource respondsToSelector:@selector(NCHNavigationBarTitleView:)]) {
        
        self.titleView = [self.dataSource NCHNavigationBarTitleView:self];
        
    }else if ([self.dataSource respondsToSelector:@selector(NCHNavigationBarTitle:)])
    {
        /**头部标题*/
        self.title = [self.dataSource NCHNavigationBarTitle:self];
    }
    
    
    /** 导航条的左边的 view */
    /** 导航条左边的按钮 */
    if ([self.dataSource respondsToSelector:@selector(NCHNavigationBarLeftView:)]) {
        
        self.leftView = [self.dataSource NCHNavigationBarLeftView:self];
        
    }else if ([self.dataSource respondsToSelector:@selector(NCHNavigationBarLeftButtonImage:navigationBar:)])
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSmallTouchSizeHeight, kSmallTouchSizeHeight)];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        UIImage *image = [self.dataSource NCHNavigationBarLeftButtonImage:btn navigationBar:self];
        
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        
        self.leftView = btn;
    }
    
    /** 导航条右边的 view */
    /** 导航条右边的按钮 */
    if ([self.dataSource respondsToSelector:@selector(NCHNavigationBarRightView:)]) {
        
        self.rightView = [self.dataSource NCHNavigationBarRightView:self];
        
    }else if ([self.dataSource respondsToSelector:@selector(NCHNavigationBarRightButtonImage:navigationBar:)])
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kLeftRightViewSizeMinWidth, kSmallTouchSizeHeight)];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        UIImage *image = [self.dataSource NCHNavigationBarRightButtonImage:btn navigationBar:self];
        
        if (image) {
            [btn setImage:image forState:UIControlStateNormal];
        }
        
        self.rightView = btn;
    }
    
}


- (void)setupNCHNavigationBarUIOnce
{
    self.backgroundColor = [UIColor whiteColor];
}


@end











