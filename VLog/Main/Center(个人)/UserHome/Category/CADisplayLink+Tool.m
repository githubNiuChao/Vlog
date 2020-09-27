//
//  CADisplayLink+Tool.m
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "CADisplayLink+Tool.h"
#import "objc/runtime.h"

@implementation CADisplayLink (Tool)

- (void)setExecuteBlock:(ExecuteMethodBlock)executeBlock{
    
    objc_setAssociatedObject(self, @selector(executeBlock), [executeBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ExecuteMethodBlock)executeBlock{
    
    return objc_getAssociatedObject(self, @selector(executeBlock));
}

+ (CADisplayLink *)displayLinkWithExecuteBlock:(ExecuteMethodBlock)block{
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(executeDisplayLink:)];
    displayLink.executeBlock = [block copy];
    return displayLink;
}

+ (void)executeDisplayLink:(CADisplayLink *)displayLink{
    
    if (displayLink.executeBlock) {
        displayLink.executeBlock(displayLink);
    }
}


@end
