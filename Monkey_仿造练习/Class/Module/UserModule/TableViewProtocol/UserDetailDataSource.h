//
//  UserDetailDataSource.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/30.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetailDataSource : NSObject<UITableViewDataSource>

@property (nonatomic,strong) DataSourceModel *repositoryDataSourcePageListObject;
// repository Datasource
@property (nonatomic,strong) DataSourceModel *followingDataSourcePageListObject;
//following datasource
@property (nonatomic,strong) DataSourceModel *followerDataSourcePageListObject;
//follower datasource
@property (nonatomic,assign) int currentIndex;


@end
