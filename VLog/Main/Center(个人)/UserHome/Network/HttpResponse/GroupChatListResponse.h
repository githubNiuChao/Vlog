//
//  Header.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseResponse.h"
#import "GroupChat.h"

@interface GroupChatListResponse:BaseResponse

@property (nonatomic, copy) NSArray<GroupChat>   *data;

@end
