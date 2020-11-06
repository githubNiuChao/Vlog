//
//  UITableView+HYBCacheHeight.h
//  CellAutoHeightDemo
//
//  Created by huangyibiao on 16/1/22.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView (HYBCacheHeight)

/**
 *	用于缓存cell的行高
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *hyb_cacheCellHeightDict;

/**
 *
 *	用于获取或者添加计算行高的cell，因为理论上只有一个cell用来计算行高，以降低消耗
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *hyb_reuseCells;

@end
