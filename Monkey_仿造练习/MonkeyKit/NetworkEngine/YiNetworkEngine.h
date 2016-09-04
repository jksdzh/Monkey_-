//
//  YiNetworkEngine.h
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/8/25.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "UserModel.h"
#import "RepositoryModel.h"
typedef void (^MKNKErrorBlock)(NSError *error);
typedef void  (^PageListInfoResponseBlock)(NSArray *modelArray,NSInteger page,NSInteger totalCount);
typedef void (^UserModelResponseBlock )(UserModel * model);
typedef void (^RepositoryModelResponseBlock) (RepositoryModel *model);
typedef void (^StringResponseBlock)(NSString * response);
@interface YiNetworkEngine : MKNetworkEngine

#pragma mark - login module

- (MKNetworkOperation *)loginWithCode:(NSString *)code
                     completionHandler:(StringResponseBlock)completionHandler
                          errorHandler:(MKNKErrorBlock)errorHandler;
-(MKNetworkOperation *)getUserInfoWithToken:(NSString *)token
                          completionHandler:(UserModelResponseBlock)completionBlock
                               errorHandler:(MKNKErrorBlock)
errorBlock;
#pragma mark - event news
- (MKNetworkOperation *)repositoriesTrendingWithPage:(NSInteger)page login:(NSString *)login
                                   completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)
errorBlock;

#pragma mark - trending 
-(MKNetworkOperation *)showcasesDetailListWithShowcase:(NSString *)showcase completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock;
-(MKNetworkOperation *)repositoriesTrendingWithType:(NSString *)type language:(NSString*)language completionHandler:(PageListInfoResponseBlock)completionBlock
                                       errorHandler:(MKNKErrorBlock)errorBlock;

-(MKNetworkOperation *)showcasesWithCompletionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock;

#pragma mark - followModule
//Check if one user follows another
//https://developer.github.com/v3/users/followers/#check-if-one-user-follows-another
-(MKNetworkOperation *)checkFollowStatusWithUserName:(NSString*)username target_user:(NSString*)target_user completionHandler:(void (^)(BOOL isFollowing) )completionBlock
                                        errorHandler:(MKNKErrorBlock)errorBlock;

-(MKNetworkOperation *)followUserWithUsername:(NSString*)username target_user:(NSString*)target_user completionHandler:(void(^)(BOOL isSuccess))completionBlock
                                 errorHandler:(MKNKErrorBlock)errorBlock;
-(MKNetworkOperation *)unfollowUserWithUsername:
(NSString*)username target_user:(NSString*)target_user completionHandler:(void(^)(BOOL isSuccess))completionBlock
                                   errorHandler:(MKNKErrorBlock)errorBlock;
#pragma mark - starmodule
-(MKNetworkOperation *)checkStarStatusWithOwner:(NSString*)owner repo:(NSString*)repo comletionHandler:(void (^)(BOOL isStarred))completionBlock
                                   errorHandler:(MKNKErrorBlock)errorBlock;
//star a repository
//PUT /user/starred/:owner/:repo
- (MKNetworkOperation *)starRepoWithOwner:(NSString*)owner repo:(NSString*)repo comletionHandler:(void (^)(BOOL isSuccess))completionBlock
                             errorHandler:(MKNKErrorBlock)errorBlock;


-(MKNetworkOperation *)unStarRepoWithOwner:(NSString*)owner repo:(NSString*)repo comletionHandler:(void (^)(BOOL isSuccess))completionBlock
                              errorHandler:(MKNKErrorBlock)errorBlock;
#pragma mark - users module

//https://developer.github.com/v3/search/#search-users
//Search users
-(MKNetworkOperation*)searchUsersWithPage:(NSInteger)page q:(NSString*)q sort:(NSString*)sort
                        completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock;

- (MKNetworkOperation *)searchUserWithPage:(NSInteger)page q:(NSString *)q sort:(NSString *)sort categoryLocation:(NSString *)
categoryLocation categoryLanguage:(NSString *)categoryLanguage completionHandler:(PageListInfoResponseBlock)completionBlock
                              errorHandler:(MKNKErrorBlock)errorBlock;
//https://developer.github.com/v3/users/#get-a-single-user
//Get a single user ,GET /users/:username
-(MKNetworkOperation *)userDetailWithUserName:(NSString *)userName completionHandler:(UserModelResponseBlock)completionBlock
                                 errorHandler:
(MKNKErrorBlock)errorBlock;
//https://developer.github.com/v3/repos/#list-user-repositories
// List user repositories
//GET /users/:username/repos
- (MKNetworkOperation *)userRepositoriesWithPage:(NSInteger)page userName:(NSString *)userName  completionHandler:(PageListInfoResponseBlock)completionBlock
errorHandler:
(MKNKErrorBlock)errorBlock;

//List users follow followed by another user
//https://developer.github.com/v3/users/followers/#list-users-followed-by-another-user
//GET /users/:username/following
- (MKNetworkOperation *)userFollowingWithPage:(NSInteger)page userName:(NSString *)userName completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock;

//List followers of a user
//https://developer.github.com/v3/users/followers/#list-followers-of-a-user
//GET /users/:username/followers


-(MKNetworkOperation *)userFollowersWithPage:(NSInteger)page userName:(NSString *)userName completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock;
#pragma mark - repositories module

//https://developer.github.com/v3/search/#search-repositories
//Search repositories

-(MKNetworkOperation *)searchRepositoriesWithPage:(NSInteger)page q:(NSString *)q
                                             sort:(NSString *)sort
                                completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock;

//https://developer.github.com/v3/repos/#get
//Get
//GET /repos/:owner/:repo
- (MKNetworkOperation *)repositoriesDetailWithUserName:(NSString *)userName repositoryName:(NSString *)repositoryName completionHandler:(RepositoryModelResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock;
//https://developer.github.com/v3/repos/#list-contributors
//List contributors ,GET /repos/:owner/:repo/contributors

//https://developer.github.com/v3/repos/forks/#list-forks
//List forks ,       GET /repos/:owner/:repo/forks

//https://developer.github.com/v3/activity/starring/#list-stargazers
//List Stargazers ,GET /repos/:owner/:repo/stargazers

-(MKNetworkOperation *)repositoriesDetailCategoryWithPage:(NSInteger)page userName:(NSString *)userName repositoryName:(NSString*)repositoryName
category:(NSString*)category completionHandler:(PageListInfoResponseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock;


@end
