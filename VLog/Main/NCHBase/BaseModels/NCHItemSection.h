//
//  NCHItemSection.h
//  GoMeYWLC
//
//  Created by NCH on 2016/10/21.
//  Copyright © 2016年 NCH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NCHWordItem;
@interface NCHItemSection : NSObject

/** <#digest#> */
@property (nonatomic, copy) NSString *headerTitle;

/** <#digest#> */
@property (nonatomic, copy) NSString *footerTitle;

/** <#digest#> */
@property (nonatomic, strong) NSMutableArray<NCHWordItem *> *items;

+ (instancetype)sectionWithItems:(NSArray<NCHWordItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

@end
