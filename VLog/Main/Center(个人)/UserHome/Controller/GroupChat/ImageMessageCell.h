//
//  ImageMessageCell.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseMessageCell.h"

@class CircleProgressView;

@interface ImageMessageCell : BaseMessageCell
@property (nonatomic, strong) UIImageView              *avatar;
@property (nonatomic, strong) UIImageView              *imageMsg;
@property (nonatomic, strong) CircleProgressView       *progressView;
@property (nonatomic, strong) GroupChat                *chat;
@property (nonatomic, strong) OnMenuAction             onMenuAction;

-(void)initData:(GroupChat *)chat;
-(void)updateUploadStatus:(GroupChat *)chat;
- (CGRect)menuFrame;

@end
