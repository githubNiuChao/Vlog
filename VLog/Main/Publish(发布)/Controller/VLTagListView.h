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

- (void)tagListView:(VLTagListView *)tagListView didSelectBrandTagModel:(VLPublishBrandTagModel *)brandModel;

- (void)tagListView:(VLTagListView *)tagListView didSelectBGoodsTagModel:(VLPublishGoodsTagModel *)brandModel;

- (void)tagListView:(VLTagListView *)tagListView didSelectBGoodsTagModel:(VLPublishGoodsTagModel *)brandModel;

@end

@interface VLTagListView : NCHRefreshTableViewController<JXCategoryListContentViewDelegate>
- (void)setInfoData:(NSArray *)dataArray tagInfo:(NSString *)titleInfo;

@end

@interface VLTagListViewCell : UITableViewCell
KProStrongType(UILabel, titleLabel)
KProStrongType(UILabel, subTitleLabel)
KProStrongType(UIImageView, titleImage)
@end

NS_ASSUME_NONNULL_END
