//
//  AwemeListRequest.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseRequest.h"

@interface AwemeListRequest:BaseRequest

@property (nonatomic, assign) NSInteger   page;
@property (nonatomic, assign) NSInteger   size;
@property (nonatomic, copy) NSString      *uid;

@end

