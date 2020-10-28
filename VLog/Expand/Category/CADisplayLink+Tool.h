//
//  CADisplayLink+Tool.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ExecuteMethodBlock) (CADisplayLink *displayLink);

@interface CADisplayLink (Tool)

@property (nonatomic,copy)ExecuteMethodBlock executeBlock;

+ (CADisplayLink *)displayLinkWithExecuteBlock:(ExecuteMethodBlock)block;

@end
