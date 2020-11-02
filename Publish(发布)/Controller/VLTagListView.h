//
//  VLTagListView.h
//  VLog
//
//  Created by szy on 2020/10/20.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHRefreshTableViewController.h"
#import "VLPublishTagResponse.h"
#import "JXCategoryView.h"

NS_ASSUME_NONNULL_BEGIN

@class VLTagListView;
@protocol VLTagListViewDelegate <NSObject>
//品牌
- (void)tagListView:(VLTagListView *)tagListView didSelectBrandTagModel:(VLPublishBrandTagModel *)brandModel;
//商品
- (void)tagListView:(VLTagListView *)tagListView didSelectBGoodsTagModel:(VLPublishGoodsTagModel *)goodsModel;
//自定义
- (void)tagListView:(VLTagListView *)tagListView didSelectCustomizeWithTitle:(NSString *)title isGoods:(BOOL)isGoods;

@end

@interface VLTagListView : NCHRefreshTableViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, weak) id<VLTagListViewDelegate> delegate;
- (void)setInfoData:(NSArray *)dataArray tagInfo:(NSString *)titleInfo isGoods:(BOOL)isGoods;

@end

@interface VLTagListViewCell : UITableViewCell
KProStrongType(UILabel, titleLabel)
KProStrongType(UILabel, subTitleLabel)
KProStrongType(UIImageView, titleImage)
@end

NS_ASSUME_NONNULL_END
