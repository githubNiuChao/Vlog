//
//  Comment.m
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "Comment.h"

@implementation Comment

-(instancetype)init:(NSString *)awemeId text:(NSString *)text taskId:(NSInteger)taskId {
    self = [super init];
    if(self) {
        _aweme_id = awemeId;
        _text = text;
        _isTemp = YES;
        _taskId = taskId;
        
        _digg_count = 0;
        _create_time = [[NSDate new] timeIntervalSince1970];
        _user_digged = 0;
    }
    return self;
}

@end
