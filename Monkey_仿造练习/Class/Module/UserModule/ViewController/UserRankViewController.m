
//
//  UserRankViewController.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/26.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "UserRankViewController.h"
#import "UserModel.h"
#import "RankTableViewCell.h"
#import "HeaderSegmentControl.h"
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"
#import "UserRankDataSource.h"
#import "UserRankViewModel.h"
#import "DataSourceModel.h"
#import "CountryViewController.h"
#import "LanguageViewController.h"
#import "UserDetailViewController.h"
@interface UserRankViewController()<UITableViewDelegate>{
    UIScrollView *scrollView;
    int currentIndex;
    UITableView *tableViewOne;
    UITableView *tableViewTwo;
    UITableView *tableViewThree;

    float titleHeight;
    float   backGroundViewHeight;
    HeaderSegmentControl *segmentControl;
    YiRefreshHeader *refreshHeaderOne;
    YiRefreshFooter *refreshFooterOne;
    YiRefreshHeader *refreshHeaderTwo;
    YiRefreshFooter *refreshFooterTwo;
    YiRefreshHeader *refreshHeaderThree;
    YiRefreshFooter *refreshFooterThree;

    NSString * language;
    NSString *tableViewOneLanguage;
    NSString *tableViewTwoLanguage;
    NSString *tableViewThreeLanguage;
    UILabel *titleText;
    UserRankDataSource * userRankDataSource;
    UserRankViewModel * userRankViewModel;

//记录 dataSourceObject.TotalCount
    NSInteger totalCount;
    NSInteger dataSourceObjectTotalCountOne;
     NSInteger dataSourceObjectTotalCountTwo;
     NSInteger dataSourceObjectTotalCountThree;

}
@property (nonatomic,strong)  DataSourceModel*DataSourceOfPageListObjectOne;
@property (nonatomic,strong)  DataSourceModel*DataSourceOfPageListObjectTwo;
@property (nonatomic,strong)  DataSourceModel*DataSourceOfPageListObjectThree;
@property (nonatomic,strong) MKNetworkOperation *apiOperation;

@end
@implementation UserRankViewController

#pragma mark - LifeCycle

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil ];
    if (self) {
        self.DataSourceOfPageListObjectOne = [[DataSourceModel alloc]init];

        self.DataSourceOfPageListObjectTwo =[[DataSourceModel  alloc]init];
        self.DataSourceOfPageListObjectThree =[[DataSourceModel   alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =NO;

    NSString *cityAppear = [[NSUserDefaults standardUserDefaults]objectForKey:@"cityAppear"];
    if ([cityAppear isEqualToString:@"2"
]) {        currentIndex =1;
        [segmentControl swipeAction:101];
        [[NSUserDefaults standardUserDefaults] setObject:@"1"forKey:@"cityAppear"
         ];
        [refreshHeaderOne beginRefreshing];
        NSString *city=[[NSUserDefaults standardUserDefaults]objectForKey:@"city"];
        if (city ==nil ||city.length<1) {
            city =NSLocalizedString(@"beijing", @"");
        }
        [segmentControl.buttonOne setTitle:city forState:UIControlStateNormal];
        NSString *country =[[NSUserDefaults standardUserDefaults] objectForKey:@"country"
                            ];
        if (country ==nil ||country.length <1) {
            country =@"China";
        }
        [segmentControl.buttonTwo setTitle:country forState:UIControlStateNormal];
    }



//languageAppear
    NSString *languageAppear = [[NSUserDefaults standardUserDefaults]objectForKey:@"languageAppear"];
          if ([languageAppear isEqualToString:@"2"])
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"1"forKey:@"languageAppear"
             ];
            language =[[NSUserDefaults  standardUserDefaults] objectForKey:@"language"];


    if (language == nil || language.length<1) {
        language = NSLocalizedString(@"all languages", @"");
    }

    if ([language  isEqualToString:NSLocalizedString(@"all languages", @"")]) {
        segmentControl.buttonCount =2;
        segmentControl.buttonThree.hidden =YES;
    }else{
        segmentControl.buttonCount =3;
        segmentControl.buttonThree.hidden =NO;

    }

    switch (currentIndex) {
                case 1:
            [refreshHeaderOne beginRefreshing];
                    break;
                case 2:
            [refreshHeaderTwo beginRefreshing];
                    break;
                case 3:
            if ([language  isEqualToString:NSLocalizedString(@"all languages", @"")]) {
                currentIndex =2;
                [segmentControl swipeAction:102];
                [refreshHeaderTwo beginRefreshing];
            }else{
                [refreshHeaderThree beginRefreshing];

            }
                    break;
                    
                default:
                    break;
            }


    if ([language isEqualToString:@"CPP"]) {
        titleText.text =@"C++";

            } else{
                titleText.text =language;
            }

    }

    if ([language  isEqualToString:NSLocalizedString(@"all languages", @"")]) {
        [scrollView setContentSize:CGSizeMake(ScreenWidth *(2), backGroundViewHeight)];
    }else{
        [scrollView setContentSize:CGSizeMake(ScreenWidth *(3), backGroundViewHeight)];
    }
}
-(void)viewDidLoad{
    [super viewDidLoad ];
    if (iOS7GE) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft |UIRectEdgeRight ;
        userRankViewModel = [[UserRankViewModel alloc] init];
    }
       titleText = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth -120 )/2, 0, 120, 44)];
        titleText.textColor=[UIColor whiteColor];
        titleText.textAlignment=NSTextAlignmentCenter;
        titleText.font =[UIFont systemFontOfSize:19.0];
       titleText.numberOfLines =0;
        titleText.backgroundColor = [UIColor clearColor];
        self.navigationItem.titleView =titleText;

        language =[[NSUserDefaults standardUserDefaults] objectForKey:@"language"
                   ];

        if (language == nil || language.length<1) {
            language = NSLocalizedString(@"all languages"
                                         , @""
                                         );

        }
        tableViewOneLanguage =language;
        tableViewTwoLanguage =language;
        tableViewThreeLanguage =language;
        if ([language  isEqualToString:@"CPP"
]) {
            titleText.text =@"C++";
        }else{
            titleText.text =language;
        }
        self.view.backgroundColor = [UIColor whiteColor];
        titleHeight =35;
        backGroundViewHeight = ScreenHeight -64 -titleHeight -49;
        [self initScroll ];
    self.automaticallyAdjustsScrollViewInsets =NO;

    segmentControl = [[HeaderSegmentControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, titleHeight)];
    [self.view addSubview:segmentControl];
    if ([language isEqualToString: NSLocalizedString(@"all languages"
                                                     , @""
)]) {
        segmentControl.buttonCount =2;
        segmentControl.buttonThree.hidden =YES;
    }else{
        segmentControl.buttonCount =3;
        segmentControl.buttonThree.hidden =NO;
    }
    currentIndex =1;
    NSString * city= [[NSUserDefaults standardUserDefaults] objectForKey:@"city"
                       ];
    if (city ==nil ||city.length <1) {
        city = NSLocalizedString(@"beijing"
                                 , @""
                                 );
    }
    [segmentControl.buttonOne setTitle:city forState:UIControlStateNormal];
    NSString * country= [[NSUserDefaults standardUserDefaults] objectForKey:@"country"
                          ];

    if (country ==nil ||country.length <1) {
        country =@"China";

    }
    [segmentControl.buttonTwo  setTitle:country forState:UIControlStateNormal];

        [self initTable];
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"city", @"") style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"language"
                                                                                             , @""
) style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    self.navigationItem.rightBarButtonItem = rightBarItem;

    }

#pragma mark - Actions
-(void)leftBarButtonItemClick{
    CountryViewController *countryViewController = [[CountryViewController alloc]init];
    [self.navigationController pushViewController:countryViewController animated:YES];

}
-(void)rightBarButtonItemClick{
    LanguageViewController *languageViewController = [[LanguageViewController alloc]init];
    languageViewController.languageEntranceType =UserLanguageEntranceType;
    [self.navigationController pushViewController:languageViewController animated:YES];
}

#pragma mark - Private
-(void)initScroll{
    scrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, titleHeight, ScreenWidth, backGroundViewHeight)];
                               [self.view addSubview:scrollView];
                               scrollView.pagingEnabled =YES;
                            scrollView.bounces = YES;
                               scrollView.showsHorizontalScrollIndicator = NO;
                               scrollView.showsVerticalScrollIndicator = NO;
                               scrollView.delegate =self;
                               scrollView.contentSize = CGSizeMake(ScreenWidth * (3), backGroundViewHeight);
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [scrollView scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, backGroundViewHeight) animated:NO];
    if ([language isEqualToString:NSLocalizedString(@"all languages"
                                                    , @""
)]) {
        [scrollView setContentSize: CGSizeMake(ScreenWidth *(2), backGroundViewHeight)];

    }else{
 [scrollView setContentSize: CGSizeMake(ScreenWidth *(3), backGroundViewHeight)];
    }
    

}
-(void)initTable{
    tableViewOne =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, backGroundViewHeight) style:UITableViewStylePlain];
    tableViewOne.tag =11;
    tableViewOne.delegate =self;


    userRankDataSource = [[UserRankDataSource alloc]init];
    tableViewOne.dataSource =userRankDataSource;
    tableViewOne.backgroundColor = [UIColor whiteColor];

    tableViewOne.rowHeight =RankTableViewCellHeight;
    //取消tableview的分割线
    tableViewOne.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    [scrollView addSubview:tableViewOne];

    [self addTableViewFooter:1];
    [self addTableViewHeader:1];
    #pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
    __weak UIScrollView * weakScrollView = scrollView;
    segmentControl.ButtonActionBlock = ^(int buttonTag){
        __strong UIScrollView * strongScrollView =weakScrollView;
        currentIndex = buttonTag -100;
        switch (currentIndex) {
            case 1:
                      [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld",dataSourceObjectTotalCountOne ] forState:UIControlStateNormal];
                break;
            case 2:
                [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld",dataSourceObjectTotalCountTwo] forState:UIControlStateNormal];
                break;
            case 3:
                [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld",dataSourceObjectTotalCountThree] forState:UIControlStateNormal];
                break;

            default:
                break;
        }


        [strongScrollView scrollRectToVisible:CGRectMake(ScreenWidth *(currentIndex -1), 0, ScreenWidth, backGroundViewHeight) animated:NO];
        [strongScrollView setContentOffset:CGPointMake(ScreenWidth*(currentIndex -1), 0)];
        switch (currentIndex) {
            case 1:


                    if (![titleText.text isEqualToString:tableViewOneLanguage]) {
                        [refreshHeaderOne  beginRefreshing];



                }
                if (userRankDataSource.DataSourceOfPageListObjectOne.totalCount>0) {
                    [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld",(long)self.DataSourceOfPageListObjectOne.totalCount
                                                         ] forState:UIControlStateNormal];

                }
                break;
            case 2:
                if (tableViewTwo ==nil) {
                    tableViewTwo =[[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, backGroundViewHeight) style:UITableViewStylePlain ];

                    tableViewTwo.delegate =self;
                     tableViewTwo.tag = 12;
                    tableViewTwo.dataSource =userRankDataSource;
                    tableViewTwo.backgroundColor = [UIColor whiteColor];
                    [scrollView addSubview:tableViewTwo];

                    tableViewTwo.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
                    //添加底部footview
                    tableViewTwo.rowHeight = RankTableViewCellHeight;
                    [self addTableViewFooter:2];
                    [self addTableViewHeader:2];
                    if (![titleText.text isEqualToString:tableViewTwoLanguage]) {
                        [refreshHeaderTwo beginRefreshing];
                    }
                    if (userRankDataSource.DatasourceOfPageListObjectTwo.totalCount >0) {
                        [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld",(long)self.DataSourceOfPageListObjectTwo.totalCount] forState:UIControlStateNormal];


                    }
                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"countryAppear"
                          ] isEqualToString:@"2"
]) {
                        [refreshHeaderTwo beginRefreshing];
                        [[NSUserDefaults standardUserDefaults] setObject:@"1"
                                                                   forKey:@"countryAppear"
                          ];
                    }
                }

                break;
            case 3:
                if (tableViewThree ==nil) {
                    tableViewThree = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth *2, 0, ScreenWidth, backGroundViewHeight) style:UITableViewStylePlain];
                    [scrollView addSubview:tableViewThree];
                    tableViewThree.showsVerticalScrollIndicator =NO;
                    tableViewThree.tag =13;
                    tableViewThree.delegate =self;
                    tableViewThree.dataSource =userRankDataSource;
                    tableViewThree.separatorStyle =UITableViewCellSeparatorStyleNone;
                    tableViewThree.rowHeight =RankTableViewCellHeight;
                    [self addTableViewHeader:3];
                    [self addTableViewFooter:3];
                    if (![titleText.text isEqualToString:tableViewThreeLanguage]) {
                        [refreshHeaderThree beginRefreshing];

                    }
                    if (userRankDataSource.DatasourceOfPageListObjectThree.totalCount >0) {
                        [segmentControl.buttonFour setTitle:[NSString  stringWithFormat:@"total:%ld",(long)(self.DataSourceOfPageListObjectThree.totalCount)
                                                             ] forState: UIControlStateNormal];
                    }
                }

                break;
            case 4:
                break;
            default:
                break;


    }


    };
}

-(void)addTableViewHeader:(int)type{
    if (type ==1) {
        //YiRefreshHeader 头部刷新按钮的使用
        refreshHeaderOne = [[YiRefreshHeader alloc]init];
        refreshHeaderOne.scrollView = tableViewOne;
        [refreshHeaderOne header];
        @weakify(self);
        refreshHeaderOne.beginRefreshingBlock =^(){
            @strongify(self);
            [self loadDataFromApiWithIsFirstPage:YES];
        };
        //是否在进入该界面的时候就开始进入刷新状态
        [refreshHeaderOne beginRefreshing];
    }else if (type ==2){
        //YiRefreshHeader 头部刷新按钮的使用
        refreshHeaderTwo = [[YiRefreshHeader alloc]init];
        refreshHeaderTwo.scrollView = tableViewTwo;
        [refreshHeaderTwo header];
        @weakify(self);
        refreshHeaderTwo.beginRefreshingBlock =^(){
            @strongify(self);
            [self loadDataFromApiWithIsFirstPage:YES];
        };
        //是否在进入该界面的时候就开始进入刷新状态
        [refreshHeaderTwo beginRefreshing];

    }else if (type ==3){
        refreshHeaderThree = [[YiRefreshHeader alloc]init];
        refreshHeaderThree.scrollView = tableViewThree;
        [refreshHeaderThree header];
        @weakify(self);
        refreshHeaderThree.beginRefreshingBlock =^(){
            @strongify(self);
                        [self loadDataFromApiWithIsFirstPage:YES];
        };
        //是否在进入该界面的时候就开始进入刷新状态
        [refreshHeaderThree beginRefreshing];
    }

}

-(void)addTableViewFooter:(int)type{
    @weakify(self);
    if (type ==1) {
        @strongify(self);

        // Yirefreshfooter 底部刷新按钮的使用
        refreshFooterOne = [[YiRefreshFooter alloc]init];
        refreshFooterOne.scrollView =tableViewOne;
        [refreshFooterOne footer];
        refreshFooterOne.beginRefreshingBlock =^{
            [self loadDataFromApiWithIsFirstPage:NO];
        };

    }else if (type ==2){
        @strongify(self);

        // Yirefreshfooter 底部刷新按钮的使用
        refreshFooterTwo = [[YiRefreshFooter alloc]init];
        refreshFooterTwo.scrollView =tableViewTwo;
        [refreshFooterTwo footer];
        refreshFooterTwo.beginRefreshingBlock =^{
                        [self loadDataFromApiWithIsFirstPage:NO];
        };
    }else if (type ==3){
        @strongify(self);

        // Yirefreshfooter 底部刷新按钮的使用
        refreshFooterThree= [[YiRefreshFooter alloc]init];
        refreshFooterThree.scrollView =tableViewThree;
        [refreshFooterThree footer];
        refreshFooterThree.beginRefreshingBlock =^{
                        [self loadDataFromApiWithIsFirstPage:NO];
        };
    }

}


-(void)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage{
    switch (currentIndex ) {
        case 1:
            tableViewOneLanguage =language;
            break;
            case 2:
            tableViewTwoLanguage =language;
            break;
            case 3:
            tableViewThreeLanguage = language;
            break;
        default:
            break;
    }

    [userRankViewModel loadDataFromApiWithIsFirstPage:isFirstPage currentIndex:currentIndex firstTableData:^(DataSourceModel *DataSourceOfPageListObject) {
       userRankDataSource.DataSourceOfPageListObjectOne = DataSourceOfPageListObject;
        dataSourceObjectTotalCountOne =DataSourceOfPageListObject.totalCount;

        [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld",(long)dataSourceObjectTotalCountOne] forState:UIControlStateNormal];
        [tableViewOne  reloadData];
        if (isFirstPage) {
            [refreshHeaderOne endRefreshing];
        }else{
            [refreshFooterOne endRefreshing];
        }
    } secondTableData:^(DataSourceModel *DataSourceOfPageListObject) {
        userRankDataSource.DatasourceOfPageListObjectTwo = DataSourceOfPageListObject;
        dataSourceObjectTotalCountTwo =DataSourceOfPageListObject.totalCount;

        [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld",(long)dataSourceObjectTotalCountTwo] forState:UIControlStateNormal];

        [tableViewTwo  reloadData];
        if (isFirstPage) {
            [refreshHeaderTwo endRefreshing];
        }else{
            [refreshFooterTwo endRefreshing];
        }
    } thirdTableData:^(DataSourceModel *DataSourceOfPageListObject) {
       userRankDataSource.DatasourceOfPageListObjectThree = DataSourceOfPageListObject;
        dataSourceObjectTotalCountThree =DataSourceOfPageListObject.totalCount;

        [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld",(long)dataSourceObjectTotalCountThree] forState:UIControlStateNormal];
        [tableViewThree  reloadData];
        if (isFirstPage) {
            [refreshHeaderThree endRefreshing];
        }else{
            [refreshFooterThree endRefreshing];
        }
    }];

}

#pragma mark - UItableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserDetailViewController * detailViewController =  [[UserDetailViewController  alloc]init];
    if (currentIndex ==1) {
        UserModel *userModel = [(userRankDataSource.DataSourceOfPageListObjectOne.dataSourceArray) objectAtIndex:indexPath.row];
        detailViewController.userModel =userModel;
    } else if (currentIndex ==2){
          UserModel *userModel = [(userRankDataSource.DatasourceOfPageListObjectTwo.dataSourceArray) objectAtIndex:indexPath.row];
        detailViewController.userModel =userModel;
    }else if (currentIndex ==3){
        UserModel *userModel = [(userRankDataSource.DatasourceOfPageListObjectThree.dataSourceArray) objectAtIndex:indexPath.row];
        detailViewController.userModel =userModel;
    }
    [self.navigationController pushViewController:detailViewController animated:YES];

}




#pragma mark - scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)tempScrollView{

    if (segmentControl.buttonCount ==2) {

        CGFloat scrollViewPageWidth =scrollView.frame.size.width;
    int currentPage =floor((scrollView.contentOffset.x-scrollViewPageWidth/ (2))/scrollViewPageWidth) +1;
        NSLog(@"currentPage %d",currentPage);

    currentIndex = currentPage +1;

            if (currentPage ==0) {


                [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld"
                                                     ,(long)dataSourceObjectTotalCountOne] forState:UIControlStateNormal];
                [scrollView scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, backGroundViewHeight) animated:NO];
                [scrollView setContentOffset:CGPointMake(0, 0)];

            }else if (currentPage >=(1)){
                currentPage =1;
                [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld"
                                                     ,(long)dataSourceObjectTotalCountTwo] forState:UIControlStateNormal];
                [scrollView scrollRectToVisible:CGRectMake(ScreenWidth *1, 0, ScreenWidth, backGroundViewHeight) animated:NO];
                [scrollView setContentOffset:CGPointMake(ScreenWidth *1, 0)];

            }
            [segmentControl swipeAction:(100+currentPage +1)];



    }
    else if (segmentControl.buttonCount ==3){
         CGFloat scrollViewPageWidth =scrollView.frame.size.width;
        int currentPage = floor((scrollView.contentOffset.x -scrollViewPageWidth/(3))/scrollViewPageWidth) +1;
        if (currentPage ==0 ) {
        [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld"
                                                 ,(long)dataSourceObjectTotalCountOne] forState:UIControlStateNormal];
        [scrollView scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, backGroundViewHeight) animated:NO];
        [scrollView setContentOffset:CGPointMake(0, 0)];

        }else if (currentPage ==1){
            
                        [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld"
                                                 ,(long)dataSourceObjectTotalCountTwo] forState:UIControlStateNormal];
            [scrollView scrollRectToVisible:CGRectMake(ScreenWidth * 1, 0, ScreenWidth, backGroundViewHeight) animated:NO];
            [scrollView setContentOffset:CGPointMake(0, 0)];

        }


        else if (currentPage >=(2)){
            [segmentControl.buttonFour setTitle:[NSString stringWithFormat:@"total:%ld"
                                                 ,(long)dataSourceObjectTotalCountThree] forState:UIControlStateNormal];
            currentPage =2;
            [scrollView  scrollRectToVisible:CGRectMake(ScreenWidth *2, 0, ScreenWidth, backGroundViewHeight) animated:NO];
            [scrollView setContentOffset:CGPointMake(ScreenWidth *2, 0)];
        }
        currentIndex = currentPage +1;
        [segmentControl swipeAction:(100+currentPage +1)];
    }

}





@end
