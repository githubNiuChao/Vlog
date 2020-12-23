//
//  CommentsPopView.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLDetailCommentCell.h"
#import "VLDetailCommentModel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"



@interface CommentsPopView:UIView

@property (nonatomic, strong) UILabel           *label;
@property (nonatomic, strong) UIImageView       *close;

- (instancetype)initWithCommentListData:(NSArray<VLDetailCommentModel *> *)commentListData loginUserInfoModel:(VLUserInfoModel *)loginUser;

@property (nonatomic, copy) NSString *videoID;
KProStrongType(VLUserInfoModel, videoUserInfoModel)//视频作者
KProStrongType(VLUserInfoModel, loginUserInfoModel)//登陆作者

- (void)show;
- (void)dismiss;

@end


