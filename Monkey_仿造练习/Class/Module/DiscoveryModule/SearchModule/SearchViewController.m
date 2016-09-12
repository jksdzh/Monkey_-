//
//  SearchViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/2.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "SearchViewController.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "SearchViewModel.h"
#import "SearchDataSource.h"
#import "SearchSegmentControlView.h"
#import "UserDetailViewController.h"
#import "RepositoryDetailViewController.h"


@interface SearchViewController()<UITableViewDelegate,UISearchBarDelegate>
{
    int currentIndex;
    YiRefreshHeader * refreshHeaderOne;
    YiRefreshFooter *  refreshFooterOne;

    YiRefreshHeader * refreshHeaderTwo;
    YiRefreshFooter *  refreshFooterTwo;
    UISearchBar * mySearchBar;
    UILabel * titleLabel;
    SearchSegmentControlView * searchSegmentControlView;

    SearchViewModel * searchViewModel;
    SearchDataSource * searchDataSource;
}
//@property (nonatomic,strong) MKNetworkOperation *apiOperation;
//@property (nonatomic,strong) DataSourceModel *userDataSourceModel;
//@property (nonatomic,strong) DataSourceModel *repositoryDataSourceModel;


@property (nonatomic,strong) UITableView *userTableView;
@property (nonatomic,strong) UITableView *repositoryTableView;
@end
@implementation SearchViewController
#pragma mark - lifeCycle
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ];
    if (self) {
//        self.userDataSourceModel =[[DataSourceModel alloc]init];
//        self.repositoryDataSourceModel =[[DataSourceModel alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];
    self.tabBarController.tabBar.hidden =YES;
    [self.navigationController.navigationBar addSubview:mySearchBar];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden =NO;
    self.tabBarController.tabBar.hidden =NO;
    [mySearchBar removeFromSuperview];
}
-(void)viewDidLoad{
    [super viewDidLoad ];
    searchViewModel =[[SearchViewModel alloc]init];
    searchDataSource =[[SearchDataSource alloc]init];
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight ;
    }
    titleLabel =[[UILabel  alloc]initWithFrame:CGRectMake((ScreenWidth -120)/2, 0, 120, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor =[UIColor whiteColor];
    [titleLabel  setFont:[UIFont systemFontOfSize:19.0]];
    titleLabel.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView =titleLabel;
    titleLabel.text = @"Search";

//searchSegment
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets =NO;
    searchSegmentControlView =[[SearchSegmentControlView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    [self.view addSubview:searchSegmentControlView   ];
    currentIndex =1;

    self.userTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, ScreenHeight-64-30)  style:UITableViewStylePlain];
    self.userTableView.tag =11;

    self.userTableView.dataSource =searchDataSource;
    self.userTableView.delegate =self;
    self.userTableView.backgroundColor =[UIColor yellowColor];
    [self.view addSubview:self.userTableView];
    [self addTableViewHeader:1];
    [self addTableViewFooter:1];
    @weakify(self);
    __weak SearchDataSource *weakSearchDataSource = searchDataSource;
    searchSegmentControlView.ButtonActionBlock =^(int buttonTag){
        currentIndex =buttonTag -100;
        @strongify(self);
        __strong SearchDataSource * strongSearchDataSource =weakSearchDataSource;
        if (currentIndex ==1) {
            self.userTableView.hidden =NO;
            self.repositoryTableView.hidden =YES;
        } else if (currentIndex ==2){
            if (self.repositoryTableView == nil) {
                self.repositoryTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, ScreenHeight -64- 30) style:UITableViewStylePlain];
                [self.view addSubview:self.repositoryTableView];
                self.repositoryTableView.tag =12;
                self.repositoryTableView.dataSource =strongSearchDataSource;
                self.repositoryTableView.delegate =self;
                [self addTableViewHeader:2];
                [self addTableViewFooter:2];
            }
            self.userTableView.hidden =YES;
            self.repositoryTableView.hidden =NO;
        }
    };
    self.navigationItem.hidesBackButton =YES;
    mySearchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(10, 2, ScreenWidth -80, 40 )];
[self.navigationController.navigationBar addSubview:mySearchBar];
    mySearchBar.delegate =self;
    mySearchBar.tintColor =YiBlue;
    [mySearchBar becomeFirstResponder];
    UIBarButtonItem * rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"cancel", @"") style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    self.navigationItem.rightBarButtonItem =rightBarButtonItem;


}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning ];
    
}
-(void)addTableViewHeader:(int)type{
WEAKSELF
    switch (type) {
        case 1:{
             refreshHeaderOne =[[YiRefreshHeader alloc]init];
            refreshHeaderOne.scrollView =self.userTableView;
            [refreshHeaderOne header];
            refreshHeaderOne.beginRefreshingBlock =^(){
                STRONGSELF
                [strongSelf loadDataFromApiWithIsFirstPage:YES];

            };
        }

            break;
        case 2:{
            refreshHeaderTwo =[[YiRefreshHeader alloc]init];
            refreshHeaderTwo.scrollView = self.repositoryTableView;
            [refreshHeaderTwo header];
            refreshHeaderTwo.beginRefreshingBlock =^(){
                STRONGSELF
                [strongSelf loadDataFromApiWithIsFirstPage:NO];

            };
        }
            break;

        default:
            break;
    }

}


-(void)addTableViewFooter:(int)tag{
    WEAKSELF
    switch (tag) {
        case 1:{
            refreshFooterOne =[[YiRefreshFooter alloc]init];
            refreshFooterOne.scrollView =self.userTableView;
            [refreshFooterOne footer];
            refreshFooterOne.beginRefreshingBlock =^(){
                STRONGSELF
                [strongSelf loadDataFromApiWithIsFirstPage:YES];

            };
        }

            break;
        case 2:{
            refreshFooterTwo =[[YiRefreshFooter alloc]init];
            refreshFooterTwo.scrollView = self.repositoryTableView;
            [refreshFooterTwo footer];
            refreshFooterTwo.beginRefreshingBlock =^(){
                STRONGSELF
                [strongSelf loadDataFromApiWithIsFirstPage:NO];

            };
        }
            break;
            
        default:
            break;
    }

}
-(void)rightBarButtonItemClick{
    [mySearchBar removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];

}


-(void)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage{
    [searchViewModel loadDataFromApiWithIsFirstPage:isFirstPage currentIndex:currentIndex searchBarText:mySearchBar.text firstTableData:^(DataSourceModel *DataSourceModel) {
        searchDataSource.userDataSourceModel = DataSourceModel;
        [self.userTableView reloadData];
        if (isFirstPage) {
            [refreshHeaderOne endRefreshing];
        }else{
            [refreshFooterOne endRefreshing];
        }



    } secondTableData:^(DataSourceModel *DataSourceModel) {
        searchDataSource.repositoryDataSourceModel =DataSourceModel;
        [self.repositoryTableView reloadData];
        if (isFirstPage) {
            [refreshHeaderTwo endRefreshing];
        }else{
            [refreshFooterTwo endRefreshing];
        }
    }];
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self loadDataFromApiWithIsFirstPage:YES];
    [mySearchBar endEditing:YES];

}
#pragma mark - UITableView Delegate



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 11:{
            UserDetailViewController * userDetailViewController =[[UserDetailViewController alloc]init];
            UserModel * userModel = [searchDataSource.userDataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
            userDetailViewController.userModel = userModel;
            [self.navigationController pushViewController:userDetailViewController animated:YES];

        }

            break;
        case 12:{
            RepositoryDetailViewController * repositoryDetailViewController =[[RepositoryDetailViewController alloc]init];
            RepositoryModel  * repositoryModel = [searchDataSource.repositoryDataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
            repositoryDetailViewController.repositoryModel =repositoryModel;
            [self.navigationController pushViewController:repositoryDetailViewController animated:YES];



        }

            break;
        default:
            break;
    }
}






















@end
