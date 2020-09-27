//
//  NSTextAttachment+Emotion.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

static char emotionKey;

@interface NSTextAttachment (Emotion)

- (void)setEmotionKey:(NSString *)key;

- (NSString *)emotionKey;

@end
