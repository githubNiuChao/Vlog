//
//  GroupChatResponse.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseResponse.h"
#import "GroupChat.h"

@interface GroupChatResponse:BaseResponse

@property (nonatomic, copy) GroupChat   *data;

@end
