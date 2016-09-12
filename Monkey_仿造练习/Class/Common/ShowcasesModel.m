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
    ShowcasesModel *model = [[ShowcasesModel alloc]init];
    model.name = [dict objectForKey:@"name"] ;
    model.slug = [dict objectForKey:@"slug"] ;
    model.DS = [dict objectForKey:@"description"] ;
    model.image_url = [dict objectForKey:@"image_url"] ;

    return model;


}

@end
