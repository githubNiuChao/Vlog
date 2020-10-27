//
//  VLDetailCommentModel.m
//  VLog
//
//  Created by szy on 2020/10/19.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "VLDetailCommentModel.h"

@implementation VLDetailCommentModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"children" : [VLDetailCommentModel class]};
}
//
//- (NSMutableArray<VLDetailCommentModel *> *)children{
//    if (!_children) {
//        _children = [[NSMutableArray alloc] init];
//    }
//    return _children;
//}
@end
