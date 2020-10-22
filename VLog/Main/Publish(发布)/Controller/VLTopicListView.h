//
//  VLTopicListView.h
//  VLog
//
//  Created by szy on 2020/10/22.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHRefreshTableViewController.h"
#import "JXCategoryView.h"
NS_ASSUME_NONNULL_BEGIN

@class VLTopicListView;
@protocol VLTopicListViewDelegate <NSObject>

- (void)topicListView:(VLTopicListView *)topicListView didSelectCatid:(NSInteger)catid SelectCatTitle:(NSString *)caTtitle;

@end

@interface VLTopicListView : NCHRefreshTableViewController<JXCategoryListContentViewDelegate>
@property (nonatomic, weak) id<VLTopicListViewDelegate> delegate;
kProNSString(parent_id)
@end

@interface VLTopicListViewCell : UITableViewCell
KProStrongType(UILabel, titleLabel)
KProStrongType(UILabel, subTitleLabel)
KProStrongType(UIImageView, titleImage)

@end
NS_ASSUME_NONNULL_END
