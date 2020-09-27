//
//  Header.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseResponse.h"
#import "Comment.h"

@interface CommentListResponse:BaseResponse

@property (nonatomic, copy) NSArray<Comment>   *data;

@end
