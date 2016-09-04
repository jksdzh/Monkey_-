//
//  TrendingViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/2.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "TrendingViewController.h"
#import "UserModel.h"
#import "HeaderSegmentControl.h"
#import "CityViewController.h"
#import "YiRefreshFooter.h"
#import "YiRefreshHeader.h"
#import "TrendingDataSource.h"
#import "TrendingViewModel.h"
#import "LanguageViewController.h"
#import "RepositoryDetailViewController.h"


@interface TrendingViewController()<UITableViewDelegate,UIScrollViewDelegate>{
    UIScrollView * scrollViewOne;
    int currentIndex;
    UITableView *tableViewOne;
    UITableView *tableViewTwo;
    UITableView *tableViewThree;

    float titleHeight;
    float backGroudViewHeight;
    HeaderSegmentControl *segmentControl;
    YiRefreshHeader * refreshHeaderOne;
    YiRefreshFooter * refreshFooterOne;
    YiRefreshHeader * refreshHeaderTwo;
    YiRefreshFooter * refreshFooterTwo;
    YiRefreshHeader * refreshHeaderThree;
    YiRefreshFooter * refreshFooterThree;

    NSString *language;
    NSString *tableViewOneLanguage;
    NSString *tableViewTwoLanguage;
    NSString *tableViewThreeLanguage;
    UILabel * titleLabel;
    TrendingDataSource *trendingDataSource;
    TrendingViewModel *trendingViewModel;
}
@property (nonatomic,strong) DataSourceModel *DataSourceOfPageListObjectOne;
@property (nonatomic,strong) DataSourceModel *DataSourceOfPageListObjectTwo;
@property (nonatomic,strong) DataSourceModel *DataSourceOfPageListObjectThree;
@end
@implementation TrendingViewController
#pragma mark - lifeCycle
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ];
    if (self) {
        // Custom initialization
//        self.DataSourceOfPageListObjectOne =
//        [[DataSourceModel alloc]init];
//       self.DataSourceOfPageListObjectOne =[[DataSourceModel alloc]init];
//       self.DataSourceOfPageListObjectOne =[[DataSourceModel alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated ];

    self.tabBarController.tabBar.hidden =YES;

    NSString * languageAppear  =[[NSUserDefaults standardUserDefaults]objectForKey:@"trendingLanguageAppear"];
    if ([languageAppear  isEqualToString:@"2"]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"trendingLanguageAppear"];
        language =[[NSUserDefaults standardUserDefaults]objectForKey:@"language2"];
        if (language ==nil || language.length <1) {
            language =NSLocalizedString(@"all languages", @"");

        }

        switch (currentIndex) {
            case  dailyTrending:
                [refreshHeaderOne beginRefreshing];
                break;
            case weeklyTrending:
                [refreshHeaderTwo beginRefreshing];
                break;
            case monthlyTrending:
                [refreshHeaderThree beginRefreshing];
                break;

            default:
                break;
        }
        if ([language isEqualToString:@"cpp"]) {
            titleLabel.text =@"c++";
        } else {
            titleLabel.text =language;
        }

    }

    [scrollViewOne setContentSize:CGSizeMake(ScreenWidth *3, backGroudViewHeight)];


}
-(void)viewWillDisappear:(BOOL)animated{

    self.tabBarController.tabBar.hidden =NO;

}
-(void)viewDidLoad{
    [super viewDidLoad ];
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight ;
    }

    trendingDataSource =[[TrendingDataSource alloc]init];
    trendingViewModel =[[TrendingViewModel alloc]init];
    float titleViewXInTheBar =67;
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-(titleViewXInTheBar)*2, 44)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font =[UIFont systemFontOfSize:19.0];
    self.navigationItem.titleView =titleLabel;
    self.view.backgroundColor =[UIColor whiteColor];
    language =[[NSUserDefaults standardUserDefaults]objectForKey:@"language2"];
    if (language ==nil ||language.length<1) {
        language =NSLocalizedString(@"all languages", @"");
    }

    tableViewOneLanguage =language;
    tableViewTwoLanguage =language;
    tableViewThreeLanguage =language;

    if ([language isEqualToString:@"cpp"]) {
        titleLabel.text =@"c++";
    } else{
        titleLabel.text =language;
    }
    titleHeight =35;
    backGroudViewHeight =ScreenHeight -64-titleHeight;
    UIBarButtonItem * rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"language", @"") style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    self.navigationItem.rightBarButtonItem =rightBarButtonItem;
     [self initScrollView];
    self.automaticallyAdjustsScrollViewInsets =NO;
    segmentControl =[[HeaderSegmentControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, titleHeight)];
    [segmentControl.buttonOne setTitle:@"daily" forState:UIControlStateNormal];
    [segmentControl.buttonTwo setTitle:@"weekly" forState:UIControlStateNormal];
    [segmentControl.buttonThree setTitle:@"monthly" forState:UIControlStateNormal];
    segmentControl.buttonCount =3;
    segmentControl.buttonThree.hidden =NO;
    segmentControl.buttonFour.hidden =YES;
    [self.view addSubview:segmentControl];

    currentIndex =1;


    [self initTableView];

}
#pragma mark -init
-(void)initScrollView{
    scrollViewOne = [[UIScrollView alloc]initWithFrame:CGRectMake(0, titleHeight, ScreenWidth , backGroudViewHeight)];
    [self.view addSubview:scrollViewOne];
    scrollViewOne.delegate =self;
    scrollViewOne.backgroundColor = [UIColor whiteColor];
     scrollViewOne.pagingEnabled = YES;
                                   scrollViewOne.bounces = YES;
                                   scrollViewOne.showsHorizontalScrollIndicator = NO;
                                    scrollViewOne.delegate =self;
    scrollViewOne.alwaysBounceHorizontal =YES;
    scrollViewOne.contentSize = CGSizeMake(ScreenWidth * 3, backGroudViewHeight);
    scrollViewOne.contentOffset =CGPointMake(0, 0);
    [scrollViewOne scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, backGroudViewHeight) animated:NO];


}
-(void)initTableView{
    tableViewOne =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, backGroudViewHeight) style:UITableViewStylePlain];
    tableViewOne.tag =11;
    tableViewOne.delegate =self;
    tableViewOne.rowHeight = RepositoriesTableViewCellheight;
    tableViewOne.dataSource =trendingDataSource;
    tableViewOne.backgroundColor = [UIColor whiteColor];
    [scrollViewOne addSubview:tableViewOne];
    tableViewOne.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self addTableViewHeader:dailyTrending];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
    segmentControl.ButtonActionBlock =^(int buttonTag){
        currentIndex = buttonTag -100;
        [scrollViewOne scrollRectToVisible:CGRectMake(ScreenWidth*(currentIndex-1), 0, ScreenWidth, backGroudViewHeight) animated:NO];
        [scrollViewOne setContentOffset:CGPointMake(ScreenWidth *(currentIndex -1), 0)];
        switch (currentIndex ) {
            case dailyTrending: {
                if (![titleLabel.text isEqualToString:tableViewOneLanguage]) {
                    [refreshHeaderOne beginRefreshing];
                }
            }
                break;

            case weeklyTrending: {
                if (tableViewTwo ==nil) {
                    tableViewTwo = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, backGroudViewHeight) style:UITableViewStylePlain];
                    [scrollViewOne addSubview:tableViewTwo];
                    tableViewTwo.showsVerticalScrollIndicator =NO;
                    tableViewTwo.tag =12;
                    tableViewTwo.dataSource =trendingDataSource;
                    tableViewTwo.delegate =self;
                    tableViewTwo.separatorStyle =UITableViewCellSeparatorStyleNone;
                    tableViewTwo.rowHeight = RepositoriesTableViewCellheight;

                    [self addTableViewHeader:weeklyTrending];

                }
                if (![titleLabel.text isEqualToString:tableViewTwoLanguage]) {
                    [refreshHeaderTwo beginRefreshing];
                }



            }
                break;

            case monthlyTrending: {
                if (tableViewThree ==nil) {
                    tableViewThree = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth*2, 0, ScreenWidth, backGroudViewHeight) style:UITableViewStylePlain];
                    [scrollViewOne addSubview:tableViewThree];
                    tableViewThree.showsVerticalScrollIndicator =NO;
                    tableViewThree.tag =13;
                    tableViewThree.dataSource =trendingDataSource;
                    tableViewThree.delegate =self;
                    tableViewThree.separatorStyle =UITableViewCellSeparatorStyleNone;
                    tableViewThree.rowHeight = RepositoriesTableViewCellheight;
                    [self addTableViewHeader:monthlyTrending];

                }
                if (![titleLabel.text isEqualToString:tableViewThreeLanguage]) {
                    [refreshHeaderThree beginRefreshing];
                }

            }
                break;
                default:
                break;
        }

    };
#pragma clang diagnostic pop

    currentIndex =1;
}

-(void)addTableViewHeader:(int)tableViewIndex{
    switch (tableViewIndex) {
        case dailyTrending:
        {
            refreshHeaderOne =[[YiRefreshHeader alloc]init];
            [refreshHeaderOne header];
            refreshHeaderOne.scrollView =tableViewOne;

            __weak typeof(self) weakSelf =self;
            refreshHeaderOne.beginRefreshingBlock =^(){
                [weakSelf loadDataFromApiWithIsFirstPage:YES];
            };
            [refreshHeaderOne beginRefreshing];
        }
            break;
        case weeklyTrending:
        {
            refreshHeaderTwo =[[YiRefreshHeader alloc]init];
            [refreshHeaderTwo header];
            refreshHeaderTwo.scrollView =tableViewTwo;
            __weak typeof(self) weakSelf =self;
            refreshHeaderTwo.beginRefreshingBlock =^(){
                [weakSelf loadDataFromApiWithIsFirstPage:YES];
            };
            [refreshHeaderTwo beginRefreshing];
        }
            break;
        case monthlyTrending:
        {
            refreshHeaderThree=[[YiRefreshHeader alloc]init];
            [refreshHeaderThree    header];
            refreshHeaderThree.scrollView =tableViewThree;
            __weak typeof(self) weakSelf =self;
            refreshHeaderThree.beginRefreshingBlock =^(){
                [weakSelf loadDataFromApiWithIsFirstPage:YES];
            };
            [refreshHeaderThree beginRefreshing];
        }
            break;

        default:
            break;
    }

}

 
-(void)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage{
    switch (currentIndex) {
        case dailyTrending:{
            tableViewOneLanguage =language;
        }

            break;
        case weeklyTrending:{
            tableViewTwoLanguage =language;
        }
            break;
        case monthlyTrending:{
            tableViewThreeLanguage =language;
        }
            break;

        default:
            break;
    }
    [trendingViewModel loadDataFromApiWithIsFirstPage:isFirstPage currentTableViewIndex:currentIndex firstTableData:^(DataSourceModel *dataSourceModel) {
        trendingDataSource.dailyDataSourceModel= dataSourceModel;
        [tableViewOne reloadData];
        if (!isFirstPage) {
            [refreshFooterOne endRefreshing];
        }else{
           [refreshHeaderOne endRefreshing];
        }
    } secondTableDatA:^(DataSourceModel *dataSourceModel) {
        trendingDataSource.weeklyDataSourceModel =dataSourceModel;
        [tableViewTwo reloadData];
        if (isFirstPage) {
            [refreshHeaderTwo endRefreshing];
        }else{
            [refreshFooterTwo endRefreshing];
        }
    } thirdTableData:^(DataSourceModel *dataSourceModel) {
        trendingDataSource.monthlyDataSourceModel =dataSourceModel;
        [tableViewThree reloadData];
        if (isFirstPage) {
            [refreshHeaderThree endRefreshing];
        }else{
            [refreshFooterThree endRefreshing];
        }
    }];


}




#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RepositoryDetailViewController * repositoryDetailViewController =[[RepositoryDetailViewController alloc]init];

    switch (currentIndex) {
        case dailyTrending:{
            
            RepositoryModel * repositoryModel = [trendingDataSource.dailyDataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
            repositoryDetailViewController.repositoryModel = repositoryModel;


        }
            break;
        case weeklyTrending:{
            RepositoryModel * repositoryModel = [trendingDataSource.weeklyDataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
            repositoryDetailViewController.repositoryModel = repositoryModel;
        }
            break;
        case monthlyTrending:{
            RepositoryModel * repositoryModel = [trendingDataSource.monthlyDataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
            repositoryDetailViewController.repositoryModel = repositoryModel;
        }
            break;

        default:
            break;
    }
    [self.navigationController pushViewController:repositoryDetailViewController animated:YES];

}
#pragma mark -uiscrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)TempscrollView{
    if (segmentControl.buttonCount ==2) {
        CGFloat pageWidth =scrollViewOne.frame.size.width;
        int currentPage = floor((scrollViewOne.contentOffset.x-(pageWidth/2))/pageWidth) +1;
        if (currentPage ==0) {
            currentPage =0;
            [scrollViewOne scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, backGroudViewHeight) animated:NO];
            [scrollViewOne setContentOffset:CGPointMake(0, 0)];

        }else if (currentPage>=1){
            currentPage =1;
            [scrollViewOne scrollRectToVisible:CGRectMake(ScreenWidth*1 , 0, ScreenWidth, ScreenWidth) animated:NO];
            [scrollViewOne setContentOffset:CGPointMake(ScreenWidth *1, 0)];
        }
        currentPage = currentPage+1;
        [segmentControl swipeAction:(100+currentPage+1)];
    }else if (segmentControl.buttonCount ==3){
        CGFloat pageWidth =scrollViewOne.frame.size.width;
        int currentPage =floor((scrollViewOne.contentOffset.x -pageWidth/(3))/pageWidth) + 1;

        if (currentPage ==0) {
            currentPage =0;
            [scrollViewOne scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, backGroudViewHeight) animated:NO];
            [scrollViewOne setContentOffset:CGPointMake(0, 0)];
        } else if (currentPage ==1){
            currentPage =1;
            [scrollViewOne scrollRectToVisible:CGRectMake(ScreenWidth*1, 0, ScreenWidth, backGroudViewHeight) animated:NO];
            [scrollViewOne setContentOffset:CGPointMake(ScreenWidth *1, 0)];

        }
        else if (currentPage>=2){
            currentPage =2;
            [scrollViewOne scrollRectToVisible:CGRectMake(ScreenWidth *2, 0, ScreenWidth, backGroudViewHeight) animated:NO];
            [scrollViewOne setContentOffset:CGPointMake(ScreenWidth *2, 0)];
        }
        currentIndex =currentPage+1;
        [segmentControl swipeAction:(100+currentPage+1)];
    }


}



#pragma mark - click & actions
-(void)rightBarButtonItemClick{
    LanguageViewController * languageViewController =[[LanguageViewController alloc]init];
    languageViewController.languageEntranceType =TrendingLanguageEntranceType;
    [self.navigationController pushViewController:languageViewController animated:YES];

}
 


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning ];
    
}
@end
