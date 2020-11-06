//
//  VLDetailCommentCell.h
//  VLog
//
//  Created by szy on 2020/10/19.
//  Copyright © 2020 niuchao. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "VLUserInfoModel.h"

@class VLDetailCommentModel;
@class VLDetailCommentCell;

@protocol VLDetailCommentCellDelegate <NSObject>

- (void)reloadCellHeightForModel:(VLDetailCommentModel *)model atIndexPath:(NSIndexPath *)indexPath;

//subCell点击
- (void)detailCommentCellModel:(VLDetailCommentModel*)cellModel replyCommentWith:(VLDetailCommentModel *)subCellModel atIndexPath:(NSIndexPath *)indexPath;

@end

@interface VLDetailCommentCell : UITableViewCell

@property (nonatomic, weak) id<VLDetailCommentCellDelegate> delegate;

KProStrongType(VLUserInfoModel, loginUserInfoModel)//登陆作者

@property (nonatomic, strong) VLDetailCommentModel *testModel;
- (void)configCellWithModel:(VLDetailCommentModel *)model indexPath:(NSIndexPath *)indexPath;

@end
