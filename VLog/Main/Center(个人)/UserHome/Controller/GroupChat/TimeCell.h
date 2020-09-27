//
//  TimeCell.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseMessageCell.h"

@interface TimeCell : BaseMessageCell

@property (nonatomic, strong) UITextView      *textView;
@property (nonatomic, strong) GroupChat       *chat;

-(void)initData:(GroupChat *)chat;

@end
