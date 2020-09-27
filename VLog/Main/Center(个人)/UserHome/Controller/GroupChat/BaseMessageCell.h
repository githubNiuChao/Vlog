//
//  BaseMessageCell.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupChat.h"

typedef NS_ENUM(NSUInteger,MenuActionType) {
    DeleteAction,
    CopyAction,
    PasteAction
};

typedef void (^OnMenuAction)(MenuActionType actionType);

@interface BaseMessageCell : UITableViewCell

+ (NSDictionary* )attributes;
+ (NSMutableAttributedString *)cellAttributedString:(GroupChat *)chat;
+ (CGSize)contentSize:(GroupChat *)chat;
+ (CGFloat)cellHeight:(GroupChat *)chat;

@end
