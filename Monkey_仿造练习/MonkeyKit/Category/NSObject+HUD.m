//
//  NSObject+HUD.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/30.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "NSObject+HUD.h"
UIAlertView * alertView;
@implementation NSObject (HUD)
- (void)showYiProgressHUD:(NSString *)title afterDelay:(NSTimeInterval)delay{
    [self showYiProgressHUD:title];
    [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(hideYiProgressHUD) userInfo:nil repeats:NO];

}
-(void)showYiProgressHUD:(NSString *)title{


    alertView = [[UIAlertView alloc] initWithTitle:@"" message:title delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];

}
-(void)hideYiProgressHUD{
    [self hideYiProgressHUD:nil];
}
-(void)hideYiProgressHUD:(NSTimer *)timer{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

@end
