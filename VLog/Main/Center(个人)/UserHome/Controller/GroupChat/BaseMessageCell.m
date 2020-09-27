//
//  BaseMessageCell.m
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseMessageCell.h"
#import "EmotionHelper.h"

@implementation BaseMessageCell

//cell默认文字样式
+ (NSDictionary* )attributes {
    return @{NSFontAttributeName:SmallFont,NSForegroundColorAttributeName:ColorGray};
}

//NSString转NSMutableAttributedString
+ (NSMutableAttributedString *)cellAttributedString:(GroupChat *)chat {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:chat.msg_content];
    [attributedString addAttributes:[self attributes] range:NSMakeRange(0, attributedString.length)];
    attributedString = [EmotionHelper stringToEmotion:attributedString];
    return attributedString;
}

//通过NSMutableAttributedString或Image width、height获取contentSize
+ (CGSize)contentSize:(GroupChat *)chat {
    return CGSizeZero;
}

//通过contentSize获取cell height
+ (CGFloat)cellHeight:(GroupChat *)chat {
    return 0;
}

@end
