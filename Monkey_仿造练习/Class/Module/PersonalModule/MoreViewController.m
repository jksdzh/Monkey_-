//
//  MoreViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/1.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "MoreViewController.h"
#import "LoginWebViewController.h"
#import "AESCrypt.h"
#import "UIImageView+WebCache.h"
#import "UserDetailViewController.h"
#import "AboutViewController.h"
//#import "UMFeedback.h"
#import "NEHTTPEyeViewController.h"


@interface MoreViewController()<UITableViewDelegate,UITableViewDataSource>{
    UITableView * tableViewOne;
    UILabel * titleText;
    NSString * currentLogin;
    NSString * currentAvatarUrl;

}

@end
@implementation MoreViewController
#pragma mark - lifeCycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //TODO:
    [self getUserInfoAction];
    currentLogin = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentAvatarUrl"];
    [tableViewOne reloadData];

}
-(void)viewWillDisappear:(BOOL)animated{

}
-(void)viewDidLoad{
    [super viewDidLoad ];
    self.view.backgroundColor =[UIColor whiteColor];
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight ;
    }
    self.automaticallyAdjustsScrollViewInsets =NO;
//titleText
    titleText = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth -120)/2, 0, 120, 44)];
    titleText.backgroundColor =[UIColor clearColor];
    titleText.textColor =[UIColor whiteColor];
    titleText.font =[UIFont systemFontOfSize:19.0];
    titleText.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView =titleText;
    titleText.text =NSLocalizedString(@"More", nil);
//tableView
    tableViewOne =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49) style:UITableViewStyleGrouped ];


    tableViewOne.delegate =self;
    tableViewOne.dataSource =self;
    [self.view addSubview:tableViewOne];


}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning ];
    
}
#pragma mark - loginModule
/**
 *  https://developer.github.com/v3/oauth/#redirect-users-to-request-github-access
 */
-(void)oauth2LoginAction{
    //cookie清除
    NSHTTPCookie * httpCookie;
    NSHTTPCookieStorage *httpCookieStorage =
    [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (httpCookie in [httpCookieStorage cookies]) {
        [ httpCookieStorage deleteCookie:httpCookie];
    }
    // 缓存 清除
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    LoginWebViewController * loginWebViewController = [[LoginWebViewController alloc]init];
    loginWebViewController.urlString = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize/?client_id=%@&state=1995&redirect_uri=https://github.com/coderyi/monkey&scope=user,public_repo",[[AESCrypt decrypt:CoderyiClientID password:@"xxxsd-sdsd*sd672323q___---_w.."] substringFromIndex:1]];
    loginWebViewController.callback =^(NSString *code){
        [self getUserInfoAction];
    };
    [self presentViewController:loginWebViewController animated:YES completion:nil];
}

-(void)getUserInfoAction{
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    if (token.length <1||!token) {
        return;

    }
    [ApplicationDelegate.apiEngine getUserInfoWithToken:nil completionHandler:^(UserModel *model) {
        if (model) {
            currentLogin =model.login;
            currentAvatarUrl =model.avatar_url;
            [[NSUserDefaults standardUserDefaults]setObject:currentLogin forKey:@"currentLogin"];
            [[NSUserDefaults standardUserDefaults]setObject:currentAvatarUrl forKey:@"currentAvatarUrl"];
            [tableViewOne reloadData];
        }
    } errorHandler:^(NSError *error) {

    }];

}
#pragma mark - UITableViewDataSource &UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
#if defined(DEBUG)||defined(_DEBUG)
    if (currentLogin) {
        return 5;
    }
    return 4;
#else
    if (currentLogin) {
        return 4;
    }
    return 3;
#endif
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseableIdentifier=@"cellIdentifier";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];


        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
#if defined(DEBUG)||defined(_DEBUG)
    switch (indexPath.section) {
        case loginSection:
            if (currentLogin) {
                cell.textLabel.text =currentLogin;
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:currentAvatarUrl]];
            }else{
                cell.textLabel.text =NSLocalizedString(@"login", @"");
            }
            break;
        case aboutSection:
            cell.textLabel.text =NSLocalizedString(@"about", @"");
            break;
        case feedBackSection:
            cell.textLabel.text =NSLocalizedString(@"feedback", @"");

            break;
        case netWorkDebugSection:
            cell.textLabel.text =@"Network Debug";
            break;

        default:
            break;
    }
    if (currentLogin) {
        if (indexPath.section ==logOutSeciton) {
            cell.textLabel.text =NSLocalizedString(@"logout", @"");
        }
    }
    //loginSection
#else
    switch (indexPath.section ) {
        case loginSection:
            if (currentLogin) {
                cell.textLabel.text =currentLogin;
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:currentAvatarUrl]];
            }else{
                cell.textLabel.text =NSLocalizedString(@"login", @"");
            }
            break;
        case aboutSection:
            cell.textLabel.text =NSLocalizedString(@"about", @"");
            break;
        case feedBackSection:
            cell.textLabel.text =NSLocalizedString(@"feedback", @"");
            break;

        default:
            break;
    }
    if (currentLogin) {
        if (indexPath.section ==netWorkDebugSection) {
            cell.textLabel.text =NSLocalizedString(@"logout", @"");
        }
    }
#endif
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
         AboutViewController * aboutViewController =[[AboutViewController alloc]init];
    NEHTTPEyeViewController *httpEyeViewController =
    [[NEHTTPEyeViewController alloc]init];
#if defined(DEBUG) ||defined(_DEBUG)


    switch (indexPath.section) {
        case loginSection:
            if (currentLogin) {
                UserDetailViewController * userDetailViewController = [[UserDetailViewController alloc]init];
                UserModel * userModel =[[UserModel alloc]init];
                userModel.login =currentLogin;
                userDetailViewController.userModel =userModel;
                [self.navigationController  pushViewController:userDetailViewController animated:YES];
            }else{
                [self oauth2LoginAction];
            }

            break;
        case aboutSection:
            [self.navigationController pushViewController:aboutViewController animated:YES];

            break;
        case  feedBackSection:
#pragma clang diagnostic push   
//#pragma clang diagnostic ignored "-Wdeprecated-declaretions"
//            [self presentViewController:[UMFeedback feedbackViewController] animated:YES completion:nil];
#pragma clang diagnostic pop
            break;
            case  netWorkDebugSection:
    #if defined(DEBUG)||defined(_DUBUG)

            [self presentViewController:httpEyeViewController animated:YES completion:nil];
    #endif
            break;
        default:
            break;
    }
    if (currentLogin) {
        if (indexPath.section ==logOutSeciton) {
            NSString *cancelButtonTitle = @"取消";
            NSString *destructiveButtonTitle =@"确定";

            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定退出登录?" preferredStyle:UIAlertControllerStyleAlert];

            // Create the actions.
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"The \"Okay/Cancel\" alert action sheet's cancel action occured.");
            }];

            UIAlertAction *logOutAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                currentLogin =nil;
                currentAvatarUrl =nil;
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"currentLogin"];
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"currentAvatarUrl"];
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"access_token"];
                [tableView reloadData];
            }];

            [alertController addAction:cancelAction];
            [alertController addAction: logOutAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }

    }
#else
    switch (indexPath.section) {
        case loginSection:
            if (currentLogin) {
                UserDetailViewController * userDetaiViewController =[[UserDetailViewController alloc]init];
                UserModel *userModel =[[UserModel alloc]init];
                userModel.login  =currentLogin;
                userDetaiViewController.userModel =userModel;
                [self.navigationController pushViewController:userDetaiViewController animated:YES];
            }else{
                [self oauth2LoginAction];
            }
            break;
        case aboutSection:
            [self.navigationController pushViewController:aboutViewController animated:YES];

            break;
        case feedBackSection:
#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [self presentViewController:[UMFeedback feedbackViewController] animated:YES completion:nil];
#pragma clang diagnostic pop

            break;


        default:
            break;
    }

    if (currentLogin) {
        if (indexPath.section ==3) {
            NSString *cancelButtonTitle = @"取消";
            NSString *destructiveButtonTitle =@"确定";

            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"退出登录?" preferredStyle:UIAlertControllerStyleAlert];

            // Create the actions.
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"The \"Okay/Cancel\" alert action sheet's cancel action occured.");
            }];

            UIAlertAction *logOutAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                currentLogin =nil;
                currentAvatarUrl =nil;
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"currentLogin"];
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"currentAvatarUrl"];
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"access_token"];
                [tableView reloadData];


            }];

            [alertController addAction:cancelAction];
            [alertController addAction: logOutAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
#endif

}









@end
