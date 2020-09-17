//
//  YISTagBgView.m
//  VLog
//
//  Created by szy on 2020/9/17.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "YISTagBgView.h"
#import "YBTagView.h"

@implementation YISTagBgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {

               CGPoint point = [gestureRecoginzer locationInView:gestureRecoginzer.view];
               
           //    NSLog(@"开始位置：%@",NSStringFromCGPoint(point));
               YBTagView *tagView = [[YBTagView alloc]initWithPoint:point];
               tagView.block = ^(NSString *gestureString){
                   NSLog(@"......%@",gestureString);
               };
               [self addSubview:tagView];
               tagView.tagArray = @[@"可儿购可儿购可儿购可儿购可儿购"];//@
        }];
        
        YBTagView *tagView = [[YBTagView alloc]initWithPoint:CGPointMake(0 , 0)];
        tagView.block = ^(NSString *str) {
            NSLog(@"%@",str);
        };
        [self addSubview:tagView];
        tagView.tagArray = @[@"可儿购可儿购可儿购可儿购可儿购"];
    }
    return self;
}

@end
