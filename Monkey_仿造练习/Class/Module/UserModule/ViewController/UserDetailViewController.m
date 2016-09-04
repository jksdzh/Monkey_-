//
//  UserDetailViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/26.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "UserDetailViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "DetailSegmentControl.h"
#import "UserDetailDataSource.h"
#import "UserDetailViewModel.h"
#import "WebViewController.h"
#import "NSObject+HUD.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "LoginWebViewController.h"
#import "AESCrypt.h"
#import "UIImageView+WebCache.h"
#import "RepositoryDetailViewController.h"

@interface UserDetailViewController()<UITableViewDelegate>
{
    UITableView *tableView;
    YiRefreshHeader *refreshHeader;
    YiRefreshFooter *refreshFooter;
    int currentIndex;
    UIImageView *titleImageView;
    UIButton *loginButton;
    UILabel *nameLabel;
    UILabel *createLabel;
    UILabel *companyLabel;
    UILabel *locationLabel;
    UIButton *emailButton;
    UIButton *blogButton;
    DetailSegmentControl *segmentControl;
    BOOL isFollowing;
    UserDetailDataSource *userDetailDataSource;
    UserDetailViewModel * userDetailViewModel;
    


}

@property (nonatomic,strong) DataSourceModel *repositoryDataSourceOfPageListObject;
@property (nonatomic,strong) DataSourceModel *followingDataSourceOfPageListObject;
@property (nonatomic,strong) DataSourceModel *followerDataSourceOfPageListObject;
@property (nonatomic,strong) MKNetworkOperation *apiOperation;

@end
@implementation UserDetailViewController

#pragma mark - LifeCycle
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ];
    if (self) {
        self.repositoryDataSourceOfPageListObject = [[DataSourceModel alloc]init];
        self.followingDataSourceOfPageListObject =[[DataSourceModel alloc]init];
        self.followerDataSourceOfPageListObject =
        [[DataSourceModel alloc]init];

    }
    return self;
}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated ];
//    self.navigationController.navigationBar.hidden =YES;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden =NO;
//
//}

-(void)viewDidLoad{
    [super viewDidLoad ];
    self.title =self.userModel.login;
    userDetailDataSource =[[UserDetailDataSource  alloc]init];
    userDetailViewModel = [[UserDetailViewModel alloc]init];
    userDetailViewModel.userModel =self.userModel;
    currentIndex =1;
    userDetailDataSource.currentIndex = currentIndex;
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.view.backgroundColor = [UIColor whiteColor];

    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -64) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate =self;
    tableView.dataSource =userDetailDataSource;
    tableView.rowHeight = RepositoriesTableViewCellheight;
    tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self addTableViewHeader];
    [self addTableViewFooter];
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 210+25-25-40)];
    UIView * titleBackGround = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150+35-35-40)];
    [titleView addSubview:titleBackGround];


    float originX = 10;
    float sufTitleImageViewSpace =10;
    float widthSpace =2;
    float originY =10;
    float titleImageViewWidth =50;
    float heightSpace = 0;
    float loginButtonWidth =110;
    float emailButtonWidth = ScreenWidth - originX *3 -titleImageViewWidth - loginButtonWidth -5;

    titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(originX, originY +5, titleImageViewWidth, titleImageViewWidth)];
    [titleBackGround addSubview:titleImageView];
    titleImageView.layer.masksToBounds =YES;
    titleImageView.layer.cornerRadius =11;
    titleImageView.layer.borderWidth = 0.3;
    titleImageView.layer.borderColor =YiGray.CGColor;

    //Event listeners
    titleImageView.tag =0;
    titleImageView.userInteractionEnabled =YES;
    [titleImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
//Content mode
    titleImageView.clipsToBounds =YES;
    titleImageView.contentMode =UIViewContentModeScaleAspectFill;
//login button
    loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(originX +sufTitleImageViewSpace +titleImageViewWidth, originY, loginButtonWidth, 30);
    loginButton.titleLabel.font =[UIFont systemFontOfSize:16];
    [loginButton setTitleColor:YiBlue forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [titleBackGround addSubview:loginButton];
    loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//nameLabel
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(originX +sufTitleImageViewSpace +titleImageViewWidth, originY +heightSpace +20, loginButtonWidth, 30)];
    nameLabel.textColor=YiTextGray;
    nameLabel.textAlignment=NSTextAlignmentLeft;
    nameLabel.font =[UIFont systemFontOfSize:14];
    [titleBackGround addSubview:nameLabel];

//createLabel

    createLabel = [[UILabel alloc]initWithFrame:CGRectMake(originX, originY +titleImageViewWidth +5, titleImageViewWidth +3, 30)];
    createLabel.font =[UIFont systemFontOfSize:9];
    [titleBackGround addSubview:createLabel];
//companyLabel
    companyLabel =[[UILabel alloc]initWithFrame:CGRectMake(originX +sufTitleImageViewSpace +titleImageViewWidth , originY +heightSpace *2 + 30 *2, emailButtonWidth, 30)];
    companyLabel.font =[UIFont systemFontOfSize:13];
    [titleBackGround addSubview:companyLabel];
//locationLabel
    locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(originX +sufTitleImageViewSpace +titleImageViewWidth +loginButtonWidth, originY +heightSpace *2 +30 *2, emailButtonWidth, 30)];
    [titleBackGround addSubview:locationLabel];

    emailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    emailButton.frame = CGRectMake(originX +widthSpace +sufTitleImageViewSpace +titleImageViewWidth +loginButtonWidth, originY, emailButtonWidth, 30);
    emailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [emailButton setTitleColor:YiBlue forState:UIControlStateNormal];

    emailButton.titleLabel.font =[UIFont systemFontOfSize:12];
    [titleBackGround addSubview:emailButton];

//blogButton
    blogButton = [UIButton buttonWithType:UIButtonTypeCustom];
    blogButton.frame = CGRectMake(originX +widthSpace +sufTitleImageViewSpace +titleImageViewWidth +loginButtonWidth, originY +heightSpace +30 , emailButtonWidth   , 30);
    blogButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [blogButton  setTitleColor:YiBlue forState:UIControlStateNormal];
    blogButton.titleLabel.font =[UIFont systemFontOfSize:12];
    [blogButton addTarget:self action:@selector(blogButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [titleBackGround addSubview:blogButton];

//    [self refreshTitleView];

    UILabel * lineOne = [[UILabel alloc]initWithFrame:CGRectMake(0, 210 -40-0.5, ScreenWidth, 0.5)];
    [titleView addSubview:lineOne];
    lineOne.backgroundColor = YiGray;
    segmentControl =[[DetailSegmentControl alloc]initWithFrame:CGRectMake(0, 150+34-35-40, ScreenWidth, 60)];
    [titleView addSubview:segmentControl ];
    tableView.tableHeaderView = titleView;
    __weak UserDetailDataSource *weakUserDetailDataSource = userDetailDataSource;
    __weak YiRefreshHeader * weakRefreshHeader =refreshHeader;
    __weak UITableView * weakTableView = tableView;

    segmentControl.ButtonActionBlock =^(int buttonTag){
        currentIndex = buttonTag -100;
        __strong UserDetailDataSource * strongUserDetailDataSource = weakUserDetailDataSource;
        __strong YiRefreshHeader * strongRefreshHeader =weakRefreshHeader;
        __strong UITableView * strongTableView = weakTableView;

        strongUserDetailDataSource.currentIndex = buttonTag -100;

        if (currentIndex ==1) {
            if (self.repositoryDataSourceOfPageListObject.dataSourceArray.count <1) {
                [strongRefreshHeader  beginRefreshing];
            }

        } else if (currentIndex ==2){
            if (self.followingDataSourceOfPageListObject.dataSourceArray.count <1) {
                [strongRefreshHeader beginRefreshing];
            }


        }else if (currentIndex ==3){
            if (self.followerDataSourceOfPageListObject.dataSourceArray.count <1) {
                [strongRefreshHeader beginRefreshing];
            }

        }

        [strongTableView reloadData];

    };
    [self checkFollowStatus];

}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning ];

}

#pragma mark - actions click
-(void)loginButtonClick{
    if (self.userModel.html_url.length >0) {
        WebViewController * webView = [[WebViewController alloc]init];
        webView.urlString =self.userModel.html_url;
        [self.navigationController pushViewController:webView animated:YES];

    }

}

-(void)followClick{
    NSString * access_token = [[NSUserDefaults
standardUserDefaults]objectForKey:@"access_yoken"];
    if (access_token.length <1 || !access_token) {
        NSString *cancelButtonTitle = @"Cancel";
        NSString *destructiveButtonTitle =@"Sure";

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"login message" message:@"please login" preferredStyle:UIAlertControllerStyleAlert];

        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"The \"Okay/Cancel\" alert action sheet's cancel action occured.");
        }];

        UIAlertAction *loginAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSLog(@"The \"Okay/Cancel\" alert action sheet's destructive action occured.");
        }];

        [alertController addAction:cancelAction];
        [alertController addAction: loginAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }
    if (isFollowing) {
        [self showYiProgressHUD:@"unfollowing……"];
        [ApplicationDelegate.apiEngine unfollowUserWithUsername:nil target_user:self.userModel.login completionHandler:^(BOOL isSuccess) {
            if (isSuccess) {
                [self hideYiProgressHUD];
                isFollowing = !isFollowing;
                self.navigationItem.rightBarButtonItem =nil;
//followClick
                UIBarButtonItem * rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"follow" style:UIBarButtonItemStylePlain target:self action:@selector(followClick)];
                self.navigationItem.rightBarButtonItem =rightBarButtonItem;
            }else{
                [self hideYiProgressHUD];


            }
        } errorHandler:^(NSError *error) {
            [self hideYiProgressHUD];
        }];
    }

}

-(void)checkFollowStatus{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"currentLogin"]isEqualToString:self.userModel.login]) {
        return;
    }
    NSString * savedLogin = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentLogin"];
    NSString * savedToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    if (savedLogin.length <1 || !savedLogin) {
        return;
    }
    if (savedToken.length<1 ||!savedToken) {
        return;
    }
    [ApplicationDelegate.apiEngine  checkFollowStatusWithUserName:nil target_user:self.userModel.login completionHandler:^(BOOL isFollowing1) {
        isFollowing = isFollowing1;
        NSString * rightTitle;
        if (isFollowing) {
            rightTitle = @"unfollow";

        }else {
            rightTitle =@"follow";
        }
        self.navigationItem.rightBarButtonItem =nil;
        UIBarButtonItem * right =[[UIBarButtonItem alloc] initWithTitle:rightTitle style:UIBarButtonItemStylePlain target:self action:@selector(followClick)];
        self.navigationItem.rightBarButtonItem =right;
    } errorHandler:^(NSError *error) {
        NSString * localizedDescription  = [error.userInfo  objectForKey:@"NSlocalizedDescription"];
        if ([localizedDescription isEqualToString:@"Sign in Requeired"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *cancelButtonTitle = @"Cancel";
                NSString *destructiveButtonTitle =@"Sure";

                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"login message" message:@"please login" preferredStyle:UIAlertControllerStyleAlert];

                // Create the actions.
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    NSLog(@"The \"Okay/Cancel\" alert action sheet's cancel action occured.");
                }];

                UIAlertAction *loginAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    [self loginClick];
                }];

                [alertController addAction:cancelAction];
                [alertController addAction: loginAction];
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }
    }];

}
//详细见mj的code4app
//http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E5%9B%BE%E7%89%87%E6%B5%8F%E8%A7%88%E5%99%A8/525e06116803fa7b0a000001

-(void)tapImage:(UITapGestureRecognizer*)tap{
//1.封装图片
    NSMutableArray * photos = [NSMutableArray arrayWithCapacity:1];

    //替换为中等尺寸图片
        MJPhoto *photo = [[MJPhoto alloc]init];
    photo.url = [NSURL URLWithString:self.userModel.avatar_url];
    photo.srcImageView =titleImageView; //source from which imageview
    [photos addObject:photo];
//2.显示相册
    MJPhotoBrowser * browser = [[MJPhotoBrowser   alloc]init];
    browser.currentPhotoIndex = 0;
    // first photo in browser
    browser.photos = photos;
    [browser show];

}
-(void)blogButtonClick{
    if (self.userModel.blog.length>0) {
        WebViewController *webViewController = [[WebViewController alloc]init];
        webViewController.urlString =self.userModel.blog;
        [self.navigationController pushViewController:webViewController animated:YES];
    }

}


-(void)loginClick{
    NSHTTPCookie * httpCookie;
    NSHTTPCookieStorage * httpCookieStorage =   [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (httpCookie in [httpCookieStorage cookies]) {
        [httpCookieStorage deleteCookie:httpCookie];

    }
    // 缓存 清除
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    LoginWebViewController *loginWebViewController =[[LoginWebViewController alloc]init];
    loginWebViewController.urlString =[NSString stringWithFormat:@"https://github.com/login/oauth/authorize/?client_id=%@&state=1995&redirect_uri=https://github.com/coderyi/monkey&scope=user,public_repo",[[AESCrypt decrypt:CoderyiClientID password:@"xxxsd-sdsd*sd672323q___---_w.."]substringFromIndex:1]];
    loginWebViewController.callback =^(NSString *code){
        [self getUserInfoClick];
    };
    [self presentViewController:loginWebViewController animated:YES completion:nil];

}
-(void)getUserInfoClick{
    NSString *token =[[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    if (token.length <1 ||!token) {
        return;
    }
    [ApplicationDelegate.apiEngine  getUserInfoWithToken:nil completionHandler:^(UserModel *model) {
        if (model) {
            [[NSUserDefaults standardUserDefaults]setObject:model.login forKey:@"currentLogin"];
            [[NSUserDefaults standardUserDefaults]setObject:model.avatar_url forKey:@"currentAvatarUrl"];
            [tableView reloadData];
        }
    } errorHandler:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
#pragma mark - Private

-(void)refreshTitleView{
    [titleImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.avatar_url]];

    [loginButton setTitle:self.userModel.login forState:UIControlStateNormal];
    nameLabel.text =self.userModel.name;
    createLabel.text =[self.userModel.created_at substringWithRange:NSMakeRange(0, 10)];
    companyLabel.text =self.userModel.company;
    locationLabel.text =self.userModel.location;
    [emailButton setTitle:self.userModel.email forState:UIControlStateNormal];
    [blogButton setTitle:self.userModel.blog forState:UIControlStateNormal];
    segmentControl.leftTopButtonLabel.text =[NSString stringWithFormat:@"%ld",(long)self.userModel.public_repos];
    segmentControl.middleTopButtonLabel.text =[NSString stringWithFormat:@"%ld",(long)self.userModel.following];
    segmentControl.rightTopButtonLabel.text =[NSString stringWithFormat:@"%ld",(long)self.userModel.followers];


}
-(void)addTableViewHeader{
    // YiRefreshHeader  头部刷新按钮的使用
    refreshHeader = [[YiRefreshHeader alloc]init];
    refreshHeader.scrollView =tableView;
    [refreshHeader header];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
    refreshHeader.beginRefreshingBlock =^(){
        [ApplicationDelegate.apiEngine userDetailWithUserName:self.userModel.login completionHandler:^(UserModel *model) {
            self.userModel = model;
            [self refreshTitleView];
            [self loadDataFromApiWithIsFirstPage:YES];
        } errorHandler:^(NSError *error) {
            [self loadDataFromApiWithIsFirstPage:YES];
        }];
    };

#pragma clang diagnostic pop
    //是否在进入该界面的时候就开始进入刷新状态
    [refreshHeader beginRefreshing];


}

-(void)addTableViewFooter{
    refreshFooter = [[YiRefreshFooter alloc]init];
    refreshFooter.scrollView =tableView;
    [refreshFooter footer];
    __weak typeof (self) weakSelf =self;
    refreshFooter.beginRefreshingBlock =^(){
        __strong typeof (self) strongSelf = weakSelf;
        [strongSelf loadDataFromApiWithIsFirstPage:NO];
    };


}
-(void)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage{
    [userDetailViewModel loadDataFromApiWithIsFirstPage:isFirstPage currentIndex:currentIndex firstTableData:^(DataSourceModel *DataSourceOfPageListObject) {
        userDetailDataSource.repositoryDataSourcePageListObject =DataSourceOfPageListObject;
        [tableView reloadData];
        if (isFirstPage) {
            [refreshHeader endRefreshing];
        } else{
            [refreshFooter endRefreshing];
        }
    } secondTableData:^(DataSourceModel *DataSourceOfPageListObject) {
        userDetailDataSource.followingDataSourcePageListObject
        =DataSourceOfPageListObject;
        [tableView reloadData];
        if (isFirstPage) {
            [refreshHeader endRefreshing];
        } else{
            [refreshFooter endRefreshing];
        }
    } thirdTableData:^(DataSourceModel *DataSourceOfPageListObject) {
        userDetailDataSource.followerDataSourcePageListObject =DataSourceOfPageListObject;
        [tableView reloadData];
        if (isFirstPage) {
            [refreshHeader endRefreshing];
        } else{
            [refreshFooter endRefreshing];
        }
    }];

}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentIndex ==1) {
        return  RepositoriesTableViewCellheight;
    } else if (currentIndex ==2){
        return RankTableViewCellHeight;
        
    }else if (currentIndex == 3){
        return RankTableViewCellHeight;
    }

    return 1;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (currentIndex ==1) {
        RepositoryModel * repositoryModel = [userDetailDataSource.repositoryDataSourcePageListObject.dataSourceArray objectAtIndex:indexPath.row];
        RepositoryDetailViewController * repositoryDetailViewController =[[RepositoryDetailViewController alloc]init];
        repositoryDetailViewController.repositoryModel =repositoryModel;
        [self.navigationController pushViewController:repositoryDetailViewController animated:YES];

    } else if (currentIndex ==2){
        UserModel *userModel = [userDetailDataSource.followingDataSourcePageListObject.dataSourceArray objectAtIndex:indexPath.row];
        UserDetailViewController * userDetailViewController =[[UserDetailViewController alloc]init];
        userDetailViewController.userModel = userModel;

        [self.navigationController pushViewController:userDetailViewController animated:YES];
    } else if (currentIndex ==3){
        UserModel *userModel = [userDetailDataSource.followerDataSourcePageListObject.dataSourceArray objectAtIndex:indexPath.row];
        UserDetailViewController * userDetailViewController =[[UserDetailViewController alloc]init];
        userDetailViewController.userModel = userModel;

        [self.navigationController pushViewController:userDetailViewController animated:YES];
    }
}




@end
