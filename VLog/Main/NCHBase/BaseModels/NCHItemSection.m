//
//  NCHItemSection.m
//  GoMeYWLC
//
//  Created by NCH on 2016/10/21.
//  Copyright © 2016年 NCH. All rights reserved.
//

#import "NCHItemSection.h"


@implementation NCHItemSection

+ (instancetype)sectionWithItems:(NSArray<NCHWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    NCHItemSection *item = [[self alloc] init];
    if (items.count) {
        [item.items addObjectsFromArray:items];
    }
    
    item.headerTitle = headerTitle;
    item.footerTitle = footerTitle;
    
    return item;
}

- (NSMutableArray<NCHWordItem *> *)items
{
    if(!_items)
    {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
