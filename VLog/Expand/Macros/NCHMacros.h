//
//  NCHMacros.h
//  VLog
//
//  Created by szy on 2020/9/26.
//  Copyright © 2020 niuchao. All rights reserved.
//

#ifndef NCHMacros_h
#define NCHMacros_h
#import "NCHMacroTools.h"
#import <JKCategories/JKUIKit.h>

#pragma mark - 常用
#define NCWeakSelf(type)  __weak typeof(type) weak##type = type
#define NCStrongSelf(type)  __strong typeof(type) type = weak##type

//将“对象的属性”转换为“字符串”
#define NCKEY_PATH(objc, property) ((void)objc.property, @(#property))
//对象是否为空
#define kObjcIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

#define kApplication        [UIApplication sharedApplication]
#define kWindow             [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define kAppVersionCode ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

//校验URL
#define k_URL(kstr)    [NSURL URLWithString:[FMMacroKitTools fm_isContainChinese:kstr] ? [kstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] : kstr]

#define kAllocInitVC(objc)              objc *vc = [[objc alloc] init];
#define kAllocInit(objc,name)           objc *name = [[objc alloc] init];
#define kAllocViewControllerByStr(objc) UIViewController *vc = [[NSClassFromString(objc) alloc] init];
#define kPushToTheViewController(vc)    [self.navigationController pushViewController:vc animated:YES];
#define kNavTitle(text)                 self.navigationItem.title = text;
#define kNavTitleNoQuotes(_string_)     self.navigationItem.title = ((__bridge NSString *)CFSTR(#_string_));


#pragma mark - ------------状态栏 导航栏---------------
// 状态栏 导航栏 Tabbar高度
#pragma mark -  状态栏 导航栏 tabbar高度
/*状态栏高度*/
#define kStatusBarH (([NCHMacroTools isNotchScreen]) ? 44.0 : 20.0)
/*状态栏和导航栏总高度*/
#define kNavBarAllH ((([NCHMacroTools isNotchScreen]) ? 88.0 : 64.0) + kStatusBarHeight)
/*导航栏总高度*/
#define kNavBarH (([NCHMacroTools isNotchScreen]) ? 88.0 : 64.0)
/*TabBar高度*/
#define kTabbarH (([NCHMacroTools isNotchScreen]) ? 83.0 : 49.0)
/*顶部安全区域远离高度*/
#define kSafeHeightTopBar (CGFloat)(([NCHMacroTools isNotchScreen])?(44.0):(0))
/*底部安全区域远离高度*/
#define kSafeHeightBottom (CGFloat)(([NCHMacroTools isNotchScreen])?(34.0):(0))


//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

#pragma mark - ------------文件---------------
//Library/Caches 文件路径
#define kFilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]


#pragma mark - ------------字体---------------
//方正黑体简体字体定义
#define kNameFont(x) [UIFont fontWithName:@"FZHTJW--GB1-0" size:x]
//不同屏幕尺寸字体适配
#define SCREEN_WIDTHRatio  (UIScreen.mainScreen.bounds.size.width / 375.0)
#define SCREEN_HEIGHTRatio (UIScreen.mainScreen.bounds.size.height / 667.0)
#define kAdaptedWidth(x)  ceilf((x) * SCREEN_WIDTHRatio)
#define kAdaptedHeight(x) ceilf((x) * SCREEN_HEIGHTRatio)
#define kAdaptedFontSize(R)  [UIFont systemFontOfSize:kAdaptedWidth(R)]

#define kFontSmall [UIFont systemFontOfSize:12.0f]
#define kFontMedium [UIFont systemFontOfSize:14.0f]
#define kFontBig [UIFont systemFontOfSize:16.0f]

#define kFontBSmall [UIFont boldSystemFontOfSize:12.0f]
#define kFontBMedium [UIFont boldSystemFontOfSize:14.0f]
#define kFontBBig [UIFont boldSystemFontOfSize:16.0f]

// 颜色
#pragma mark - ------------颜色---------------
//主题色
#define kCOLOR_THEME kHexColor(E7414D)
// rgba颜色
#define kRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
// 随机色
#define kRandomColor  [UIColor colorWithRed:(arc4random_uniform(256))/255.0 green:arc4random_uniform(256)/255.0 blue:(arc4random_uniform(256))/255.0 alpha:1.0]
//16进制颜色
#define kHexColor(_hex_)  [UIColor jk_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]

#define kSysBGColor   [UIColor systemBackgroundColor]
#define kSysGroupBGColor   [UIColor systemGroupedBackgroundColor]

#define kGreyColor   [UIColor systemGrayColor]
#define kGreyColor2  [UIColor systemGray2Color]
#define kGreyColor3  [UIColor systemGray3Color]
#define kGreyColor4  [UIColor systemGray4Color]
#define kGreyColor5  [UIColor systemGray5Color]
#define kGreyColorN  [UIColor systemGray6Color]
#define kWhiteColor  [UIColor whiteColor]
#define kBlackColor  [UIColor blackColor]
#define kRedColor    [UIColor colorWithRed:0.878431 green:0.003922 blue:0.003922 alpha:1.0]
#define kOrangeColor [UIColor colorWithRed:0.949020 green:0.447059 blue:0.109804 alpha:1.0]
#define kBorderColor [UIColor colorWithRed:0.815686 green:0.815686 blue:0.815686 alpha:1.0]
#define KGreenColor  [UIColor colorWithRed:0.364706 green:0.635294 blue:0.215686 alpha:1.0]

// Property
#pragma mark - ------------属性---------------
#pragma mark - Property
#define kProNSString(str)                @property (nonatomic, copy) NSString *str;
#define KProNSArray(arr)                 @property (nonatomic, strong) NSArray *arr;
#define KProNSArrayType(type,arr)        @property (nonatomic, strong) NSArray <type * >*arr;
#define KProNSMutableArray(arr)          @property (nonatomic, strong) NSMutableArray *arr;
#define KProNSMutableArrayType(type,arr) @property (nonatomic, strong) NSMutableArray <type * >*arr;
#define KProNSDictionary(dic)            @property (nonatomic, strong) NSDictionary *dic;
#define KProStrongType(type,name)        @property (nonatomic, strong) type *name;
#define KProNSInteger(value)             @property (nonatomic, assign) NSInteger value;
#define KProAssignType(type,name)        @property (nonatomic, assign) type name;
#define KProCGFloat(value)               @property (nonatomic, assign) CGFloat value;
#define KProDouble(value)                @property (nonatomic, assign) double value;
#define KProBool(value)                  @property (nonatomic, assign) BOOL value;

// View 圆角和加边框
#pragma mark - 圆角和加边框
#define kViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]];
// View 圆角
#define kViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];
//区分四角
#define kViewSomeRadius(View, kRadius, isBottomLeft, isBottomRight, isTopLeft, isTopRight) \
\
UIRectCorner corner;\
if (isBottomLeft) corner = UIRectCornerBottomLeft;\
if (isBottomRight) corner = corner | UIRectCornerBottomRight;\
if (isTopLeft) corner = corner | UIRectCornerTopLeft;\
if (isTopRight) corner = corner | UIRectCornerTopRight;\
UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:View.bounds   byRoundingCorners:corner  cornerRadii:CGSizeMake(kRadius, kRadius)]; \
CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init]; \
maskLayer.frame = View.bounds; \
maskLayer.path = maskPath.CGPath;\
View.layer.mask = maskLayer;

#pragma mark - -------------------设备-------------------------
//获取屏幕 宽度、高度
#define kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// iPhone 手机型号
// 判断是否是 ipad
#define kIsPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
// 判断 iPhone6系列 kIsiPhone_6_6s_7_8
#define kIsiPhone_6_6s_7_8 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iphone6+系列 kiIsPhone_6p_6sp_7p_8p
#define kIsiPhone_6p_6sp_7p_8p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPhone X/Xs
#define kIsPhone_x_xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPHone Xr
#define kIsiPhone_xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPhone XsMax
#define kIsiPhone_xsmax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
// 是否是刘海屏
#define kIsiPhoneXLotsof (([NCHMacroTools isNotchScreen]) ? YES : NO)
//-------------------设备-------------------------


//----------------------系统----------------------------
//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//----------------------系统----------------------------

//----------------------内存----------------------------
//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif
#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

//释放一个对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }

#define SAFE_RELEASE(x) [x release];x=nil
//----------------------内存----------------------------


#pragma mark - ----------------------图片----------------------------
//读取本地图片
#define kFileImage(file) [UIImage jk_imageWithFileName:file]
#define kFileImageType(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]
#define kNameImage(_pointer) [UIImage imageNamed:_pointer]

//----------------------图片----------------------------


//----------------------其他----------------------------
//GCD
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//单例化一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

// 判断系统版本
#pragma mark - 判断系统版本
//
#define kSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
#define kiOS9Later (kSystemVersion >= 9)
#define kiOS10Later (kSystemVersion >= 10)
#define kiOS11Later (kSystemVersion >= 11)
#define kiOS12Later (kSystemVersion >= 12)



#pragma mark - -------------------日志-------------------------

//NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define DLog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define DLog(...)
#endif

#define ITTDEBUG
#define ITTLOGLEVEL_INFO     10
#define ITTLOGLEVEL_WARNING  3
#define ITTLOGLEVEL_ERROR    1

#ifndef ITTMAXLOGLEVEL

#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif

#endif

// The general purpose logger. This ignores logging levels.
#ifdef ITTDEBUG
#define ITTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ITTDPRINT(xx, ...)  ((void)0)
#endif

// Prints the current method's name.
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

// Log-level based logging macros.
#if ITTLOGLEVEL_ERROR <= ITTMAXLOGLEVEL
#define ITTDERROR(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDERROR(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_WARNING <= ITTMAXLOGLEVEL
#define ITTDWARNING(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDWARNING(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_INFO <= ITTMAXLOGLEVEL
#define ITTDINFO(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDINFO(xx, ...)  ((void)0)
#endif

#ifdef ITTDEBUG
#define ITTDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
ITTDPRINT(xx, ##__VA_ARGS__); \
} \
} ((void)0)
#else
#define ITTDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif

#define ITTAssert(condition, ...)                                       \
do {                                                                      \
if (!(condition)) {                                                     \
[[NSAssertionHandler currentHandler]                                  \
handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__]  \
lineNumber:__LINE__                                  \
description:__VA_ARGS__];                             \
}                                                                       \
} while(0)
//---------------------打印日志--------------------------


#endif /* NCHMacros_h */
