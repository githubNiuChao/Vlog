//
//  NCHHorizontalFlowLayout.h
//  瀑布流完善接口
//
//  Created by apple on 16/7/31.
//  Copyright © 2016年 NCH. All rights reserved.
//

#import <UIKit/UIKit.h>


@class NCHHorizontalFlowLayout;


@protocol NCHHorizontalFlowLayoutDelegate <NSObject>

@required
/**
 *  要求实现
 *
 *  @param waterflowLayout 哪个布局需要代理返回高度
 *  @param  indexPath          对应的cell, 的indexPath, 但是indexPath.section == 0
 *  @param itemHeight           layout内部计算的高度
 *
 *  @return 需要代理高度对应的cell的宽度
 */
- (CGFloat)waterflowLayout:(NCHHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView widthForItemAtIndexPath:(NSIndexPath *)indexPath itemHeight:(CGFloat)itemHeight;
@optional

/**
 *  需要显示的行数, 默认3
 */
- (NSInteger)waterflowLayout:(NCHHorizontalFlowLayout *)waterflowLayout linesInCollectionView:(UICollectionView *)collectionView;

/**
 *  列间距, 默认10
 */
- (CGFloat)waterflowLayout:(NCHHorizontalFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  行间距, 默认10
 */
- (CGFloat)waterflowLayout:(NCHHorizontalFlowLayout *)waterflowLayout linesMarginInCollectionView:(UICollectionView *)collectionView;

/**
 *  距离collectionView四周的间距, 默认{10, 10, 10, 10}
 */
- (UIEdgeInsets)waterflowLayout:(NCHHorizontalFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView;


@end



@interface NCHHorizontalFlowLayout : UICollectionViewLayout

/** layout的代理 */
- (instancetype)initWithDelegate:(id<NCHHorizontalFlowLayoutDelegate>)delegate;

+ (instancetype)flowLayoutWithDelegate:(id<NCHHorizontalFlowLayoutDelegate>)delegate;
@end
