//
//  LoginWebViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/31.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "LoginWebViewController.h"
#import "NSObject+HUD.h"
#import "YiNetworkEngine.h"

@interface LoginWebViewController ()<UIWebViewDelegate>
{
    UILabel * titleText;
    UIButton * backButton;
}

@end
@implementation LoginWebViewController
-(void)viewDidLoad{
    [super viewDidLoad ];

    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets =NO;
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight ;
    }
    self.hidesBottomBarWhenPushed =YES;

    titleText = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth -120)/2, 0, 120, 44)];
    titleText.backgroundColor =[UIColor clearColor];
    titleText.textColor = [UIColor whiteColor];
    titleText.font =[UIFont systemFontOfSize:19.0];
    titleText.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView =titleText;
    titleText.text =self.urlString;

    UINavigationBar * navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    navigationBar.barTintColor = YiBlue;
    


    backButton =[UIButton buttonWithType:UIButtonTypeCustom];

    backButton.frame = CGRectMake(10, 27 , 30 , 30);
    [backButton setImage:[UIImage imageNamed:@"ic_arrow_back_white_48pt"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:backButton];
    backButton.hidden =YES;
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight -64)];
    webView.backgroundColor =[UIColor whiteColor];
    [self.view  addSubview:webView];
    [self.view insertSubview:navigationBar aboveSubview:webView];
    webView.delegate =self;
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString]]];
}
-(void)backButtonClick{
    self.callback(@"error");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning ];

}
#pragma mark - uiwebViewDelegate


-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self showYiProgressHUD:@"Login loading..."];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString * requestURL =webView.request.URL.absoluteString;
    [self hideYiProgressHUD];


    for (NSInteger i = 0; i <requestURL.length-5; i++) {
        if ([[requestURL  substringWithRange:NSMakeRange(i, 5)] isEqualToString:@"code="]) {
            backButton.hidden =YES;
            [self loginTokenClick:[requestURL substringWithRange:NSMakeRange(i +5,20)]];
            return;

        }
    }
    backButton.hidden =NO;

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self hideYiProgressHUD];
    backButton.hidden =NO;

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}



-(void)loginTokenClick:(NSString*)code{
    [self showYiProgressHUD:@"Login..."];
    YiNetworkEngine * apiEngine =[[ YiNetworkEngine alloc] initWithHostName:@"github.com"];
    [apiEngine loginWithCode:code completionHandler:^(NSString *response) {
        [self hideYiProgressHUD];
        for (NSInteger i = 0; i <response.length; i++) {
            if ([[response substringWithRange:NSMakeRange(i, 13)] isEqualToString:@"access_token="]) {
                NSString * token =[response substringWithRange:NSMakeRange(i+13, 40)];
[[NSUserDefaults standardUserDefaults]setObject:token forKey:@"access_token"];
                self.callback(@"success");
                [self dismissViewControllerAnimated:YES completion:nil];
                return ;

            }
        }
        backButton.hidden =NO;
    } errorHandler:^(NSError *error) {
        backButton.hidden =NO;
        [self hideYiProgressHUD];
    }];








}



@end
