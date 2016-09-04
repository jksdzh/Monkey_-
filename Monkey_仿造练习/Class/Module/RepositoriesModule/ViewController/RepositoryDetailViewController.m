//
//  RepositoryDetailViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/31.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "RepositoryDetailViewController.h"
//#import "RankTableViewCell.h"
//#import "UserModel.h"
#import "DetailSegmentControl.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "RepositoryDetailDataSource.h"
#import "RepositoryDetailViewModel.h"
#import "WebViewController.h"
#import "NSObject+HUD.h"
#import "UIImageView+WebCache.h"
#import "UserDetailViewController.h"






@interface RepositoryDetailViewController()<UITableViewDelegate>
{
    UITableView * tableViewOne;
    YiRefreshHeader * refreshHeader;
    YiRefreshFooter * refreshFooter;
    DetailSegmentControl * detailSegmentControl;
    UIButton * nameButton;
    UIButton * ownerButton;
    UIButton * parentButton;
    UILabel * lineLabel;
    UILabel * forkLabel;
    UILabel * createLabel;
    UIButton *homePageButton;
    UIImageView * ownerImageView;
    UILabel * describeLabel;
    UIView *titleView;
    BOOL isStaring;
    RepositoryDetailDataSource * repositoryDetailDataSource;
    RepositoryDetailViewModel * repositoryDetailViewModel;
    UILabel * lineOne;
}

@property (nonatomic,strong) DataSourceModel *contributorsDataSourceOfPageListObject;
@property (nonatomic,strong) DataSourceModel *forksDataSourceOfPageListObject;
@property (nonatomic,strong) DataSourceModel *stargazersDataSourceOfPageListObject;
@property (nonatomic,assign) int currentIndex;
@end
@implementation RepositoryDetailViewController
#pragma mark - lifeCycle
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ];
    if (self) {
        //Custom initialization
        self.contributorsDataSourceOfPageListObject = [[DataSourceModel   alloc]init];
        self.forksDataSourceOfPageListObject  = [[DataSourceModel   alloc]init];
        self.stargazersDataSourceOfPageListObject = [[DataSourceModel   alloc]init];

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
    self.tabBarController.tabBar.hidden =YES;

}
-(void)viewWillDisappear:(BOOL)animated{
 
    //    [activityIndicator removeFromSuperview];
    self.tabBarController.tabBar.hidden =NO;


}
-(void)viewDidLoad{
    [super viewDidLoad ];
    self.title =self.repositoryModel.name;
    repositoryDetailDataSource = [[RepositoryDetailDataSource alloc]init];
    repositoryDetailViewModel = [[RepositoryDetailViewModel alloc]init];
    repositoryDetailViewModel.repositoryModel =self.repositoryModel;
    self.currentIndex =1;

    repositoryDetailDataSource.currentIndex = self.currentIndex;
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight ;
    }
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets =NO;

//TableViewHeaderBackGroundView
    titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 0, ScreenWidth, 210);


//tableViewOne
    tableViewOne = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -64) style:UITableViewStylePlain];
    tableViewOne.delegate =self;
    tableViewOne.dataSource =repositoryDetailDataSource;
    tableViewOne.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:tableViewOne];

    //取消tableview的分割线
    tableViewOne.separatorStyle =UITableViewCellSeparatorStyleNone;
    //添加底部footview
    [self addTableViewHeader];
    [self addTableViewFooter];



    float originX =10;
//nameButton
    nameButton =[UIButton buttonWithType:UIButtonTypeCustom];
    nameButton.frame = CGRectMake(originX, 0 , (ScreenWidth -2 * originX)/2   , 40);
    [nameButton addTarget:self action:@selector(nameButtonClick) forControlEvents:UIControlEventTouchUpInside];
    nameButton.titleLabel.font =[UIFont systemFontOfSize:17];
    [titleView  addSubview:nameButton];
//ownerButton
    ownerButton =[UIButton buttonWithType:UIButtonTypeCustom];

    ownerButton.frame = CGRectMake(originX +(ScreenWidth -2*originX)/2, 0 , (ScreenWidth -2 *originX)/2 , 40);
    [ownerButton addTarget:self action:@selector(ownerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    ownerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [titleView  addSubview:ownerButton];
//lineLabel
    lineLabel = [[UILabel alloc]init];
    lineLabel.text =@"/";
    lineLabel.textColor=YiGray;
     lineLabel.font =[UIFont systemFontOfSize:20];
     [titleView   addSubview:lineLabel];


//ownerImageView
    ownerImageView =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-45, 5, 30, 30)];
     ownerImageView.layer.masksToBounds =YES;
    ownerImageView.layer.cornerRadius =4;
    [titleView   addSubview:ownerImageView];

//forkLabel
    forkLabel = [[UILabel alloc]initWithFrame:CGRectMake(originX, 40, 70, 30)];
    forkLabel.text =@"forked form";
    forkLabel.textColor=YiTextGray;
    forkLabel.textAlignment=NSTextAlignmentCenter;
    forkLabel.font =[UIFont systemFontOfSize:12];
    [titleView  addSubview:forkLabel];
//parentButton
     parentButton=[UIButton buttonWithType:UIButtonTypeCustom];
    parentButton.frame = CGRectMake(originX +70, 40 ,(ScreenWidth - 2*originX)/2,30);
    [parentButton setTitleColor:YiBlue forState:UIControlStateNormal];
    parentButton.titleLabel.font =[UIFont systemFontOfSize:15];
    [titleView   addSubview:parentButton];
//createLabel
    createLabel = [[UILabel alloc]initWithFrame:CGRectMake(originX, 70, 100, 30)];
    createLabel.textAlignment=NSTextAlignmentCenter;
    createLabel.font =[UIFont systemFontOfSize:11];
    [titleView   addSubview:createLabel];

//homePageButton
    homePageButton =[UIButton buttonWithType:UIButtonTypeCustom];
    homePageButton.frame = CGRectMake(originX+100, 70 ,(ScreenWidth -2*originX)-100,30);
    [homePageButton addTarget:self action:@selector(homePageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    homePageButton.titleLabel.font =[UIFont systemFontOfSize:13];
    [titleView  addSubview:homePageButton];
//lineOne
    lineOne = [[UILabel alloc]init];
    lineOne.backgroundColor =YiGray;
    [titleView  addSubview:lineOne];
//segmentControl
    detailSegmentControl = [[DetailSegmentControl alloc]initWithFrame:CGRectMake(0, 130+5-30, ScreenWidth, 60)];
    detailSegmentControl.leftBottomButtonLabel.text =@"Contributors";
    detailSegmentControl.middleBottomButtonLabel.text =@"Forks";
    detailSegmentControl.rightBottomButtonLabel.text =    @"Stargazers";
    [titleView  addSubview:detailSegmentControl];
    tableViewOne.tableHeaderView =titleView;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"

    detailSegmentControl.ButtonActionBlock =^(int buttonTag){
        self.currentIndex =buttonTag -100;
        repositoryDetailDataSource.currentIndex = buttonTag -100;
        switch (self.currentIndex) {
            case contributorsCurrentIndex:
                if (self.contributorsDataSourceOfPageListObject.dataSourceArray.count <1) {
                    [refreshHeader beginRefreshing];
                }
                break;
            case forksCurrentIndex:
                if (self.forksDataSourceOfPageListObject.dataSourceArray.count<1) {
                    [refreshHeader beginRefreshing];
                }
                break;
            case stargazersCurrentIndex:
                if (self.stargazersDataSourceOfPageListObject.dataSourceArray.count <1) {
                    [refreshHeader beginRefreshing];
                }
                break;

            default:
                break;
        }
        [tableViewOne reloadData];

    };
#pragma clang diagnostic pop
    [self refreshTitleView ];
    [self checkStarStatusAction];


}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning ];
    
}

#pragma mark - action & click
-(void)checkStarStatusAction{
    NSString * savedLogin = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentLogin"];
    NSString * savedToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    if (savedLogin.length <1 || !savedLogin) {
        return;
    }
    if (savedToken.length <1 || !savedToken) {
        return;
    }
    [ApplicationDelegate.apiEngine checkStarStatusWithOwner:self.repositoryModel.owner.login repo:self.repositoryModel.name comletionHandler:^(BOOL isStarred) {
        isStaring = isStarred;
        NSString * rightTitle;
        if (isStaring) {
            rightTitle =@"unstar";
        }else{
            rightTitle =@"star";
        }
        self.navigationItem.rightBarButtonItem =nil;
        UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:rightTitle style:UIBarButtonItemStylePlain target:self action:@selector(starBarButtonItemClick)];
        self.navigationItem.rightBarButtonItem =rightBarButtonItem;
    } errorHandler:^(NSError *error) {


    }];


}
-(void)homePageButtonClick{
    if (self.repositoryModel.homepage.length>0) {
        WebViewController * webViewController = [[WebViewController alloc]init];
        webViewController.urlString = self.repositoryModel.homepage;
        [self.navigationController pushViewController:webViewController animated:YES];
    }



}

-(void)ownerButtonClick{
    if (self.repositoryModel.owner.html_url.length >0) {
        WebViewController * webViewController = [[WebViewController  alloc]init];
        webViewController.urlString =self.repositoryModel.owner.html_url;
        [self.navigationController pushViewController:webViewController animated:YES];
    }

}
-(void)starBarButtonItemClick{
    if (isStaring) {
        [self showYiProgressHUD:@"unstaring……"];
        [ApplicationDelegate.apiEngine unStarRepoWithOwner:self.repositoryModel.owner.login repo:self.repositoryModel.name comletionHandler:^(BOOL isSuccess) {
            if (isSuccess) {
                [self hideYiProgressHUD];
                isStaring = !isStaring;
                self.navigationItem.rightBarButtonItem = nil;
                UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"star" style:UIBarButtonItemStylePlain target:self action:@selector(starBarButtonItemClick)];
                self.navigationItem.rightBarButtonItem =rightBarButtonItem;
            }else{
                [self hideYiProgressHUD];
            }

        } errorHandler:^(NSError *error) {
            [self hideYiProgressHUD];

        }];
    } else{
        [self showYiProgressHUD:@"staring……"];
        [ApplicationDelegate.apiEngine starRepoWithOwner:self.repositoryModel.owner.login repo:self.repositoryModel.name comletionHandler:^(BOOL isSuccess) {
            if (isSuccess) {
                [self hideYiProgressHUD];
                isStaring=!isStaring;
                self.navigationItem.rightBarButtonItem =nil;
                UIBarButtonItem * rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"unstar" style:UIBarButtonItemStylePlain target:self action:@selector(starBarButtonItemClick)];
                self.navigationItem.rightBarButtonItem =rightBarButtonItem;
            } else{
                [self hideYiProgressHUD];
            }

        } errorHandler:^(NSError *error) {
            [self hideYiProgressHUD];
        }];
    }

}

-(void)nameButtonClick{
    if (self.repositoryModel.html_url.length>0) {
        WebViewController * webViewController = [[WebViewController  alloc]init];
        webViewController.urlString =self.repositoryModel.html_url;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    
}

#pragma mark - private
-(void)refreshTitleView{
    float originX =10;
    detailSegmentControl.middleTopButtonLabel.text =[NSString stringWithFormat:@"%ld",(long)self.repositoryModel.forks_count];
    detailSegmentControl.rightTopButtonLabel.text =[NSString stringWithFormat:@"%ld",self.repositoryModel.stargazers_count];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //FIXME: nameWidth
    float nameWidth = 40;
    nameButton.frame =CGRectMake(10, 0, nameWidth, 40);
    lineLabel.frame =CGRectMake(originX+nameWidth, 0, 10, 40);
    ownerButton.frame = CGRectMake(originX +nameWidth+10, 0, (ScreenWidth -2*originX)/2-40, 40);
    [ownerImageView sd_setImageWithURL:[NSURL URLWithString:self.repositoryModel.owner.avatar_url]];

    [ownerButton setTitle:self.repositoryModel.name forState:UIControlStateNormal];
    //FIXME: parent.owner.login
    [parentButton setTitle:self.repositoryModel.owner.login forState:UIControlStateNormal];
    float parentHeight = 0;
    //FIXME: parentOwner
//    if (self.repositoryModel.parent ) {
//        <#statements#>
//    }
    createLabel.frame =CGRectMake(originX, 70+parentHeight, 100, 30);
    createLabel.text = [self.repositoryModel.created_at substringWithRange:NSMakeRange(0, 10)];
    [homePageButton setTitle:self.repositoryModel.homepage forState:UIControlStateNormal];
    homePageButton.frame =CGRectMake(originX+100, 70+parentHeight, (ScreenWidth -2 *originX)-100, 30);

    float describeHeight =40;
#pragma clang diagnostic pop
//describelabel
    describeLabel.text =self.repositoryModel.Description;
    describeLabel.frame =CGRectMake(originX, 130+parentHeight-30, (ScreenWidth -2*originX), describeHeight);
//detailSegmentControl
    detailSegmentControl.frame =CGRectMake(0, 130+parentHeight+5+parentHeight-30, ScreenWidth, 60);

//lineOne
    lineOne.frame =CGRectMake(0, 130+describeHeight+5+60+parentHeight-30-0.5, ScreenWidth, 0.5);
    tableViewOne.tableHeaderView =titleView;
    [tableViewOne reloadData];




}



-(void)addTableViewHeader{
 //头部刷新按钮的使用 YiRefreshHeader
    refreshHeader =[[YiRefreshHeader alloc]init];
    refreshHeader.scrollView =tableViewOne;
    [refreshHeader header];
    NSLog(@"====%@----%@--",self.repositoryModel.owner.login,self.repositoryModel.name );

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
    WEAKSELF
    refreshHeader.beginRefreshingBlock =^(){
        [ApplicationDelegate.apiEngine repositoriesDetailWithUserName:self.repositoryModel.owner.login repositoryName:self.repositoryModel.name completionHandler:^(RepositoryModel *model) {
            self.repositoryModel = model;
            STRONGSELF
            [strongSelf refreshTitleView];
            [strongSelf loadDataFromApiWithIsFirstPage:YES];

        } errorHandler:^(NSError *error) {
            STRONGSELF
            [strongSelf loadDataFromApiWithIsFirstPage:YES];
        }];
    };
    //是否在进入该界面的时候就开始
    [refreshHeader beginRefreshing ];


}
-(void)addTableViewFooter{
    refreshFooter = [[YiRefreshFooter alloc]init];
    refreshFooter.scrollView =tableViewOne;
    [refreshFooter footer];
    WEAKSELF
    refreshFooter.beginRefreshingBlock =^(void){
        STRONGSELF
        [strongSelf loadDataFromApiWithIsFirstPage:NO]
        ;    };


}
-(void)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage{

    [repositoryDetailViewModel loadDataFromApiWithIsFirstPage:isFirstPage currentIndex:self.currentIndex firstTableData:^(DataSourceModel *DataSourceOfPageListObject) {

        repositoryDetailDataSource.contributorsDataSourceOfPageListObject= DataSourceOfPageListObject;
   
        [tableViewOne reloadData];
        if (!isFirstPage) {
            [refreshFooter endRefreshing];
        }else{
            [refreshHeader endRefreshing];
        }

    } secondTableData:^(DataSourceModel *DataSourceOfPageListObject) {
        repositoryDetailDataSource.forksDataSourceOfPageListObject = DataSourceOfPageListObject;
        [tableViewOne reloadData];
        if (isFirstPage) {
            [refreshHeader endRefreshing];
        }else{
            [refreshFooter endRefreshing];

        }
    } thirdTableData:^(DataSourceModel *DataSourceOfPageListObject) {
        repositoryDetailDataSource.stargazersDataSourceOfPageListObject =DataSourceOfPageListObject;
        [tableViewOne reloadData];
        if (isFirstPage) {
            [refreshHeader endRefreshing];

        }else{
            [refreshFooter endRefreshing];
        }
    }];

}

#pragma mark - UItableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.currentIndex) {
        case 1:
            return RankTableViewCellHeight;
            break;
        case forksCurrentIndex:
            return RankTableViewCellHeight;
            break;
        case stargazersCurrentIndex:
         return  RankTableViewCellHeight;
            break;

        default:
            break;
    }
    return 1;


}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentIndex ==1) {
        UserModel * userModel = [repositoryDetailDataSource.contributorsDataSourceOfPageListObject.dataSourceArray objectAtIndex:indexPath.row];
        UserDetailViewController *userDetailViewController =[[UserDetailViewController alloc]init];
        userDetailViewController.userModel =userModel;
        [self.navigationController  pushViewController:userDetailViewController animated:YES];

    }else if (self.currentIndex ==forksCurrentIndex){
       RepositoryModel * repositoryModel = [repositoryDetailDataSource.contributorsDataSourceOfPageListObject.dataSourceArray objectAtIndex:indexPath.row];
        RepositoryDetailViewController *repositoryDetailViewController =[[RepositoryDetailViewController alloc]init];
       repositoryDetailViewController.repositoryModel =repositoryModel;
        [self.navigationController  pushViewController:repositoryDetailViewController animated:YES];

    }else if (self.currentIndex == stargazersCurrentIndex){
        UserModel * userModel = [repositoryDetailDataSource.stargazersDataSourceOfPageListObject.dataSourceArray objectAtIndex:indexPath.row];
        UserDetailViewController *userDetailViewController =[[UserDetailViewController alloc]init];
        userDetailViewController.userModel =userModel;
        [self.navigationController  pushViewController:userDetailViewController animated:YES];

    }


}








@end
