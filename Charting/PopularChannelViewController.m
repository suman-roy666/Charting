//
//  PopularChannelViewController.m
//  Charting
//
//  Created by Suman Roy on 01/12/15.
//  Copyright (c) 2015 sourcebits. All rights reserved.
//

#import "PopularChannelViewController.h"
#import "ChannelDataController.h"
#import "Video.h"
#import "VideoInfoViewCell.h"
#import "WebImage.h"

@interface PopularChannelViewController()

-(NSString*)durationAsString: (NSNumber*)duration;

@end


@implementation PopularChannelViewController{
    
    NSMutableArray *channelVideoList;
    ChannelDataController *popularChannelDataController;
}


static NSString *videoInfoViewCellIdentifier = @"VideoInfoViewCell";
static bool moreDataAvailable = true;

-(void)viewDidLoad{
    
    
    [ self.tableView registerNib:[ UINib nibWithNibName:videoInfoViewCellIdentifier
                                                 bundle:nil]
          forCellReuseIdentifier:videoInfoViewCellIdentifier ];
    
    popularChannelDataController = [[ ChannelDataController alloc] initWithChannel:@"popular" ];
    
    channelVideoList = [[ NSMutableArray alloc ] initWithArray:[ popularChannelDataController retrieveChannelDataFromRoot:YES ] ];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [ channelVideoList count ];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoInfoViewCell *cell = [ self.tableView dequeueReusableCellWithIdentifier:videoInfoViewCellIdentifier ];
    
    Video *cellVideo = channelVideoList[ indexPath.row ];

    
    cell.videoNameLabel.text = cellVideo.videoName;
    cell.videoUserNameLabel.text = cellVideo.userName;
    cell.videoLikeCountLabel.text = [ NSString stringWithFormat:@"%@", cellVideo.likeCount ];
    cell.videoCommentCountLabel.text = [ NSString stringWithFormat:@"%@", cellVideo.commentCount ];
    cell.videoViewCountLabel.text = [ NSString stringWithFormat:@"%@", cellVideo.viewCount ];
    
    cell.videoDurationLabel.text = [ self durationAsString: cellVideo.duration ];
    
    [ cell.videoThumbnail sd_setImageWithURL:[ NSURL URLWithString: cellVideo.videoImageURL ]
                            placeholderImage:[ UIImage imageNamed: @"bg.png" ]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     return 375;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if ( moreDataAvailable ){
        
        NSInteger currentOffset = scrollView.contentOffset.y;
        NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if ((maximumOffset - currentOffset <= - 80)  ) {
            
            NSArray *tempArray = [ popularChannelDataController retrieveChannelDataFromRoot:NO ];
            
            if ( [ tempArray count ] != 0 ){
                
                [ channelVideoList addObjectsFromArray:tempArray ];
                [ self.tableView reloadData ];
                
            } else {
                
                moreDataAvailable = false;
                
            }
            
        }
    }
}

-(NSString*)durationAsString: (NSNumber*)duration{
    
    long durationInSeconds = [ duration integerValue ]/1000;
    
    long durationMinutes = durationInSeconds/60;
    long durationSeconds = durationInSeconds%60;
    
    NSString *durationString = [ NSString stringWithFormat:@"%ld:%02ld",durationMinutes,durationSeconds ];
    
    return durationString;
    
}

@end
