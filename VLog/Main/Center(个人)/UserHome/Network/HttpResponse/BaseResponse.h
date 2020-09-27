//
//  BaseResponse.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "JSONModel.h"

@interface BaseResponse:JSONModel

@property (nonatomic , assign) NSInteger        code;
@property (nonatomic , copy) NSString           *message;
@property (nonatomic , assign) NSInteger        has_more;
@property (nonatomic, assign) NSInteger         total_count;

@end
