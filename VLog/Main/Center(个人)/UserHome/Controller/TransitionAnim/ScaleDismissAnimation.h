//
//  ScaleDismissAnimation.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScaleDismissAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) CGRect centerFrame;
@end
