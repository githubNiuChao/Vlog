//
//  CommentResponse.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseResponse.h"
#import "Comment.h"

@interface CommentResponse:BaseResponse

@property (nonatomic, strong) Comment    *data;

@end
