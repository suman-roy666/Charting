//
//  PopularChannelViewController.m
//  Charting
//
//  Created by Suman Roy on 01/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "PopularChannelViewController.h"
#import "VideoDataController.h"
#import "Video.h"
#import "VideoInfoViewCell.h"

@implementation PopularChannelViewController

static NSString *videoInfoViewCellIdentifier = @"VideoInfoViewCell";
static int pageNo = 1;

-(void)viewDidLoad{
    
    
    [ self.tableView registerNib:[ UINib nibWithNibName:videoInfoViewCellIdentifier
                                                      bundle:nil]
               forCellReuseIdentifier:videoInfoViewCellIdentifier ];
    
    

}

- (void)viewDidAppear:(BOOL)animated{
    
    
    [ self.tableView setFrame: CGRectMake(self.tableView.frame.origin.x,
                                          self.tableView.frame.origin.y,
                                          self.tableView.frame.size.width,
                                          (self.tableView.frame.size.height - self.bottomMargin*2))];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [ self.videoList count ];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoInfoViewCell *cell = [ self.tableView dequeueReusableCellWithIdentifier:videoInfoViewCellIdentifier ];
    
    Video *cellVideo = self.videoList[ indexPath.row ];
    
    cell.videoNameLabel.text = cellVideo.videoName;
    cell.videoUserNameLabel.text = cellVideo.userName;
    cell.videoLikeCountLabel.text = [ NSString stringWithFormat:@"%@", cellVideo.likeCount ];
    cell.videoCommentCountLabel.text = [ NSString stringWithFormat:@"%@", cellVideo.commentCount ];
    cell.videoViewCountLabel.text = [ NSString stringWithFormat:@"%@", cellVideo.viewCount ];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoInfoViewCell *cell = [ self.tableView dequeueReusableCellWithIdentifier:videoInfoViewCellIdentifier ];
    
    return cell.frame.size.height;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    if ((maximumOffset - currentOffset <= -40) &&( pageNo <=5 ) ) {
        [ self.videoList addObjectsFromArray: [ VideoDataController getChannelDetailsFor:@"popular" page:pageNo] ];
        pageNo++;
        [ self.tableView reloadData ];
        
    }
}

@end
