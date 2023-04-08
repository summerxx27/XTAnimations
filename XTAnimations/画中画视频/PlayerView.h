//
//  PlayerView.h
//  XTAnimations
//
//  Created by summerxx on 2023/3/31.
//  Copyright © 2023 夏天然后. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerView : UIView
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong, readonly) AVPlayerLayer *playerLayer;
@end

NS_ASSUME_NONNULL_END
