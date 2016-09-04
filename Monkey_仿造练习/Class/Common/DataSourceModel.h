//
//  DataSourceModel.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/25.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSourceModel : NSObject
@property (nonatomic,strong) NSMutableArray *dataSourceArray;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger totalCount;

-(void)reset;
@end
