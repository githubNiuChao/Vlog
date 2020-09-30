//
//  VLCommentTableViewCell.h
//  VLog
//
//  Created by szy on 2020/9/29.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

NS_ASSUME_NONNULL_BEGIN

@class Comment;
@interface VLCommentTableViewCell : UITableViewCell

-(void)initData:(Comment *)comment;
+(CGFloat)cellHeight:(Comment *)comment;

@end

NS_ASSUME_NONNULL_END
