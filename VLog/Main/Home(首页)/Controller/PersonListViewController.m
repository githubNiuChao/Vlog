//
//  PersonListViewController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/7/14.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "PersonListViewController.h"
#import "PersonListLogic.h"
#import "WaterFlowLayout.h"
#import "PersonListCollectionViewCell.h"
#import "XYTransitionProtocol.h"
#import "UICollectionView+IndexPath.h"
#import "ProfileViewController.h"
#import "PersonModel.h"

#define itemWidthHeight (([UIScreen jk_width]-30)/2)

@interface PersonListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowLayoutDelegate,XYTransitionProtocol,PersonListLogicDelegate>

@property(nonatomic,strong) PersonListLogic *logic;//逻辑层
@property(nonatomic,strong) UIView *topView;//置顶View

@end

@implementation PersonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化逻辑类
    _logic = [PersonListLogic new];
    _logic.delegagte = self;
    
    [self setupUI];
    //开始第一次数据拉取
    [self.collectionView.mj_header beginRefreshing];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark ————— 初始化页面 —————
-(void)setupUI{
  
    //设置瀑布流布局
    WaterFlowLayout *layout = [WaterFlowLayout new];
    layout.columnCount = 2;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);;
    layout.rowMargin = 10;
    layout.columnMargin = 10;
    layout.delegate = self;
    

    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - kTabbarH);
    [self.collectionView setCollectionViewLayout:layout];
    
    [self.collectionView registerClass:[PersonListCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([PersonListCollectionViewCell class])];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
}

#pragma mark ————— 下拉刷新 —————
-(void)headerRereshing{
    [_logic loadData];
}

#pragma mark ————— 上拉刷新 —————
-(void)footerRereshing{
    _logic.page+=1;
    [_logic loadData];
}

#pragma mark ————— 数据拉取完成 渲染页面 —————
-(void)requestDataCompleted{
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView.mj_header endRefreshing];
    
//    [UIView performWithoutAnimation:^{
        [self.collectionView reloadData];
//    }];

}

#pragma mark ————— collection代理方法 —————
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _logic.dataArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PersonListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PersonListCollectionViewCell class]) forIndexPath:indexPath];
    cell.personModel = _logic.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark ————— layout 代理 —————
-(CGFloat)waterFlowLayout:(WaterFlowLayout *)WaterFlowLayout heightForWidth:(CGFloat)width andIndexPath:(NSIndexPath *)indexPath{
    PersonModel *personModel = _logic.dataArray[indexPath.row];
    if (personModel.hobbys && personModel.hobbysHeight == 0) {
        //计算hobby的高度 并缓存
        CGFloat hobbyH=[personModel.hobbys jk_heightWithFont:kAdaptedFontSize(14) constrainedToWidth:(SCREEN_WIDTH-30)/2-20];
        if (hobbyH>43) {
            hobbyH=43;
        }
        personModel.hobbysHeight = hobbyH;
    }
    CGFloat imgH = personModel.height * itemWidthHeight / personModel.width;
    
    return imgH + 110 + personModel.hobbysHeight;
    
}

//*******重写的时候需要走一句话
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //标记cell
    [self.collectionView setCurrentIndexPath:indexPath];
    
    PersonListCollectionViewCell *cell =(PersonListCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    ProfileViewController *profileVC = [ProfileViewController new];
    profileVC.headerImage = cell.imgView.image;
    profileVC.isTransition = YES;
    [self.navigationController pushViewController:profileVC animated:YES];
    
}
#pragma mark ————— 转场动画起始View —————
-(UIView *)targetTransitionView{
    NSIndexPath * indexPath = [self.collectionView currentIndexPath];
    PersonListCollectionViewCell *cell =(PersonListCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    return cell.imgView;
}

-(BOOL)isNeedTransition{
    return YES;
}


#pragma mark -  上下滑动隐藏/显示导航栏

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - JXCategoryListContentViewDelegate

- (void)listDidAppear{

}

- (UIView *)listView {
    return self.view;
}

@end
