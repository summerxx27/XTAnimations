//
//  PlayerView.m
//  XTAnimations
//
//  Created by summerxx on 2023/3/31.
//  Copyright © 2023 夏天然后. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

- (AVPlayer *)player {
    return self.playerLayer.player;
}

- (void)setPlayer:(AVPlayer *)player {
    self.playerLayer.player = player;
}

//Override UIView method
+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}

@end
