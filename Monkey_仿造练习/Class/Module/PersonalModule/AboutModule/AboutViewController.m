//
//  aboutViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/2.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController
-(void)viewDidLoad{
    [super viewDidLoad ];
    self.view.backgroundColor =[UIColor whiteColor];

    UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/2, ScreenWidth, 30)];
    Label.text =@"原作者 coderyi,我学习他的源码";
    Label.textColor=YiTextGray;
    Label.textAlignment=NSTextAlignmentCenter;
    Label.font =[UIFont systemFontOfSize:16];
    Label.numberOfLines =0;
    [self.view addSubview:Label];


}

@end
