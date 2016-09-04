//
//  TrendingViewModel.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/2.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "TrendingViewModel.h"
#import "YiNetworkEngine.h"
#import "TrendingViewController.h"

@interface TrendingViewModel(){
    NSString * language;
}
@property (nonatomic,strong) DataSourceModel *dailyDataSourceModel;
@property (nonatomic,strong) DataSourceModel *weeklyDataSourceModel;
@property (nonatomic,strong) DataSourceModel *monthlyDataSourceModel;
@property (nonatomic,strong) NSString *dailyTableViewLanguage;
@property (nonatomic,strong) NSString *weeklyTableViewLanguage;
@property (nonatomic,strong) NSString *monthlyTableViewLanguage;

@end
@implementation TrendingViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        //custom initialization
        self.dailyDataSourceModel =[[DataSourceModel alloc]init];
        self.weeklyDataSourceModel =[[DataSourceModel alloc]init];
        self.monthlyDataSourceModel =[[DataSourceModel alloc]init];

    }
    return self;
}


-(BOOL)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage currentTableViewIndex:(int)currentIndex firstTableData:(DataSourceModelResponseBlock)firstTableDataCompletionBlock secondTableDatA:(DataSourceModelResponseBlock)secondTableDataCompletionBlock thirdTableData:(DataSourceModelResponseBlock)thirdTableDataCompletionBlock{
    YiNetworkEngine * networkEngine =[[YiNetworkEngine alloc]initWithHostName:@"trending.codehub-app.com" customHeaderFields:nil];
    switch (currentIndex) {
        case dailyTrending:{
            NSInteger page =0;
            if (isFirstPage) {
                page = 1;
            } else{
                page = self.dailyDataSourceModel.page +1;
            }
            language =[[NSUserDefaults standardUserDefaults]objectForKey:@"language2"];
            if (language == nil || language.length <1) {
                language = NSLocalizedString(@"all languages", @"");
            }
            self.dailyTableViewLanguage =language;
            [networkEngine repositoriesTrendingWithType:@"daily" language:language completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
                self.dailyDataSourceModel.totalCount =totalCount;
                //refresh
                if (page<=1) {
                    [self.dailyDataSourceModel.dataSourceArray removeAllObjects];
                }
                 self.dailyDataSourceModel.page = page;
                [self.dailyDataSourceModel.dataSourceArray addObjectsFromArray:modelArray];
                firstTableDataCompletionBlock(self.dailyDataSourceModel);
            } errorHandler:^(NSError *error) {
                firstTableDataCompletionBlock(self.dailyDataSourceModel);
            }];

        }
            return YES;
            break;
        case weeklyTrending:{
            NSInteger page =0;
            if (isFirstPage) {
                page = 1;
            } else{
                page = self.weeklyDataSourceModel.page +1;
            }
            language = [[NSUserDefaults standardUserDefaults]objectForKey:@"language2"];
            if (language ==nil ||language.length<1) {
                language =NSLocalizedString(@"all languages", @"");
            }
            [networkEngine repositoriesTrendingWithType:@"weekly" language:language completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
                if (page <=1) {
                    [self.weeklyDataSourceModel.dataSourceArray removeAllObjects];
                }
                self.weeklyDataSourceModel.page =page;
                self.weeklyDataSourceModel.totalCount =totalCount;
                [self.weeklyDataSourceModel.dataSourceArray addObjectsFromArray:modelArray];
                secondTableDataCompletionBlock(self.weeklyDataSourceModel);
            } errorHandler:^(NSError *error) {
                    secondTableDataCompletionBlock(self.weeklyDataSourceModel);
            }];


        }
            return YES;
            break;
        case monthlyTrending:{
            NSInteger page =0;
            if (isFirstPage) {
                page =1;
            }else{
                page =self.monthlyDataSourceModel.page +1;
            }
            language =[[NSUserDefaults standardUserDefaults]objectForKey:@"language2"];
            if (language ==nil ||language.length <1) {
                language =NSLocalizedString(@"all languages", @"");
            }
            [networkEngine repositoriesTrendingWithType:@"monthly" language:language completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
                if (page <=1) {
                    [self.monthlyDataSourceModel.dataSourceArray  removeAllObjects];
                }
                self.monthlyDataSourceModel.page =page;
                self.monthlyDataSourceModel.totalCount =totalCount;
                [self.monthlyDataSourceModel.dataSourceArray addObjectsFromArray:modelArray];
                thirdTableDataCompletionBlock(self.monthlyDataSourceModel);


            } errorHandler:^(NSError *error) {
                thirdTableDataCompletionBlock(self.monthlyDataSourceModel);
            }];
             }
            return YES;
            break;

        default:
            break;
    }

    return YES;



}
@end
