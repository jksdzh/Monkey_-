//
//  RepositoryDetailDataSource.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/1.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,CURRENT_INDEX){
    contributorsCurrentIndex =1,
    forksCurrentIndex=2,
    stargazersCurrentIndex=3,
};

@interface RepositoryDetailDataSource : NSObject<UITableViewDataSource>
@property (nonatomic,strong) DataSourceModel *contributorsDataSourceOfPageListObject;
@property (nonatomic,strong) DataSourceModel *forksDataSourceOfPageListObject;
@property (nonatomic,strong) DataSourceModel *stargazersDataSourceOfPageListObject;
@property (nonatomic,assign) int currentIndex;
//current index in RepositoryDetailViewController

@end
