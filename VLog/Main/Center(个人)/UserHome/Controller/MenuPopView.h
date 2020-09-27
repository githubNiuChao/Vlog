//
//  MenuPopView.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OnAction)(NSInteger index);

@interface MenuPopView:UIView
@property (nonatomic, strong) UIView        *container;
@property (nonatomic, strong) UIButton      *cancel;
@property (nonatomic, strong) OnAction      onAction;

- (instancetype)initWithTitles:(NSArray *)titles;
- (void)show;
- (void)dismiss;

@end
