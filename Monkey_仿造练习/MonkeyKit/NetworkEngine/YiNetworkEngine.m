//
//  YiNetworkEngine.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/25.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "YiNetworkEngine.h"
#import "RepositoryModel.h"
#import "ShowcasesModel.h"
#import "AESCrypt.h"
#import "UserModel.h"
@implementation YiNetworkEngine
#pragma mark - login module
//github redirects back to your site
//https://developer.github.com/v3/oauth/#github-redirects-back-to-your-site
//POST https://github.com/login/oauth/access_token

    
-(MKNetworkOperation *)loginWithCode:(NSString *)code completionHandler:(StringResponseBlock)completionHandler errorHandler:(MKNKErrorBlock)errorHandler{
    NSString * getString = [NSString stringWithFormat:@"/login/oauth/access_token/" ];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[[AESCrypt decrypt:CoderyiClientID password:@"xxxsd-sdsd*sd672323q___---_w.."]substringFromIndex:1] forKey:@"client_id"];
    [dict setValue:[[AESCrypt decrypt:CoderyiClientSecret password:@"xx3xc45sqvzupb4xsd-sdsd*sd672323q___---_w.."] substringFromIndex:1] forKey:@"client_secret"];
    [dict setValue:code forKey:@"code"];
    [dict setValue:@"1995"
            forKey:@"state"
     ];
    [dict setValue:@"https://github.com/coderyi/monkey"
            forKey:@"redirect_uri"];
    MKNetworkOperation *operation = [self operationWithPath:getString params:dict httpMethod:@"POST"
                                                       ssl:YES];
  [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
      completionHandler([completedOperation responseString]);
      
  } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
      errorHandler(error);
  }];
    [self enqueueOperation:operation];
    return operation;
}
//https://developer.github.com/v3/oauth/#use-the-access-token-to-access-the-api
-(MKNetworkOperation *)getUserInfoWithToken:(NSString *)token completionHandler:(UserModelResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{

    if (token.length <1 || !token)
    {
        token = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"
                 ];
    }
        NSString * getString =[NSString stringWithFormat:@"/user?access_token=%@",token
                               ];
        MKNetworkOperation * operation = [self operationWithPath:getString params:nil httpMethod:@"GET"
                                                             ssl:YES];
        NSLog(@"%@",operation.url
              );

        [operation addCompletionHandler:^(MKNetworkOperation *completedOperation)
        {
            if ([[completedOperation responseJSON] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *resultDictionary = [completedOperation responseJSON];
                UserModel *model =[UserModel modelWithDict:resultDictionary];
                completionBlock(model);
            }
        }
                           errorHandler:^(MKNetworkOperation *errorOperation, NSError *error)
        {
            errorBlock(error);
        }
         ];
        [self enqueueOperation:operation];
        return operation;


    }



#pragma mark - event news

    - (MKNetworkOperation *)repositoriesTrendingWithPage:(NSInteger)page login:(NSString *)login
completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)
    errorBlock
{
    NSString *getString = [NSString stringWithFormat:@"/users/%@/received_events?&page=%ld",login,(long)page];
    MKNetworkOperation * operatioon =[self operationWithPath:getString params:nil httpMethod:@"GET"
                                                         ssl:YES];
    [operatioon addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]isKindOfClass:[NSArray class]]) {
            NSArray * list = [completedOperation responseJSON];
            if (list.count >0) {
                NSMutableArray * listNew =[[NSMutableArray alloc]initWithCapacity:32];
                for (NSInteger i = 0; i <list.count; i++) {
                    NSDictionary *dict =[list objectAtIndex:i];
//                    UserReceiveEventModel * model =[UserReceiveEventModel ];
                    //TODO:news network

                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        errorBlock(error);
    }];

    [self enqueueOperation:operatioon];
    return operatioon;
    }

-(MKNetworkOperation *)showcasesDetailListWithShowcase:(NSString *)showcase completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    NSString *getString = [NSString stringWithFormat:@"/v2/showcases/%@",showcase
                           ];
    MKNetworkOperation * operation = [self operationWithPath:getString params:nil httpMethod:@"GET"
                                                         ssl:NO];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation)
    {
        if ([[completedOperation responseJSON]isKindOfClass:[NSDictionary class]])
        {
            NSDictionary * resultDictionary = [completedOperation responseJSON];
            NSArray * list =[resultDictionary objectForKey:@"repositories"
                             ];
            if ([list isKindOfClass:[NSArray class]])
            {
                if (list.count >0)
                {
                    NSMutableArray * listNew =
                    [[NSMutableArray alloc]initWithCapacity:32];
                    for (NSInteger i = 0; i <list.count; i++)
                    {
                        NSDictionary * dict = [list objectAtIndex:i];
                        RepositoryModel * model = [RepositoryModel modelWithDict:dict];
                        [listNew addObject:model];
                    }
                    completionBlock(listNew,0,1);

                }
            }
        }



    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:operation];
    return operation;

}
-(MKNetworkOperation *)repositoriesTrendingWithType:(NSString *)type language:(NSString *)language completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock )errorBlock{
    NSString * getString ;
    if (language.length <1 || !language ||[language isEqualToString:NSLocalizedString(@"all languages",@""
)]){ getString = [NSString stringWithFormat:@"/v2/trending?since=%@",type];
    }else{
        getString = [NSString stringWithFormat:@"/v2/trending?since=%@&language=%@",type,language
                     ];

    }
     MKNetworkOperation * operation =
    [self operationWithPath:getString params:nil httpMethod:@"GET"
                        ssl:NO];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation)
    {
        if ([[completedOperation responseJSON]isKindOfClass:[NSArray class]])
        {
            NSArray * list = [completedOperation responseJSON];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count >0) {
                    NSMutableArray * listNew = [[NSMutableArray alloc]initWithCapacity:32];
                    for (NSInteger i = 0; i <list.count; i++) {
                        NSDictionary *dict  =[list objectAtIndex:i];
                        RepositoryModel * model = [RepositoryModel modelWithDict:dict];
                        [listNew addObject:model];
                    }
                    completionBlock (listNew,0,1);

                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        errorBlock(error);

    }];
    [self enqueueOperation:operation];
    return operation;
}
-(MKNetworkOperation *)showcasesWithCompletionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    NSString * getString = [ NSString stringWithFormat:@"/v2/showcases"
                            ];
    MKNetworkOperation * operation = [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:NO
                                      ];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]isKindOfClass:[NSArray class]]) {
            NSArray * list = [completedOperation responseJSON];
            if (list.count > 0) {
                NSMutableArray * listNew =[[NSMutableArray alloc]initWithCapacity:32];
                for (NSInteger i = 0; i <list.count; i++) {
                    NSDictionary * dict =[list objectAtIndex:i];
                    ShowcasesModel * model = [  ShowcasesModel modelWithDict:dict];
                    [listNew addObject:model];
                }
                completionBlock(listNew,0,1);
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:operation];
    return operation;



}

#pragma mark - starmodule
-(MKNetworkOperation *)checkStarStatusWithOwner:(NSString *)owner repo:(NSString *)repo comletionHandler:(void (^)(BOOL))completionBlock errorHandler:(MKNKErrorBlock)errorBlock{

    NSString *access_token = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"
                              ];
    NSString *getString = [ NSString stringWithFormat:@"/user/starrrd/%@/%@?access_token=%@",owner,repo,access_token
                           ];
    MKNetworkOperation *operation =[self operationWithPath:getString params:nil httpMethod:@"GET"
                                                       ssl:YES];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completedOperation.HTTPStatusCode ==204) {
            completionBlock(YES);
        }else if (completedOperation.HTTPStatusCode ==404){
            completionBlock(NO);

        }
    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        if (errorOperation.HTTPStatusCode ==204) {
            completionBlock(YES);
        }else if (errorOperation.HTTPStatusCode ==404){
            errorBlock(error);
        }
    }];

    [self enqueueOperation:operation];
    return operation;


}

//Star a repository
//PUT /user/starred/:owner/:repo
- (MKNetworkOperation *)starRepoWithOwner:(NSString *)owner repo:(NSString *)repo comletionHandler:(void (^)(BOOL))completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    NSString *access_token = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    NSString *getString = [NSString stringWithFormat:@"/user/starred/%@/%@?access_token=%@",owner,repo,access_token
                           ];
    MKNetworkOperation *operation = [self operationWithPath:getString params:nil httpMethod:@"PUT"
                                                        ssl:YES];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completedOperation.HTTPStatusCode == 204) {
            completionBlock(YES);
        }else if (completedOperation.HTTPStatusCode ==404){
            completionBlock(NO)
            ;        }
    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        if (errorOperation.HTTPStatusCode ==204) {
            completionBlock(YES);
        }else if (errorOperation.HTTPStatusCode ==404){
            completionBlock(NO);
        }else{
            errorBlock(error);
        }
    }];
    [self enqueueOperation:operation];
    return operation;

}
-(MKNetworkOperation *)unStarRepoWithOwner:(NSString *)owner repo:(NSString *)repo comletionHandler:(void (^)(BOOL))completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    NSString *access_token =[[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"
                             ];
    NSString *getString = [NSString stringWithFormat:@"/user/starred/%@/%@?access_token=%@",owner,repo,access_token
                           ];
    MKNetworkOperation * operation =[self operationWithPath:getString params:nil httpMethod:@"DELETE"
                                                        ssl:YES];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completedOperation.HTTPStatusCode ==204) {
            completionBlock(YES);
        }else if (completedOperation.HTTPStatusCode ==404){
            completionBlock(NO);
        }
    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        if (errorOperation.HTTPStatusCode ==204) {
            completionBlock(YES);
        }else if (errorOperation.HTTPStatusCode ==404){
            completionBlock(NO);
        }else{
            errorBlock(error);
        }
    }];
    [self enqueueOperation:operation];
    return operation;
}

#pragma mark - followModule
//Check if one user follows another
//https://developer.github.com/v3/users/followers/#check-if-one-user-follows-another
-(MKNetworkOperation *)checkFollowStatusWithUserName:(NSString *)username target_user:(NSString *)target_user completionHandler:(void (^)(BOOL))completionBlock errorHandler:(MKNKErrorBlock )errorBlock{

    if (username.length<1) {
        username =[[NSUserDefaults standardUserDefaults]objectForKey:@"currentLogin"
                   ];
    }
        NSString *getString = [NSString stringWithFormat:@"/users/%@/following/%@",username,target_user
                               ];
        MKNetworkOperation * operation =[self operationWithPath:getString params:nil httpMethod:@"GET"
                                                            ssl:YES];
        [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            if (completedOperation.HTTPStatusCode ==204) {
                completionBlock(YES);
            }else if (completedOperation.HTTPStatusCode ==404){
                completionBlock(NO);
            }
        } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
            if (errorOperation.HTTPStatusCode ==204) {
                completionBlock(YES);
            }else if (errorOperation.HTTPStatusCode ==404){
                completionBlock(NO);
            }else{
                errorBlock(error);
            }
        }];
        [self enqueueOperation:operation];
        return operation;






}
- (MKNetworkOperation *)followUserWithUsername:(NSString *)username target_user:(NSString *)target_user completionHandler:(void (^)(BOOL))completionBlock errorHandler:(MKNKErrorBlock)errorBlock{

    if (username.length<1) {
        username = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentLogin"
                    ];
    }
    NSString *access_token = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"];
    NSString * getString = [NSString stringWithFormat:@"/user/following/%@?access_token=%@",target_user,access_token
                            ];
    MKNetworkOperation * operation =[self operationWithPath:getString params:nil httpMethod:@"PUT"
                                                        ssl:YES];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if (completedOperation.HTTPStatusCode ==204) {
            completionBlock(YES);
        }else if (completedOperation.HTTPStatusCode ==404){
            completionBlock(NO);
        }
    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        if (errorOperation.HTTPStatusCode ==204) {
            completionBlock(YES);
        }else if (errorOperation.HTTPStatusCode ==404){
            completionBlock(NO);
        }else{
            errorBlock(error);
        }
    }];
    [self enqueueOperation:operation];
    return operation;


}


-(MKNetworkOperation *)unfollowUserWithUsername:(NSString *)username target_user:(NSString *)target_user completionHandler:(void (^)(BOOL))completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    if (username.length <1) {
        username = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"
                    ];}

        NSString *access_token = [[NSUserDefaults standardUserDefaults]objectForKey:@"access_token"
                                  ];
        NSString *getString = [NSString stringWithFormat:@"/user/following/%@?access_token=%@",target_user,access_token
                               ];
        MKNetworkOperation * operation =[self operationWithPath:getString params:nil httpMethod:@"DELETE"
                                                            ssl:YES];
        [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            if (completedOperation.HTTPStatusCode ==204) {
                completionBlock(YES);
            }else if (completedOperation.HTTPStatusCode ==404){
                completionBlock(NO);
            }
        } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
            if (errorOperation.HTTPStatusCode ==204) {
                completionBlock(YES);
            }else if (errorOperation.HTTPStatusCode ==404){
                completionBlock(NO);
            }else{
                errorBlock(error);
            }
        }];
        [self enqueueOperation:operation];
        return operation;

}
#pragma mark - users module
//https://developer.github.com/v3/search/#search-users
//Search users
-(MKNetworkOperation*)searchUsersWithPage:(NSInteger)page q:(NSString*)q sort:(NSString*)sort
                       completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    NSString *getString = [NSString stringWithFormat:@"/search/users?q=%@&sort=%@&page=%ld",q,sort,(long)page
                           ];
    MKNetworkOperation *operation =[self operationWithPath:getString params:nil httpMethod:@"GET"
                                                       ssl:YES];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON] isKindOfClass:[NSDictionary class]]) {
            NSDictionary * resultDictionary = [completedOperation  responseJSON];
            NSInteger totalCount =[[resultDictionary objectForKey:@"total_count"
                                    ] intValue];
            NSArray *list =[resultDictionary objectForKey:@"items"
                            ];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count >0) {
                    NSMutableArray *listNew =[[NSMutableArray alloc]initWithCapacity:32];
                    for (NSInteger i = 0; i <list.count; i++) {
                        NSDictionary *dict =[list objectAtIndex:i];
                        UserModel *model =[UserModel modelWithDict:dict];
                        [listNew  addObject:model];
                    }
                    completionBlock(listNew,page,totalCount);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:operation];
    return operation;

}



-(MKNetworkOperation *)searchUserWithPage:(NSInteger)page q:(NSString *)q sort:(NSString *)sort categoryLocation:(NSString *)categoryLocation categoryLanguage:(NSString *)categoryLanguage completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{

    NSString *getString = [NSString stringWithFormat:@"/search/users?q=%@&sort=%@&page=%ld",q,sort,(long)page];
    MKNetworkOperation * operation =[self operationWithPath:getString params:nil httpMethod:@"GET"
                                                        ssl:YES];

    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]isKindOfClass:[NSDictionary class]]) {
            NSDictionary * resultDictionary = [completedOperation responseJSON];
            NSInteger totalCount = [[resultDictionary objectForKey:@"total_count"
                                     ]integerValue];
            NSArray * list = [resultDictionary objectForKey:@"items"
                              ];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count >0) {
                    NSMutableArray *listNew = [[NSMutableArray alloc]initWithCapacity:32];
                    for (NSInteger i = 0; i <list.count; i++) {
                        NSDictionary *dict =[list objectAtIndex:i];
                        UserModel *model = [UserModel modelWithDict:dict];
                        model.rank =(int)((page -1)*30 +(i+1));
                        model.categoryLanguage =categoryLanguage;
                        model.categoryLocation =categoryLocation;
                        model.myID = [[NSDate date]timeIntervalSince1970];

                        [listNew addObject:model];
                    }
                    completionBlock (listNew,page,totalCount);
                }
            }
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
        NSLog(@"error---=====%@",error
              );
    }];

    [self enqueueOperation:operation];

    return operation;

}

//https://developer.github.com/v3/search/#search-users
//Get a single user ,GET /users/:username


- (MKNetworkOperation *)userDetailWithUserName:(NSString *)userName completionHandler:(UserModelResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    NSString *getString = [NSString stringWithFormat:@"/users/%@",userName];
    MKNetworkOperation *operation =
    [self operationWithPath:getString params:nil httpMethod:@"GET" ssl:YES];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]
             isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = [completedOperation responseJSON];
            UserModel *model = [UserModel modelWithDict:resultDictionary];
            completionBlock(model);
        }
    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:operation];
    return operation;


}
//https://developer.github.com/v3/repos/#list-user-repositories
//List user repositories
//GET /users/:username/repos
-(MKNetworkOperation *)userRepositoriesWithPage:(NSInteger)page userName:(NSString *)userName completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    NSString * getString = [ NSString stringWithFormat: @"/users/%@/repos?sort=updated&page=%ld",userName,(long)page
                            ];
    MKNetworkOperation *operation = [self operationWithPath:getString params:nil httpMethod:@"GET"
                                                        ssl:YES];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]isKindOfClass:[NSArray class]]) {
            NSArray *list = [completedOperation responseJSON];

            if (list.count > 0) {
                NSMutableArray *listNew =[[NSMutableArray alloc]initWithCapacity:32];
                for (NSInteger i = 0; i <list.count; i++) {
                    NSDictionary *dict =[list objectAtIndex:i];
                    RepositoryModel *model = [RepositoryModel modelWithDict:dict];
                    [listNew addObject:model];
                }
                completionBlock (listNew,page,0);
            }
        }
        }
    errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:operation];
    return operation;

}
//list followers of a user
//https://developer.github.com/v3/users/followers/#list-followers-of-a-user
//GET /users/:username/followers

-(MKNetworkOperation *)userFollowersWithPage:(NSInteger)page userName:(NSString *)userName completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    NSString *getString = [NSString stringWithFormat:@"/users/%@/followers?page=%ld",userName,(long)page
                            ];
    MKNetworkOperation * operation = [self operationWithPath:getString params:nil httpMethod:@"GET"
                                                         ssl:YES];

    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]isKindOfClass:[NSArray class]]) {
            NSArray *list =[completedOperation responseJSON];
            if ([list isKindOfClass:[NSArray class]]) {
                                            if (list.count >0) {
                            NSMutableArray *listNew =[[NSMutableArray alloc]initWithCapacity:32];
                            for (NSInteger i = 0; i <list.count; i++) {
                                NSDictionary *dict =[list objectAtIndex:i];
                                UserModel *model =[UserModel modelWithDict:dict];
                                [listNew addObject:model];
                            }
                            completionBlock(listNew,page,0);
                        }
                    }

        }
    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        errorBlock(error);
    }];
            [self enqueueOperation:operation];
            return operation;

}

//List users followed by another user
//https://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
//GET /users/:username/following
-(MKNetworkOperation *)userFollowingWithPage:(NSInteger)page userName:(NSString *)userName completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    NSString * getString = [NSString stringWithFormat:@"/users/%@/following?page=%ld",userName,(long)page
                            ];
    MKNetworkOperation *operation = [self operationWithPath:getString params:nil httpMethod:@"GET"
                                                        ssl:YES];

    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]isKindOfClass:[NSArray class]]) {
            NSArray * list = [completedOperation responseJSON];
            if ([list isKindOfClass:[NSArray class]]) {
                if (list.count >0) {
                    NSMutableArray *listNew = [[NSMutableArray alloc]initWithCapacity:32];
                    for (NSInteger i = 0; i <list.count; i++) {
                        NSDictionary * dict = [list objectAtIndex:i];
                        UserModel * model = [UserModel modelWithDict:dict];
                        [listNew addObject:model];

                    }
                    completionBlock (listNew ,page,0);
                }
            }



        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:operation];
    return operation;


}


#pragma mark - repositories module 
//https://developer.github.com/v3/search/#search-repositories
//Search repositories
- (MKNetworkOperation *)searchRepositoriesWithPage:(NSInteger)page q:(NSString *)q sort:(NSString *)sort completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    NSString * getString = [ NSString stringWithFormat:@"/search/repositories?q=%@&sort=%@&page=%ld",q,sort,(long)page
                            ];
    MKNetworkOperation * operation =[self operationWithPath:getString params:nil httpMethod:@"GET"
                                                        ssl:YES];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
    if ([[completedOperation responseJSON]
         isKindOfClass:[NSDictionary class]]) {
        NSDictionary *resultDictionary = [completedOperation responseJSON];
        NSInteger totalCount=[[resultDictionary objectForKey:@"total_count"] intValue];
        NSArray *list = [resultDictionary objectForKey:@"items"];
        if ([list isKindOfClass:[NSArray class]]) {
            if (list.count > 0) {
                NSMutableArray *listNew =
                [[NSMutableArray alloc] initWithCapacity:32];
                for (NSInteger i = 0; i < list.count; i++) {
                    NSDictionary *dict = [list objectAtIndex:i];
                    RepositoryModel *model = [RepositoryModel modelWithDict:dict];
                    [listNew addObject:model];
                }
                completionBlock(listNew, page,totalCount);
            }
        }
    }
} errorHandler:^(MKNetworkOperation *errorOp, NSError *error) {
    errorBlock(error);
}];
[self enqueueOperation:operation];
return operation;
}
//https://developer.github.com/v3/repos/#get
//Get
//GET /repos/:owner/:repo
- (MKNetworkOperation *)repositoriesDetailWithUserName:(NSString *)userName repositoryName:(NSString *)repositoryName completionHandler:(RepositoryModelResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    NSString * getString = [NSString stringWithFormat:@"/repos/%@/%@",userName,repositoryName] ;
    MKNetworkOperation *operation =[self operationWithPath:getString params:nil httpMethod:@"GET"
                                                       ssl:YES];

    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        if ([[completedOperation responseJSON]isKindOfClass:[NSDictionary class]]) {
            NSDictionary * resultDictionary =[completedOperation responseJSON];


                        RepositoryModel *model = [RepositoryModel modelWithDict: resultDictionary];
            completionBlock(model);
                     }
    } errorHandler:^(MKNetworkOperation *errorOperation, NSError *error) {
        errorBlock(error);
    }];
    [self enqueueOperation:operation];
    return operation;

}

//https://developer.github.com/v3/repos/#list-contributors
//List contributors ,GET /repos/:owner/:repo/contributors

//https://developer.github.com/v3/repos/forks/#list-forks
//List forks ,       GET /repos/:owner/:repo/forks

//https://developer.github.com/v3/activity/starring/#list-stargazers
//List Stargazers ,GET /repos/:owner/:repo/stargazers
-(MKNetworkOperation *)repositoriesDetailCategoryWithPage:(NSInteger)page userName:(NSString *)userName repositoryName:(NSString *)repositoryName category:(NSString *)category completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock{
    if ([category  isEqualToString:@"forks"
                                        ]) {
        NSString *getString =[NSString stringWithFormat:@"/repos/%@/%@/%@?page=%ld",userName,repositoryName,category,(long)page];
        MKNetworkOperation *operation =[self operationWithPath:getString params:nil httpMethod:@"GET"
                                                           ssl:YES];
        [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            if ([[completedOperation  responseJSON]isKindOfClass:[NSArray class]]) {
                NSArray * list =[completedOperation responseJSON];
                if ([list isKindOfClass:[NSArray class]]) {
                    if (list.count >0) {
                        NSMutableArray *listNew = [[NSMutableArray alloc ]initWithCapacity:32];
                        for (NSInteger i = 0; i <list.count; i++) {
                            NSDictionary *dict =[list objectAtIndex:i];
                            RepositoryModel *model =[RepositoryModel  modelWithDict:dict];
                            [listNew  addObject:model];
                        }
                        completionBlock(listNew,page,0);
                    }
                }
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            errorBlock(error);

        }];
        [self enqueueOperation:operation];
        return operation;

    }else{
        NSString * getString = [NSString stringWithFormat:@"/repos/%@/%@/%@?page=%ld",userName,repositoryName,category,(long)page] ;
        NSLog(@"...........getstring%@",getString);

        MKNetworkOperation *operation = [self operationWithPath:getString params:nil httpMethod:@"GET"
                                                            ssl:YES];
        [operation  addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            if ([[completedOperation responseJSON]isKindOfClass:[NSArray class]]) {
                NSArray *list =[completedOperation responseJSON];
                if ([list  isKindOfClass:[NSArray class]]) {

                    if (list.count >0) {
                        NSMutableArray *listNew =[[NSMutableArray alloc]initWithCapacity:32];

                        for (NSInteger i = 0; i <list.count; i++) {
                            NSDictionary * dict =[list objectAtIndex:i];
                            UserModel *model = [UserModel modelWithDict:dict];
                            [listNew addObject:model];

                        }
                        completionBlock(listNew,page,0);
                    }
                }
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            errorBlock(error);
        }];
        [self enqueueOperation:operation];
        return operation;
    }
    return nil;

}



@end

