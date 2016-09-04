//
//  DiscoveryViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/1.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "LoginWebViewController.h"
#import "AESCrypt.h"
#import "TrendingViewController.h"
#import "ShowCasesViewController.h"
#import "NewsViewController.h"
#import "SearchViewController.h"
#import "GithubRankingViewController.h"
#import "GithubAwardsViewController.h"


@interface DiscoveryViewController()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * tableViewOne;
    NSString * currentLogin;
}

@end
@implementation DiscoveryViewController
#pragma mark - lifeCycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
    currentLogin =[[NSUserDefaults standardUserDefaults]objectForKey:@"currentLogin"];

}
-(void)viewWillDisappear:(BOOL)animated{
    //    [activityIndicator removeFromSuperview];

}
-(void)viewDidLoad{
    [super viewDidLoad ];
    self.automaticallyAdjustsScrollViewInsets =NO;

    self.view.backgroundColor =[UIColor whiteColor];
//title
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth -120)/2, 0, 120, 44)];
    titleLabel.text =NSLocalizedString(@"Discovery", @"");
    titleLabel.backgroundColor =[UIColor clearColor];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font =[UIFont systemFontOfSize:19.0];
    self.navigationItem.titleView =titleLabel;

//tableView
    tableViewOne =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) style:UITableViewStyleGrouped];
    [self.view addSubview:tableViewOne];
    tableViewOne.delegate =self;
    tableViewOne.dataSource =self;


}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning ];
    
}
#pragma mark -Actions
-(void)loginAction{
    NSHTTPCookie * HTTPCookie;
    NSHTTPCookieStorage *HTTPCookieStorage =[NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (HTTPCookie in [HTTPCookieStorage cookies]) {
        [HTTPCookieStorage deleteCookie:HTTPCookie];
    }
    // 缓存 清除
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    LoginWebViewController * loginWebViewController =[[LoginWebViewController  alloc]init];
    loginWebViewController.urlString = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize/?client_id=%@&state=1995&redirect_uri=https://github.com/coderyi/monkey&scope=user,public_repo",[[AESCrypt decrypt:CoderyiClientID password:@"xxxsd-sdsd*sd672323q___---_w.."]substringFromIndex:1] ] ;
    loginWebViewController.callback=^(NSString *code){
        [self getUserInfoAction];
    };
    [self presentViewController:loginWebViewController animated:YES completion:nil];
}
-(void)getUserInfoAction{
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    if (token.length<1||!token) {
        return;
    }
    [ApplicationDelegate.apiEngine getUserInfoWithToken:nil completionHandler:^(UserModel *model) {
        if (model) {
            currentLogin = model.login;
            [[NSUserDefaults standardUserDefaults]setObject:currentLogin forKey:@"currentLogin"];
            [[NSUserDefaults standardUserDefaults]setObject:model.avatar_url forKey:@"currentAvatarUrl"];
            [tableViewOne reloadData];
        }
    } errorHandler:^(NSError *error) {

    }];

}

#pragma mark - UITableViewDatasource && Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseableIdentifier=@"reuseCellIdentifier";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.section) {
        case trendingType: {
            cell.textLabel.text =@"trending";
        }
            break;

        case showCasesType: {
            cell.textLabel.text =@"showcases";
        }
            break;

        case NewsType: {
            cell.textLabel.text =NSLocalizedString(@"News", @"");
        }
            break;

        case searchType: {
            cell.textLabel.text =NSLocalizedString(@"search", @"");
        }
            break;
        case githubRankingType: {
            cell.textLabel.text =@"githubRanking";
        }
            break;

        case github_awardsType: {
            cell.textLabel.text =@"github-awards";
        }
            break;

            default:
            break;
    }


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     switch (indexPath.section) {
        case trendingType: {
            TrendingViewController * trendingViewController  =[[TrendingViewController alloc]init];
            [self.navigationController pushViewController:trendingViewController animated:YES];

              }
            break;

        case showCasesType: {
            ShowCasesViewController * showCasesViewController =[[ShowCasesViewController alloc]init];
            [self.navigationController pushViewController:showCasesViewController animated:YES];
              }
            break;

        case NewsType: {
            if (currentLogin) {
                NewsViewController *newsViewController = [[NewsViewController alloc]init];
                [self.navigationController pushViewController:newsViewController animated:YES];

            } else {
                NSString *cancelButtonTitle = @"cancel";
                NSString *destructiveButtonTitle =@"Sure";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"login" message:@"please login" preferredStyle:UIAlertControllerStyleAlert];
                // Create the actions.
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

                }];

                UIAlertAction *loginAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    [self loginAction];
                }];
                [alertController addAction:cancelAction];
                [alertController addAction: loginAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
             }
            break;

        case searchType: {
            SearchViewController *searchViewController =[[SearchViewController alloc]init];
            [self.navigationController pushViewController:searchViewController animated:YES];
                }
            break;

        case githubRankingType: {
            GithubRankingViewController * gitHubRankingViewController =[[GithubRankingViewController alloc]init];
            [self.navigationController pushViewController:gitHubRankingViewController  animated:YES];
              }

            break;

        case github_awardsType: {
            GithubAwardsViewController * githubAwardsViewController =[[GithubAwardsViewController alloc]init];
            [self.navigationController pushViewController:githubAwardsViewController  animated:YES];
               }
            break;
            default:
            break;
    }
}







@end
