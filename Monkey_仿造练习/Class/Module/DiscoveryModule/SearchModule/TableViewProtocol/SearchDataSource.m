//
//  SearchDataSource.m
//  Monkey_仿造练习
//
//  Created by 康帅 金 on 2016/9/7.
//  Copyright © 2016年 康帅 金. All rights reserved.
//

#import "SearchDataSource.h"
#import "UIImageView+WebCache.h"

@implementation SearchDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag ==11) {
        NSLog(@"%lu",self.userDataSourceModel.dataSourceArray.count);
        return self.userDataSourceModel.dataSourceArray.count;
    }else if (tableView.tag ==12    ){
        return self.repositoryDataSourceModel.dataSourceArray.count;
    }
    return  self.userDataSourceModel.dataSourceArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell;
    switch (tableView.tag) {
        case 11:{
            NSString *reuseableIdentifier=@"reuseCellOne";
              cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
            if(cell==nil){
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            UserModel * userModel = [self.userDataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
            cell.textLabel.text =userModel.login;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar_url] ];
            cell.imageView.layer.masksToBounds =YES;
            cell.imageView.layer.cornerRadius =8;
            return cell;
        }
            break;
        case 12:{
            NSString *reuseableIdentifier=@"reuseCellTwo";
             cell=[tableView dequeueReusableCellWithIdentifier:reuseableIdentifier];
            if(cell==nil){
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableIdentifier];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
            }
            RepositoryModel * repositoryModel =[self.repositoryDataSourceModel.dataSourceArray objectAtIndex:indexPath.row];
            cell.textLabel.text =[NSString stringWithFormat:@"%@",repositoryModel.full_name];
            cell.detailTextLabel.text =[NSString stringWithFormat:@"%@ %@",repositoryModel.language,repositoryModel.Description];
            cell.detailTextLabel.textColor =YiTextGray;
            return cell;
        }

            break;
        default:
            break;
    }
    return cell;
}


@end
