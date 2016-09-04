//
//  RepositoryDetailDataSource.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/1.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "RepositoryDetailDataSource.h"
#import "RankTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RepositoryDetailViewModel.h"



@implementation RepositoryDetailDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    switch (self.currentIndex) {
     
        case contributorsCurrentIndex: {
            return

            self.contributorsDataSourceOfPageListObject.dataSourceArray.count;
   }
            break;

        case forksCurrentIndex: {
            return
            self.forksDataSourceOfPageListObject.dataSourceArray.count;
               }
            break;

        case stargazersCurrentIndex: {

            return self.stargazersDataSourceOfPageListObject.dataSourceArray.count;
               }
            break;
        default:
            break;

    }
    return self.stargazersDataSourceOfPageListObject.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.currentIndex) {
        case contributorsCurrentIndex: {
            RankTableViewCell * cell;
            NSString *reuseableIdentifier=@"reuserCellIdentifierZero";
             cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
            if(cell==nil){
                cell=[[RankTableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            UserModel * userModel = [self.contributorsDataSourceOfPageListObject.dataSourceArray objectAtIndex:indexPath.row];

            cell.rankLabel.text =[NSString stringWithFormat:@"%ld",(long)(indexPath.row+1)];
            cell.mainLabel.text =[NSString stringWithFormat:@"%@",userModel.login];
            cell.detailLabel.text  = [NSString stringWithFormat:@"id:%ld",(long)userModel.userId];
            [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_url]];
            return cell;
            break;
        }
        case forksCurrentIndex: {

            RankTableViewCell *cell;
            NSString *reuseableIdentifier=@"reuseCellIdentifierOne";
              cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
            if(cell==nil){
                cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            RepositoryModel * repositoryModel = [self.forksDataSourceOfPageListObject.dataSourceArray objectAtIndex:indexPath.row];
            cell.rankLabel.text =[NSString stringWithFormat:@"%ld",(long)(indexPath.row+1)];
            cell.mainLabel.text =[NSString stringWithFormat:@"%@",repositoryModel.owner.login];
            cell.detailLabel.text  = [NSString stringWithFormat:@"id:%ld",(long)repositoryModel.UserId];
            NSLog(@"id:%ld",(long)repositoryModel.UserId);

            [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:repositoryModel.owner.avatar_url]];
            return cell;
            break;
        }
        case stargazersCurrentIndex: {

            RankTableViewCell *cell;
            NSString *reuseableIdentifier=@"reuseCellIdentifierTwo";
            cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
            if(cell==nil){
                cell=[[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            UserModel * userModel = [self.stargazersDataSourceOfPageListObject.dataSourceArray objectAtIndex:indexPath.row];
            cell.rankLabel.text =[NSString stringWithFormat:@"%ld",(long)(indexPath.row+1)];
            cell.mainLabel.text =[NSString stringWithFormat:@"%@",userModel.login];
            cell.detailLabel.text  = [NSString stringWithFormat:@"id:%ld",(long)userModel.userId];
            [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_url]];
            return cell;
            break;

        }
        default:
            break;
    }
    return nil;
}








@end
