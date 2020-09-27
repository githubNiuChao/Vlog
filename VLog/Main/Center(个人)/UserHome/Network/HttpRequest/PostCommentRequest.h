//
//  PostCommentRequest.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseRequest.h"

@interface PostCommentRequest:BaseRequest

@property (nonatomic, copy) NSString   *aweme_id;
@property (nonatomic, copy) NSString   *udid;
@property (nonatomic, copy) NSString   *text;

@end
