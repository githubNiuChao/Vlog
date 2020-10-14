//
//  NCHPopViewManager.m
//  VLog
//
//  Created by szy on 2020/10/13.
//  Copyright © 2020 niuchao. All rights reserved.
//

#import "NCHPopViewManager.h"
#import "NCHPopView.h"


@interface NCHPopViewManager ()

/** 内存储存popView */
@property (nonatomic,strong) NSMutableArray *popViewMarr;


@end


@implementation NCHPopViewManager

static NCHPopViewManager *_instance;


NCHPopViewManager *NCHPopViewM() {
    return [NCHPopViewManager sharedInstance];
}

+ (instancetype)sharedInstance {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}


+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (NSArray *)getAllPopView {
    return NCHPopViewM().popViewMarr;
}
/** 获取当前页面所有popView */
+ (NSArray *)getAllPopViewForParentView:(UIView *)view {
    NSMutableArray *mArr = NCHPopViewM().popViewMarr;
    NSMutableArray *resMarr = [NSMutableArray array];
    for (id obj in mArr) {
        NCHPopView *popView;
        if ([obj isKindOfClass:[NSValue class]]) {
            NSValue *resObj = (NSValue *)obj;
            popView  = resObj.nonretainedObjectValue;
        }else {
            popView  = (NCHPopView *)obj;
        }
        if ([popView.parentView isEqual:view]) {
            [resMarr addObject:obj];
        }
    }
    return [NSArray arrayWithArray:resMarr];
}

/** 获取所有popView 精准获取 */
/** 获取当前页面指定编队的所有popView */
+ (NSArray *)getAllPopViewForPopView:(NCHPopView *)popView {
    
    NSArray *mArr = [self getAllPopViewForParentView:popView.parentView];
    NSMutableArray *resMarr = [NSMutableArray array];
    for (id obj in mArr) {
        NCHPopView *tPopView;
        if ([obj isKindOfClass:[NSValue class]]) {
            NSValue *resObj = (NSValue *)obj;
            tPopView  = resObj.nonretainedObjectValue;
        }else {
            tPopView  = (NCHPopView *)obj;
        }
        
        if (popView.groupId == nil && tPopView.groupId == nil) {
            [resMarr addObject:obj];
            continue;
        }
        if ([tPopView.groupId isEqual:popView.groupId]) {
            [resMarr addObject:obj];
            continue;
        }
    }
    return [NSArray arrayWithArray:resMarr];
}

/** 读取popView */
+ (NCHPopView *)getPopViewForKey:(NSString *)key {
    
    return nil;
}

+ (void)savePopView:(NCHPopView *)popView {
    
    NSArray *arr = [self getAllPopView];
    for (id obj in arr) {
        NCHPopView *tPopView;
        if ([obj isKindOfClass:[NSValue class]]) {
            NSValue *resObj = (NSValue *)obj;
            tPopView  = resObj.nonretainedObjectValue;
        }else {
            tPopView  = (NCHPopView *)obj;
        }
        if ([tPopView isEqual:popView]) {
            break;
            return;
        }
    }
    
    if (popView.superview) {
        [NCHPopViewM().popViewMarr addObject:[NSValue valueWithNonretainedObject:popView]];
        
    }else {
        [NCHPopViewM().popViewMarr addObject:popView];
        
    }
    
    //优先级排序
    [self sortingArr];
    
}
//冒泡排序
+ (void)sortingArr{
    
    NSMutableArray *arr = NCHPopViewM().popViewMarr;
    
    for (int i = 0; i < arr.count; i++) {
        for (int j = i+1; j < arr.count; j++) {
            
            NCHPopView *iPopView;
            if ([arr[i] isKindOfClass:[NSValue class]]) {
                NSValue *resObj = (NSValue *)arr[i];
                iPopView  = resObj.nonretainedObjectValue;
                
            }else {
                iPopView  = (NCHPopView *)arr[i];
            }
            NCHPopView *jPopView;
            if ([arr[j] isKindOfClass:[NSValue class]]) {
                NSValue *resObj = (NSValue *)arr[j];
                jPopView  = resObj.nonretainedObjectValue;
                
            }else {
                jPopView  = (NCHPopView *)arr[j];
            }
            
            if (iPopView.priority > jPopView.priority) {
                [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
}

/** 弱化popView 仅供内部调用 */
+ (void)weakWithPopView:(NCHPopView *)popView {
    
    if (![NCHPopViewM().popViewMarr containsObject:popView]) {
        return;
    }
    
    NSUInteger index =  [NCHPopViewM().popViewMarr indexOfObject:popView];
    
    [NCHPopViewM().popViewMarr replaceObjectAtIndex:index withObject:[NSValue valueWithNonretainedObject:popView]];
    NSLog(@"%@",NCHPopViewM().popViewMarr);
}

/** 移除popView */
+ (void)removePopView:(NCHPopView *)popView {
    if (!popView) { return;}
    NSArray *arr = NCHPopViewM().popViewMarr;
    
    for (id obj in arr) {
        NCHPopView *tPopView;
        if ([obj isKindOfClass:[NSValue class]]) {
            NSValue *resObj = (NSValue *)obj;
            tPopView  = resObj.nonretainedObjectValue;
        }else {
            tPopView  = (NCHPopView *)obj;
        }
        if ([tPopView isEqual:popView]) {
            [NCHPopViewM().popViewMarr removeObject:obj];
            break;
            return;
        }
    }
}

/** 移除popView */
+ (void)removePopViewForKey:(NSString *)key {
    if (key.length<=0) { return;}
    NSArray *arr = NCHPopViewM().popViewMarr;
    
    for (id obj in arr) {
        NCHPopView *tPopView;
        if ([obj isKindOfClass:[NSValue class]]) {
            NSValue *resObj = (NSValue *)obj;
            tPopView  = resObj.nonretainedObjectValue;
        }else {
            tPopView  = (NCHPopView *)obj;
        }
        if ([tPopView.identifier isEqualToString:key]) {
            [NCHPopViewM().popViewMarr removeObject:obj];
            break;
            return;
        }
    }
}
/** 移除所有popView */
+ (void)removeAllPopView {
    NSMutableArray *arr = NCHPopViewM().popViewMarr;
    
    if (arr.count<=0) {return;}
    [arr removeAllObjects];
}

- (NSMutableArray *)popViewMarr {
    if(_popViewMarr) return _popViewMarr;
    _popViewMarr = [NSMutableArray array];
    return _popViewMarr;
}





@end

