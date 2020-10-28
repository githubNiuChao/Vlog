//
//  NSTextAttachment+Emotion.m
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//
#import "NSTextAttachment+Emotion.h"
#import "objc/runtime.h"

@implementation NSTextAttachment (Emotion)

- (void)setEmotionKey:(NSString *)key {
    objc_setAssociatedObject(self, &emotionKey, key, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)emotionKey {
    return objc_getAssociatedObject(self, &emotionKey);
}

@end
