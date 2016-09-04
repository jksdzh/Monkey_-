
//
//  UserRankViewModel.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/27.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "UserRankViewModel.h"
@interface UserRankViewModel(){
    NSString *language;
}
@property (nonatomic,strong) DataSourceModel *DatasourceOfPageListObjectOne;
@property (nonatomic,strong) DataSourceModel *DatasourceOfPageListObjectTwo;
@property (nonatomic,strong) DataSourceModel *DatasourceOfPageListObjectThree;
@property (nonatomic,strong) NSString *tableViewOneLanguage;
@property (nonatomic,strong) NSString *tableViewTwoLanguage;
@property (nonatomic,strong) NSString *tableViewThreeLanguage;

@end
@implementation UserRankViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.DatasourceOfPageListObjectOne = [[DataSourceModel  alloc]init];
        self.DatasourceOfPageListObjectTwo =
        [[DataSourceModel alloc]init];
        self.DatasourceOfPageListObjectThree =[[DataSourceModel alloc]init];

    }
    return self;
}
//- (BOOL)validateUrl:(NSString *)candidate {
//    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
//    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
//    return [urlTest evaluateWithObject:candidate];
//}
- (BOOL)loadDataFromApiWithIsFirstPage:(BOOL)isFirstPage currentIndex:(int)currentIndex firstTableData:(UserRankDataSourceModelResponseBlock)firstCompletionBlock secondTableData:(UserRankDataSourceModelResponseBlock)secondCompletionBlock thirdTableData:(UserRankDataSourceModelResponseBlock)thirdCompletionBlock{
    if (currentIndex ==1) {
        NSInteger page =0;
        if (isFirstPage) {
            page =1;
        }else{
            page =self.DatasourceOfPageListObjectOne.page +1;
        }
        NSString *city = [[NSUserDefaults  standardUserDefaults] objectForKey:@"pinyinCity"];
        city = [city stringByReplacingOccurrencesOfString:@" "
                                               withString:@"%2B"
                ];
        if (city ==nil || city.length<1) {
            city=@"beijing";

        }
        language =[[NSUserDefaults standardUserDefaults] objectForKey:@"language"
                   ];
        NSString * q = [NSString stringWithFormat:@"location:%@+language:%@",city,language
                        ];
        if (language == nil || language.length <1) {
            language =NSLocalizedString(@"all languages"
                                        , @""
                                        );
        }
        _tableViewOneLanguage =language;
        if ([language  isEqualToString:NSLocalizedString(@"all languages"
                                                         , @"")])
             {
                 q =[NSString stringWithFormat:@"location:%@",city
                     ];
        }
        [ApplicationDelegate.apiEngine searchUserWithPage:page q:q sort:@"followers"
 categoryLocation:city categoryLanguage:language completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount)  {
     self.DatasourceOfPageListObjectOne.totalCount =totalCount;
     if (page <= 1) {
         [self.DatasourceOfPageListObjectOne.dataSourceArray removeAllObjects];
     }
     [self.DatasourceOfPageListObjectOne.dataSourceArray addObjectsFromArray:modelArray];
     self.DatasourceOfPageListObjectOne.page =page;
     firstCompletionBlock(self.DatasourceOfPageListObjectOne);


 } errorHandler:^(NSError *error) {
     firstCompletionBlock(self.DatasourceOfPageListObjectOne);

 }];
        return YES;
    }else if (currentIndex ==2){
        NSInteger page =0;
        if (isFirstPage) {
            page =1;
        }else{
            page =self.DatasourceOfPageListObjectTwo.page +1;
        }
        language =[[NSUserDefaults standardUserDefaults] objectForKey:@"language"
                   ];
        NSString *country = [[NSUserDefaults standardUserDefaults]objectForKey: @"country"
                             ];

        if (country ==nil ||country.length <1) {
            country =@"China";


        }
        NSString *q = [NSString stringWithFormat:@"location:%@+language:%@",country,language
                       ];
        if (language ==nil ||language.length <1) {
            language =NSLocalizedString(@"all languages"
                                        , @""
                                        );

        }
        self.tableViewTwoLanguage =language;
        if ([language isEqualToString:NSLocalizedString(@"all language"
                                                        , @""
)])
        {
            q =[NSString stringWithFormat:@"location:%@",country
                ];

        }

        [ApplicationDelegate.apiEngine searchUsersWithPage:page q:q sort:@"followers"
 completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
     self.DatasourceOfPageListObjectTwo.totalCount =totalCount;
     if (page <=1) {
         [self.DatasourceOfPageListObjectTwo.dataSourceArray removeAllObjects];

     }
     [self.DatasourceOfPageListObjectTwo.dataSourceArray addObjectsFromArray:modelArray];
     self.DatasourceOfPageListObjectTwo.page =page;
     secondCompletionBlock(self.DatasourceOfPageListObjectTwo);

 } errorHandler:^(NSError *error) {
     secondCompletionBlock(self.DatasourceOfPageListObjectTwo);


 }];
        return YES;
    }else if (currentIndex ==3){
        NSInteger page = 0;
        if (isFirstPage ) {
            page =1;
        }else{
            page =self.DatasourceOfPageListObjectThree.page +1;

        }
        language =[[NSUserDefaults standardUserDefaults] objectForKey:@"language"
                   ];
        if (language == nil ||language.length <1) {
            language =NSLocalizedString(@"all languages"
                                        , @""
                                        );
        }
        self.tableViewThreeLanguage =language;
        [ApplicationDelegate.apiEngine searchUsersWithPage:page q:[NSString stringWithFormat:@"language:%@",language
] sort:@"followers"
 completionHandler:^(NSArray *modelArray, NSInteger page, NSInteger totalCount) {
     self.DatasourceOfPageListObjectThree.totalCount =totalCount;
     if (page <=1) {
         [self.DatasourceOfPageListObjectThree.dataSourceArray removeAllObjects];
     }
     [self.DatasourceOfPageListObjectThree.dataSourceArray addObjectsFromArray:modelArray];
     self.DatasourceOfPageListObjectThree.page =page;
     thirdCompletionBlock(self.DatasourceOfPageListObjectThree);




 } errorHandler:^(NSError *error) {
     thirdCompletionBlock(self.DatasourceOfPageListObjectThree);
 }];
        return YES;

    }


    return YES;

}







@end
