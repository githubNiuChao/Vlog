//
//  NCHTextViewController.h
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/26.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "NCHNavUIBaseViewController.h"
#import "NCHNavUIBaseViewController.h"

@class NCHTextViewController;
@protocol NCHTextViewControllerDataSource <NSObject>

@optional
- (UIReturnKeyType)textViewControllerLastReturnKeyType:(NCHTextViewController *)textViewController;

- (BOOL)textViewControllerEnableAutoToolbar:(NCHTextViewController *)textViewController;

//  控制是否可以点击点击的按钮
- (NSArray <UIButton *> *)textViewControllerRelationButtons:(NCHTextViewController *)textViewController;

@end


@protocol NCHTextViewControllerDelegate <UITextViewDelegate, UITextFieldDelegate>

@optional
#pragma mark - 最后一个输入框点击键盘上的完成按钮时调用
- (void)textViewController:(NCHTextViewController *)textViewController inputViewDone:(id)inputView;
@end

@interface NCHTextViewController : NCHNavUIBaseViewController<NCHTextViewControllerDataSource, NCHTextViewControllerDelegate>

- (BOOL)textFieldShouldClear:(UITextField *)textField NS_REQUIRES_SUPER;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string NS_REQUIRES_SUPER;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_REQUIRES_SUPER;
- (BOOL)textFieldShouldReturn:(UITextField *)textField NS_REQUIRES_SUPER;


@end




#pragma mark - design UITextField
IB_DESIGNABLE
@interface UITextField (NCHTextViewController)

@property (assign, nonatomic) IBInspectable BOOL isEmptyAutoEnable;

@end


@interface NCHTextViewControllerTextField : UITextField

@end





