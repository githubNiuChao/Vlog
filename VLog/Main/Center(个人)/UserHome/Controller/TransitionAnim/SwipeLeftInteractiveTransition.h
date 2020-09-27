//
//  SwipeLeftInteractiveTransition.h
//  VLog
//
//  Created by szy on 2020/9/21.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AwemeListController;

@interface SwipeLeftInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interacting;
-(void)wireToViewController:(AwemeListController *)viewController;
@end
