//
//  CYLTabBarControllerConfig.m
//  Test
//
//  Created by vincent on 11/6/15.
//  Copyright © 2015 vincent. All rights reserved.
//

#import "CYLTabBarControllerConfig.h"
//View Controllers
#import "DataTableViewController.h"
#import "HomeViewController.h"
#import "InfoViewController.h"

@interface CYLTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation CYLTabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController
{
    if (_tabBarController == nil) {
        DataTableViewController *firstViewController = [[DataTableViewController alloc] initWithType:HEARTRATE];
        UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                       initWithRootViewController:firstViewController];
        
        InfoViewController *secondViewController = [[InfoViewController alloc] init];
        UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:secondViewController];
        
        DataTableViewController *thirdViewController = [[DataTableViewController alloc] initWithType:ENERGY];
        UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                       initWithRootViewController:thirdViewController];
        
        HomeViewController *homeViewController = [[HomeViewController alloc] init];
        UIViewController *homeNavigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:homeViewController];
        
        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
        
        
        [self setUpTabBarItemsAttributesForController:tabBarController];
        
        [tabBarController setViewControllers:@[
                                               homeNavigationController,
                                               firstNavigationController,
                                               thirdNavigationController,
                                               secondNavigationController,
                                               ]];
        
        // [[self class] customizeTabBarAppearance];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (void)setUpTabBarItemsAttributesForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict0 = @{
                            CYLTabBarItemTitle : @"Home",
                            CYLTabBarItemImage : @"home",
                            //CYLTabBarItemSelectedImage : @"energy_highlight",
                            };
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"Heartrate",
                            CYLTabBarItemImage : @"heartrate",
                            //CYLTabBarItemSelectedImage : @"heartrate_highlight",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"Info",
                            CYLTabBarItemImage : @"energy",
                            //CYLTabBarItemSelectedImage : @"energy_highlight",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"Energy",
                            CYLTabBarItemImage : @"energy",
                            //CYLTabBarItemSelectedImage : @"energy_highlight",
                            };
    NSArray *tabBarItemsAttributes = @[
                                       dict0,
                                       dict1,
                                       dict3,
                                       dict2
                                       ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

+ (void)customizeTabBarAppearance {
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateHighlighted];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor colorWithRed:26/255.0 green:163/255.0 blue:133/255.0 alpha:1] forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/5.0f, 49) withCornerRadius:0]];
    
    // set the bar background color
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background_ios7"]];
}

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

@end
