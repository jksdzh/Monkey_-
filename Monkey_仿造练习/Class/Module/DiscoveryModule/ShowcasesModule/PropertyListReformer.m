//
//  PropertyListReformer.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/7.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "PropertyListReformer.h"
#import "UIImageView+WebCache.h"

NSString * const kPropertyListDataKeyName =@"kPropertyListDataKeyName";
NSString * const kPropertyListDataKeySlug =@"kPropertyListDataKeySlug";
NSString * const kPropertyListDataKeyDescription =@"kPropertyListDataKeyDescription";
NSString * const kPropertyListDataKeyImage =@"kPropertyListDataKeyImage";

@implementation PropertyListReformer

-(NSDictionary *)reformData:(NSDictionary *)originData fromManager:(id)manager{
    NSDictionary *resultData =nil;
    resultData =@{
kPropertyListDataKeyName:originData[@"name"],
kPropertyListDataKeySlug:originData[@"slug"],
kPropertyListDataKeyImage:originData[@"image_url"],
kPropertyListDataKeyDescription:originData[@"description"]
    
};
    return resultData;


}
@end
