// Generated by Apple Swift version 5.6 (swiftlang-5.6.0.323.62 clang-1316.0.20.8)
#ifndef WEATHERTODAY_SWIFT_H
#define WEATHERTODAY_SWIFT_H
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(ns_consumed)
# define SWIFT_RELEASES_ARGUMENT __attribute__((ns_consumed))
#else
# define SWIFT_RELEASES_ARGUMENT
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#if !defined(SWIFT_EXTERN)
# if defined(__cplusplus)
#  define SWIFT_EXTERN extern "C"
# else
#  define SWIFT_EXTERN extern
# endif
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import CoreGraphics;
@import CoreLocation;
@import Foundation;
@import ObjectiveC;
@import UIKit;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="WeatherToday",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

@class UIApplication;
@class UISceneSession;
@class UISceneConnectionOptions;
@class UISceneConfiguration;

SWIFT_CLASS("_TtC12WeatherToday11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable)launchOptions SWIFT_WARN_UNUSED_RESULT;
- (UISceneConfiguration * _Nonnull)application:(UIApplication * _Nonnull)application configurationForConnectingSceneSession:(UISceneSession * _Nonnull)connectingSceneSession options:(UISceneConnectionOptions * _Nonnull)options SWIFT_WARN_UNUSED_RESULT;
- (void)application:(UIApplication * _Nonnull)application didDiscardSceneSessions:(NSSet<UISceneSession *> * _Nonnull)sceneSessions;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12WeatherToday7BaseAPI")
@interface BaseAPI : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class UIViewController;
@class NSString;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC12WeatherToday6BaseNC")
@interface BaseNC : UINavigationController
- (nonnull instancetype)initWithRootViewController:(UIViewController * _Nonnull)rootViewController OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)viewDidLoad;
- (void)pushViewController:(UIViewController * _Nonnull)viewController animated:(BOOL)animated;
- (void)setViewControllers:(NSArray<UIViewController *> * _Nonnull)viewControllers animated:(BOOL)animated;
- (nonnull instancetype)initWithNavigationBarClass:(Class _Nullable)navigationBarClass toolbarClass:(Class _Nullable)toolbarClass SWIFT_UNAVAILABLE;
@end


@interface BaseNC (SWIFT_EXTENSION(WeatherToday)) <UINavigationControllerDelegate>
- (void)navigationController:(UINavigationController * _Nonnull)_ willShowViewController:(UIViewController * _Nonnull)viewController animated:(BOOL)_;
- (void)navigationController:(UINavigationController * _Nonnull)_ didShowViewController:(UIViewController * _Nonnull)viewController animated:(BOOL)_;
@end


SWIFT_CLASS("_TtC12WeatherToday22BaseNibLoadableControl")
@interface BaseNibLoadableControl : UIControl
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12WeatherToday19BaseNibLoadableView")
@interface BaseNibLoadableView : UIView
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12WeatherToday18BaseViewController")
@interface BaseViewController : UIViewController
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSNotification;

SWIFT_CLASS("_TtC12WeatherToday6BaseVC")
@interface BaseVC : BaseViewController
- (nonnull instancetype)init;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)loadingEndedWithNot:(NSNotification * _Nonnull)_;
- (void)closePageForSelector;
- (IBAction)closePage;
@end



@class UILabel;
@class UIImageView;

SWIFT_CLASS("_TtC12WeatherToday18DailyTableViewCell")
@interface DailyTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified dayLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified lowTempLabel;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified weatherTypeImageView;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified highTempLabel;
- (void)awakeFromNib;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end




SWIFT_CLASS("_TtC12WeatherToday13EmptyResponse")
@interface EmptyResponse : NSObject
@property (nonatomic) NSInteger statusCode;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12WeatherToday12ErrorMessage")
@interface ErrorMessage : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12WeatherToday21ForecastTableViewCell")
@interface ForecastTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified dayLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified tempLabel;
- (void)awakeFromNib;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER SWIFT_AVAILABILITY(ios,introduced=3.0);
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end



SWIFT_CLASS("_TtC12WeatherToday24HourlyCollectionViewCell")
@interface HourlyCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified hourLabel;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified weatherTypeImageView;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified tempratureLabel;
- (void)awakeFromNib;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12WeatherToday9LandingVC")
@interface LandingVC : BaseViewController
- (IBAction)getWeather:(id _Nonnull)sender;
- (IBAction)getLandingPage:(id _Nonnull)sender;
- (IBAction)popUp:(id _Nonnull)sender;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end



SWIFT_CLASS("_TtC12WeatherToday16LandingWelcomeVC")
@interface LandingWelcomeVC : BaseViewController
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified landingWelcomeLabel;
- (IBAction)getLandingWelcome2Page:(id _Nonnull)sender;
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


@class CLLocationManager;
@class CLLocation;

SWIFT_CLASS("_TtC12WeatherToday17MDLocationManager")
@interface MDLocationManager : NSObject <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager * _Nonnull)_ didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations;
- (void)locationManager:(CLLocationManager * _Nonnull)_ didFailWithError:(NSError * _Nonnull)_;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIPanGestureRecognizer;
@class UIGestureRecognizer;

SWIFT_CLASS("_TtC12WeatherToday27ModalPresentationController")
@interface ModalPresentationController : UIPresentationController
- (nonnull instancetype)initWithPresentedViewController:(UIViewController * _Nonnull)presentedViewController presentingViewController:(UIViewController * _Nullable)presentingViewController OBJC_DESIGNATED_INITIALIZER;
- (void)onPanWithPan:(UIPanGestureRecognizer * _Nonnull)pan;
- (void)presentationTransitionWillBegin;
- (void)dismissalTransitionWillBegin;
@property (nonatomic, readonly) CGRect frameOfPresentedViewInContainerView;
- (void)dismissSelfWithGesture:(UIGestureRecognizer * _Nonnull)_;
@end

@protocol UIViewControllerContextTransitioning;

SWIFT_CLASS("_TtC12WeatherToday23ModalTransitionAnimator")
@interface ModalTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)_ SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC12WeatherToday26ModalTransitioningDelegate")
@interface ModalTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>
- (id <UIViewControllerAnimatedTransitioning> _Nullable)animationControllerForDismissedController:(UIViewController * _Nonnull)_ SWIFT_WARN_UNUSED_RESULT;
- (UIPresentationController * _Nullable)presentationControllerForPresentedViewController:(UIViewController * _Nonnull)presented presentingViewController:(UIViewController * _Nullable)presenting sourceViewController:(UIViewController * _Nonnull)_ SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


@class UITouch;
@class UIEvent;
@class SCLButton;
@class UITapGestureRecognizer;

SWIFT_CLASS("_TtC12WeatherToday12SCLAlertView")
@interface SCLAlertView : UIViewController
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)_ OBJC_DESIGNATED_INITIALIZER SWIFT_UNAVAILABLE;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (void)viewWillLayoutSubviews;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)touchesEnded:(NSSet<UITouch *> * _Nonnull)_ withEvent:(UIEvent * _Nullable)event;
- (void)buttonTapped:(SCLButton * _Nonnull)btn;
- (void)buttonTapDown:(SCLButton * _Nonnull)btn;
- (void)buttonRelease:(SCLButton * _Nonnull)btn;
- (void)keyboardWillShow:(NSNotification * _Nonnull)notification;
- (void)keyboardWillHide:(NSNotification * _Nonnull)_;
- (void)tapped:(UITapGestureRecognizer * _Nonnull)gestureRecognizer;
- (void)updateShowTimeout;
- (void)hideView;
- (void)hideViewTimeout;
@end



SWIFT_CLASS("_TtC12WeatherToday20SCLAlertViewStyleKit")
@interface SCLAlertViewStyleKit : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12WeatherToday9SCLButton")
@interface SCLButton : UIButton
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
@end

@class UIWindow;
@class UIScene;

SWIFT_CLASS("_TtC12WeatherToday13SceneDelegate")
@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (void)scene:(UIScene * _Nonnull)scene willConnectToSession:(UISceneSession * _Nonnull)session options:(UISceneConnectionOptions * _Nonnull)connectionOptions;
- (void)sceneDidDisconnect:(UIScene * _Nonnull)scene;
- (void)sceneDidBecomeActive:(UIScene * _Nonnull)scene;
- (void)sceneWillResignActive:(UIScene * _Nonnull)scene;
- (void)sceneWillEnterForeground:(UIScene * _Nonnull)scene;
- (void)sceneDidEnterBackground:(UIScene * _Nonnull)scene;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12WeatherToday27SecurityQuestionInfoPopUpVC")
@interface SecurityQuestionInfoPopUpVC : BaseVC
@property (nonatomic, strong) IBOutlet UILabel * _Null_unspecified infoMesage;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (IBAction)createSecurityQuestion;
- (IBAction)createAfter;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end







@interface UINavigationController (SWIFT_EXTENSION(WeatherToday))
@property (nonatomic, readonly, strong) UIViewController * _Nullable childViewControllerForStatusBarStyle;
@end





@class UIColor;

@interface UIView (SWIFT_EXTENSION(WeatherToday))
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor * _Nonnull borderUIColor;
@property (nonatomic) IBInspectable BOOL masksToBounds;
@property (nonatomic) IBInspectable CGFloat zPosition;
@property (nonatomic, copy) IBInspectable NSString * _Nullable testAutomationIdentifier;
@property (nonatomic, strong) IBInspectable UIColor * _Nonnull shadowColor;
@property (nonatomic) IBInspectable float shadowOpacity;
@property (nonatomic) IBInspectable CGFloat shadowRadius;
@property (nonatomic) IBInspectable CGSize shadowOffset;
@end


@interface UIViewController (SWIFT_EXTENSION(WeatherToday))
- (void)customBackButtonPressed;
@end

@class NSURLSession;
@class NSURLAuthenticationChallenge;
@class NSURLCredential;

SWIFT_CLASS("_TtC12WeatherToday27URLSessionSSLPinnigDelegate")
@interface URLSessionSSLPinnigDelegate : NSObject <NSURLSessionDelegate>
- (void)URLSession:(NSURLSession * _Nonnull)_ didReceiveChallenge:(NSURLAuthenticationChallenge * _Nonnull)challenge completionHandler:(void (^ _Nonnull)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


@class UITableView;
@class UICollectionView;

SWIFT_CLASS("_TtC12WeatherToday9WeatherVC")
@interface WeatherVC : BaseViewController
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified cityNameLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified weatherTypeLabel;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified weatherImageView;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified currentCityTempLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified currentDateLabel;
@property (nonatomic, weak) IBOutlet UITableView * _Null_unspecified tableView;
@property (nonatomic, weak) IBOutlet UICollectionView * _Null_unspecified collectionView;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified background;
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


@interface WeatherVC (SWIFT_EXTENSION(WeatherToday)) <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager * _Nonnull)manager didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations;
@end


@class NSIndexPath;

@interface WeatherVC (SWIFT_EXTENSION(WeatherToday)) <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView * _Nonnull)collectionView numberOfItemsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (UICollectionViewCell * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView cellForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
@end

@class UICollectionViewLayout;

@interface WeatherVC (SWIFT_EXTENSION(WeatherToday)) <UICollectionViewDelegateFlowLayout>
- (CGFloat)collectionView:(UICollectionView * _Nonnull)collectionView layout:(UICollectionViewLayout * _Nonnull)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (CGFloat)collectionView:(UICollectionView * _Nonnull)collectionView layout:(UICollectionViewLayout * _Nonnull)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (UIEdgeInsets)collectionView:(UICollectionView * _Nonnull)collectionView layout:(UICollectionViewLayout * _Nonnull)collectionViewLayout insetForSectionAtIndex:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
@end


@interface WeatherVC (SWIFT_EXTENSION(WeatherToday)) <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView SWIFT_WARN_UNUSED_RESULT;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
@end


#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
#endif
