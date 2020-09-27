//
//  UserResponse.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseResponse.h"
#import "User.h"

@interface UserResponse:BaseResponse

@property (nonatomic, strong) User    *data;

@end
