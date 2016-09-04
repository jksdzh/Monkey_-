//
//  AppDelegate.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/25.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "AppDelegate.h"
#import "NEHTTPEye.h"
#import "JPFPSStatus.h"
#import "MKNetworkEngine+DefaultSet.h"
#import "UserRankViewController.h"
#import "UserDetailViewController.h"
#import "BaseNavigationController.h"
#import "RepositoriesViewController.h"
#import "DiscoveryViewController.h"
#import "MoreViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#if defined(DEBUG)||defined(_DEBUG)
    [NEHTTPEye setEnabled:NO];
#endif
    [self setUpTabBar];
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] openWithHandler:^(NSInteger fpsValue) {
//        NSLog(@"fps value %@",@(fpsValue));
    }];//show FPS Status on StatusBar

#endif
    self.apiEngine = [[YiNetworkEngine alloc]initWithDefaultSet];


    return YES;
}
-(BaseNavigationController *)initilizerNavigationoControllerWithRootViewController:(UIViewController *)rootViewController{
    return [[BaseNavigationController alloc] initWithRootViewController:rootViewController];
}
-(void)setUpTabBar{
//userRankViewController
    UserRankViewController * userRankViewController = [[UserRankViewController alloc]init];
    BaseNavigationController *navigationUserRank =[self initilizerNavigationoControllerWithRootViewController:userRankViewController];
    navigationUserRank.navigationBar.barTintColor =YiBlue;
    navigationUserRank.navigationBar.tintColor = [UIColor whiteColor];
    navigationUserRank.navigationBar.titleTextAttributes =[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
//repositoriesViewController
   RepositoriesViewController * repositoriesViewController = [[RepositoriesViewController  alloc]init];
     repositoriesViewController.navigationController.navigationBar.hidden =NO;
    
    BaseNavigationController *navigationRepositoriesController =[self initilizerNavigationoControllerWithRootViewController:repositoriesViewController];
    navigationRepositoriesController.navigationBar.barTintColor =YiBlue;
   navigationRepositoriesController.navigationBar.tintColor = [UIColor whiteColor];
    navigationRepositoriesController.navigationBar.titleTextAttributes =[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
//MoreViewController
    DiscoveryViewController * discoveryViewController = [[DiscoveryViewController  alloc]init];
    discoveryViewController.navigationController.navigationBar.hidden =NO;

    BaseNavigationController *navigationDiscoveryController =[self initilizerNavigationoControllerWithRootViewController:discoveryViewController];
    navigationDiscoveryController.navigationBar.barTintColor =YiBlue;
    navigationDiscoveryController.navigationBar.tintColor = [UIColor whiteColor];
    navigationDiscoveryController.navigationBar.titleTextAttributes =[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
//DiscoveryViewController
    MoreViewController * moreViewController = [[MoreViewController alloc]init];
    moreViewController.navigationController.navigationBar.hidden =NO;

    BaseNavigationController *navigationMoreController =[self initilizerNavigationoControllerWithRootViewController:moreViewController];
    navigationMoreController.navigationBar.barTintColor =YiBlue;
    navigationMoreController.navigationBar.tintColor = [UIColor whiteColor];
    navigationMoreController.navigationBar.titleTextAttributes =[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];

    UITabBarController *tabController = [[UITabBarController alloc]init];

    tabController.viewControllers = @[navigationUserRank,navigationRepositoriesController,navigationDiscoveryController,navigationMoreController];
    UITabBar *tabBar = tabController.tabBar;
    tabController.tabBar.backgroundColor = [UIColor whiteColor];
    tabController.tabBar.tintColor =YiBlue;
     UITabBarItem *tabBarItemOne = [tabBar.items objectAtIndex:0];
     UITabBarItem *tabBarItemTwo = [tabBar.items objectAtIndex:1];
     UITabBarItem *tabBarItemThree = [tabBar.items objectAtIndex:2];
     UITabBarItem *tabBarItemFour = [tabBar.items objectAtIndex:3];
    tabBarItemOne.title =@"Users";
    tabBarItemOne.image = [UIImage  imageNamed:@"github60"];
    tabBarItemTwo.title =@"Repositories";
    tabBarItemTwo.image =[UIImage imageNamed:@"github160"];
    tabBarItemThree.title =@"DIscovery";
    tabBarItemThree.image =[UIImage imageNamed:@"github60"];
    tabBarItemFour.title =@"More";
    tabBarItemFour.image =[UIImage imageNamed:@"more"];
    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    self.window.rootViewController =tabController;
    [self.window makeKeyAndVisible];



}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
