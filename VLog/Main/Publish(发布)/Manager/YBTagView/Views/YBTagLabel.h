//
//  YBTagLabel.h
//  YBTagView
//
//  //  Created by szy on 2020/9/16.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol tagLabelDelegate <NSObject>

- (void)tagLabelDelegateMethod:(NSString *)string;

@required
@optional

@end

@interface YBTagLabel : UILabel

@property (nonatomic, assign) CGPoint leftPoint;
@property (nonatomic, assign) CGPoint rightPoint;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic,assign)id<tagLabelDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string;

- (void)delay;

@property (nonatomic, assign) CGFloat selfW;
@property (nonatomic, copy) NSString *selfStr;

@end
