//
//  TextMessageCell.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseMessageCell.h"

@interface TextMessageCell : BaseMessageCell

@property (nonatomic, strong) UIImageView             *avatar;
@property (nonatomic, strong) UITextView              *textView;
@property (nonatomic, strong) CAShapeLayer            *backgroundlayer;
@property (nonatomic, strong) UIImageView             *indicatorView;
@property (nonatomic, strong) UIImageView             *tipIcon;
@property (nonatomic, strong) GroupChat               *chat;
@property (nonatomic, strong) OnMenuAction            onMenuAction;

-(void)initData:(GroupChat *)chat;
- (CGRect)menuFrame;

@end
