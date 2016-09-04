//
//  NSObject+HUD.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/30.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (HUD)
/**
 *  showYiProgressHUD,and after delay time ,it will be hide
 *
 *  @param title  progressHUD title
 *  @param delay delay seconds
 */
-(void)showYiProgressHUD:(NSString*)title afterDelay:(NSTimeInterval)delay;
/**
 *  showYiProgressHUD
 *
 *  @param title progressHUD title
 */
-(void)showYiProgressHUD:(NSString*)title;
/**
 *  hide progress HUD
 */
-(void)hideYiProgressHUD;




@end
