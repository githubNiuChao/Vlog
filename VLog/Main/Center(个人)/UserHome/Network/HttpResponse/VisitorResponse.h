//
//  VisitorResponse.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "BaseResponse.h"
#import "Visitor.h"

@interface VisitorResponse:BaseResponse

@property (nonatomic, copy) Visitor   *data;

@end
