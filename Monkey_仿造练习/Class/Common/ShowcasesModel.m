//
//  ShowcasesModel.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/25.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "ShowcasesModel.h"
#import <MJExtension.h>
@implementation ShowcasesModel
+(ShowcasesModel *)modelWithDict:(NSDictionary *)dict{
    if (!dict) {
        return Nil;
    }
    ShowcasesModel *model = [ShowcasesModel mj_objectWithKeyValues:dict];
    return model;

}

@end
