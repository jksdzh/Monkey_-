//
//  UserModel.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/25.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "UserModel.h"
#import <MJExtension.h>
@implementation UserModel

+(UserModel *)modelWithDict:(NSDictionary *)dict{
    if (!dict) {
        return nil;
    }
    [UserModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{

        return  @{@"userId":@"id"};
    }];
    UserModel *model = [UserModel mj_objectWithKeyValues:dict];


    return model;
}



@end
