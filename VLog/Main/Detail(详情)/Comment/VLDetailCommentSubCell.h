//
//  VLDetailCommentSubCell.h
//  VLog
//
//  Created by szy on 2020/10/19.
//  Copyright © 2020 niuchao. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "VLUserInfoModel.h"

@class VLDetailCommentModel;

@interface VLDetailCommentSubCell : UITableViewCell

KProStrongType(VLUserInfoModel, loginUserInfoModel)//登陆作者

@property (nonatomic, strong) VLDetailCommentModel *subModel;

- (void)configCellWithModel:(VLDetailCommentModel *)model;

@end
