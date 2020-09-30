//
//  NCHBaseViewController.h
//  PLMMPRJK
//
//  Created by NCH on 2017/3/29.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCHNavigationBar.h"
#import "NCHNavigationController.h"

@class NCHNavUIBaseViewController;
@protocol NCHNavUIBaseViewControllerDataSource <NSObject>

@optional
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(NCHNavUIBaseViewController *)navUIBaseViewController;
@end

@interface NCHNavUIBaseViewController : UIViewController <NCHNavigationBarDelegate, NCHNavigationBarDataSource, NCHNavUIBaseViewControllerDataSource>
/*默认的导航栏字体*/
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;
/**  */
//@property (weak, nonatomic) NCHNavigationBar *jk_navgationBar;
@end
