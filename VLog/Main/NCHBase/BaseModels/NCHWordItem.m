//
//  NCHWordItem.m
//  GoMeYWLC
//
//  Created by NCH on 2016/10/21.
//  Copyright © 2016年 NCH. All rights reserved.
//

#import "NCHWordItem.h"

@implementation NCHWordItem

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    NCHWordItem *item = [[self alloc] init];
    item.subTitle = subTitle;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation {
    NCHWordItem *item = [self itemWithTitle:title subTitle:subTitle];
    item.itemOperation = itemOperation;
    return item;
}

- (instancetype)init
{
    if (self = [super init]) {
        _titleColor = [UIColor blackColor];
        _subTitleColor = [UIColor blackColor];
//        _cellHeight = AdaptedWidth(50);
        _titleFont = kAdaptedFontSize(16);
        _subTitleFont = kAdaptedFontSize(16);
        _subTitleNumberOfLines = 2;
    }
    
    return self;
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        _cellHeight += 20;
        NSString *totalString = [NSString stringWithFormat:@"%@%@", self.title, self.subTitle];
        _cellHeight += [totalString boundingRectWithSize:CGSizeMake(kkSCREEN_WIDTH - 20, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : self.subTitleFont} context:nil].size.height;
        _cellHeight = MAX(_cellHeight, 50);
        _cellHeight = kAdaptedWidth(_cellHeight);
    }
    return _cellHeight;
}


@end
