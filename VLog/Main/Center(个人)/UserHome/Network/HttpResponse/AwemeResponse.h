//
//  AwemeResponse.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseResponse.h"
#import "Aweme.h"

@interface AwemeResponse:BaseResponse

@property (nonatomic, copy) Aweme   *data;

@end
