//
//  VLTextViewComposeParser.h
//  VLog
//
//  Created by szy on 2020/10/24.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYText/YYText.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const VLTextViewComposeParserTopicMainKey = @"#";
static NSString *const VLTextViewComposeParserBrandKey = @"[品牌]#";
static NSString *const VLTextViewComposeParserGoodsKey = @"[商品]#";
static NSString *const VLTextViewComposeParserBrandSubKey = @"[品牌]";
static NSString *const VLTextViewComposeParserGoodsSubKey = @"[商品]";


@interface VLTextViewComposeParser : NSObject <YYTextParser>
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *highlightTextColor;

@end

NS_ASSUME_NONNULL_END
