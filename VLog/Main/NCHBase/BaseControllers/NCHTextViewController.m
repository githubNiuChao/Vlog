//
//  NCHTextViewController.m
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/4/26.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "NCHTextViewController.h"
#import "IQUIView+Hierarchy.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"

@interface NCHTextViewController ()
/** <#digest#> */
@property (nonatomic, strong) NSArray<UITextField *> *requiredTextFields;

/** <#digest#> */
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;

@end

@implementation NCHTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initKeyboard];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (_returnKeyHandler) {
        [_returnKeyHandler setDelegate:nil];
        _returnKeyHandler = nil;
    }
}

#pragma mark - UITextViewDelegate, UITextFieldDelegate

#pragma mark - 处理 returnKey
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (![IQKeyboardManager sharedManager].canGoNext) {
        [self textViewController:self inputViewDone:textField];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (![IQKeyboardManager sharedManager].canGoNext && [text isEqualToString:@"\n"]) {
        [self textViewController:self inputViewDone:textView];
    }
    return YES;
}

#pragma mark - NCHTextViewControllerDelegate
- (void)textViewController:(NCHTextViewController *)textViewController inputViewDone:(id)inputView {
    NSLog(@"%@, %@", self.requiredTextFields, inputView);
}

#pragma mark - autoEmpty

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 九宫格 bug fix
    if ([@"➋➌➍➎➏➐➑➒" rangeOfString:string].location != NSNotFound) {
        return YES;
    }
    NSString *current = [textField.text stringByReplacingCharactersInRange:range withString:string.jk_trimmingWhitespace].jk_trimmingWhitespace;
    
    if (textField.isEmptyAutoEnable && (kObjcIsEmpty(textField.text.jk_trimmingWhitespace) || kObjcIsEmpty(current))) {
        if (kObjcIsEmpty(current)) {
            [self checkIsEmpty:YES textField:textField];
        }else
        {
            [self checkIsEmpty:NO textField:textField];
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (textField.isEmptyAutoEnable) {
        [self checkIsEmpty:YES textField:textField];
    }
    return YES;
}


#pragma mark - 设置 btn的 enable
- (void)checkIsEmpty:(BOOL)isEmpty textField:(UITextField *)textField {
    if (kObjcIsEmpty(self.requiredTextFields)) {
        return;
    }
    
    if ([self respondsToSelector:@selector(textViewControllerRelationButtons:)]) {
        if (kObjcIsEmpty([self textViewControllerRelationButtons:self])) {
            return;
        }
    }else
    {
        return;
    }
    
    __block BOOL isButtonEnabled = !isEmpty;
    
    if (!isEmpty) {
        [self.requiredTextFields enumerateObjectsUsingBlock:^(UITextField *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj != textField && kObjcIsEmpty(obj.text.jk_trimmingWhitespace)) {
                isButtonEnabled = NO;
                *stop = YES;
            }
        }];
    }
    
    [[self textViewControllerRelationButtons:self] enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.enabled = isButtonEnabled;
    }];
}



#pragma mark - 初始化
- (void)initKeyboard {
    // 键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = [self textViewControllerEnableAutoToolbar:self];
    manager.shouldPlayInputClicks = YES;
    manager.shouldShowToolbarPlaceholder = YES;
//    manager.toolbarTintColor = kCOLOR_THEME;
    
    [self requiredTextFields];
    [self initReturnKeyHandler];;
}



#pragma mark - NCHTextViewControllerDataSource

- (BOOL)textViewControllerEnableAutoToolbar:(NCHTextViewController *)textViewController
{
    return YES;
}

- (UIReturnKeyType)textViewControllerLastReturnKeyType:(NCHTextViewController *)textViewController
{
    return UIReturnKeyDone;
}


- (NSArray<UITextField *> *)requiredTextFields {
    if(_requiredTextFields == nil)
    {
        NSArray *responsedInputViews = [self.view deepResponderViews];
        NSMutableArray<UITextField *> *array = [NSMutableArray array];
        [responsedInputViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[UITextField class]]) {
                
                UITextField *field = (UITextField *)obj;
                field.delegate = self;
                
                if (field.isEmptyAutoEnable) {
                    [array addObject:field];
                }
            }
            
            if ([obj isKindOfClass:[UITextView class]]) {
                UITextView *textView = (UITextView *)obj;
                textView.delegate = self;
            }
        }];
        
        _requiredTextFields = array;
    }
    return _requiredTextFields;
}


- (void)initReturnKeyHandler {
    if(_returnKeyHandler == nil) {
        _returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
        _returnKeyHandler.delegate = self;
        _returnKeyHandler.lastTextFieldReturnKeyType = [self textViewControllerLastReturnKeyType:self];
    }
}


- (void)dealloc
{
    _returnKeyHandler = nil;
}

@end



#pragma mark - NCHTextViewControllerTextField

static void *isEmptyAutoEnableKey = &isEmptyAutoEnableKey;
@implementation UITextField (NCHTextViewController)

- (void)setIsEmptyAutoEnable:(BOOL)isEmptyAutoEnable
{
    
    [self jk_associateValue:@(isEmptyAutoEnable) withKey:isEmptyAutoEnableKey];
}

- (BOOL)isEmptyAutoEnable
{
    return [(NSNumber *)[self jk_associatedValueForKey:isEmptyAutoEnableKey] boolValue];
}
@end

@implementation NCHTextViewControllerTextField
- (NSString *)text {
    return ([[super text] jk_trimmingWhitespace]);
}
@end
