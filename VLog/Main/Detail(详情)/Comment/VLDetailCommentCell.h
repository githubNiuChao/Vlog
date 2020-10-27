//
//  VLDetailCommentCell.h
//  VLog
//
//  Created by szy on 2020/10/19.
//  Copyright © 2020 niuchao. All rights reserved.
//


#import <UIKit/UIKit.h>

@class VLDetailCommentModel;

@protocol VLDetailCommentCellDelegate <NSObject>

- (void)reloadCellHeightForModel:(VLDetailCommentModel *)model atIndexPath:(NSIndexPath *)indexPath;

@end

@interface VLDetailCommentCell : UITableViewCell

@property (nonatomic, weak) id<VLDetailCommentCellDelegate> delegate;

- (void)configCellWithModel:(VLDetailCommentModel *)model indexPath:(NSIndexPath *)indexPath;

@end
