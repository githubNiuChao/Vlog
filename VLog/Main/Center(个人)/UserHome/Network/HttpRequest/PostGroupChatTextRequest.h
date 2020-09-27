//
//  PostGroupChatTextRequest.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseRequest.h"

@interface PostGroupChatTextRequest:BaseRequest

@property (nonatomic, copy) NSString *udid;
@property (nonatomic, copy) NSString *text;

@end
