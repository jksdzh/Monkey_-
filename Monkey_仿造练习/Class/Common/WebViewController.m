//
//  WebViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/29.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "WebViewController.h"
@interface WebViewController()<UIWebViewDelegate>
{
    UILabel * titleText;
    UIActivityIndicatorView * activityIndicator;
    UIWebView *webView;
    UIButton * backButton;
    UIButton * closeButton;
}

@end
@implementation WebViewController

#pragma mark - lifeCycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
//    self.navigationController.navigationBar.hidden =YES;

}
-(void)viewWillDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.hidden =NO;
    [activityIndicator removeFromSuperview];

}
-(void)backButtonClick{
    if (webView.canGoBack) {
        [webView goBack];
        self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:backButton],[[UIBarButtonItem alloc] initWithCustomView:closeButton]];
    } else{
        [self  closeButtonClick];
    }

}
-(void)closeButtonClick{
    [self.navigationController popViewControllerAnimated:YES];

}


-(void)viewDidLoad{
    [super viewDidLoad ];

    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight ;
    }

//titleText
    titleText = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth -120)/2, 0, 120, 44)];

    titleText.backgroundColor =[UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    titleText.textAlignment=NSTextAlignmentCenter;
    titleText.font =[UIFont systemFontOfSize:19.0];
    titleText.text =self.urlString;
    [self.view addSubview:titleText];

    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets =NO;
    //webView
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -64)];
    webView.delegate =self;
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString]]];
    [self.view addSubview:webView];
//activityIndicator
    activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(ScreenWidth -60, 0, 44, 44)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite; //default is white
    [self.navigationController.navigationBar addSubview:activityIndicator ];
//backButton
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0 , 30 , 30);
    [backButton setImage:[UIImage imageNamed:@"ic_arrow_back_white_48pt"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];



//closeButton
    closeButton =[UIButton buttonWithType:UIButtonTypeCustom];

    closeButton.frame = CGRectMake(0, 0 , 30 , 30);
    [closeButton setImage:[UIImage imageNamed:@"ic_cancel_white_48pt"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];

 self.navigationItem.leftBarButtonItems =@[[[UIBarButtonItem alloc] initWithCustomView:backButton]];





}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning ];

}

#pragma mark - uiwebViewDelegate


-(void)webViewDidStartLoad:(UIWebView *)webView{
    [activityIndicator startAnimating];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [activityIndicator stopAnimating];

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [activityIndicator stopAnimating];

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}






@end
