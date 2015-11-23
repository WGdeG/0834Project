//
//  PlayerManager.m
//  0834MusicPlayer
//
//  Created by 郑建文 on 15/11/5.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "PlayerManager.h"
#import <AVFoundation/AVFoundation.h>
@interface PlayerManager ()

//播放器 -> 全局唯一,因为如果有两个avplayer的话,就会同时播放两个音乐.
@property (nonatomic,strong) AVPlayer * player;
//计时器
@property(nonatomic,strong)NSTimer *timer;
@end


@implementation PlayerManager

static PlayerManager *manager = nil;
//单例方法
+ (instancetype)sharedManager{
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [PlayerManager new];
    });
    return manager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        //添加通知中心,当self发出AVPlayerItemDidPlayToEndTimeNotification时触发playerDidPlayEnd事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidOlayEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}
-(void)playerDidOlayEnd:(NSNotification *)not{
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerDidPlayerEnd)]) {
        //接收到item播放结束后,让代理区干一件事,代理会怎么干,播放器不需要知道
        [self.delegate playerDidPlayerEnd];
    }
}

#pragma mark -对外方法
- (void)playWithUrlString:(NSString *)urlStr{
    
    //如果是切换歌曲,要先把正在播放的观察者移除掉
    if (self.player.currentItem) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    
    //创建一个Item
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlStr]];
    
    // 对 item 添加观察者
    //观察item的状态
    [item addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil];
    
    //替换当前正在播放的音乐
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    //开始播放
    [self.player play];
}

-(void)play{
    //如果正在播放的话,就不播放了,直接返回就行了
//    if (_isPlaying) {
//        return;
//    }
    
    
    [self.player play];
    //开始播放标记一下
    _isPlaying = YES;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playingWithSeconds) userInfo:nil repeats:YES];
}

-(void)playingWithSeconds{
    NSLog(@"%lld",self.player.currentTime.value / self.player.currentTime.timescale);
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerPlayingWithTimer:)]) {
        
        NSTimeInterval time = self.player.currentTime.value / self.player.currentTime.timescale;
        [self.delegate playerPlayingWithTimer:time];
    }
}

-(void)paste{
    [self.player pause];
    //暂停播放后设为no
    _isPlaying = NO;
    
    [self.timer invalidate];
    self.timer = nil;
}

//改变进度
-(void)seekToTime:(NSTimeInterval)time{
    //先暂停
    [self paste];
    [self.player seekToTime:CMTimeMakeWithSeconds(time, self.player.currentTime.timescale) completionHandler:^(BOOL finished) {
        if (finished) {
            //拖拽成功后再播放
            [self play];
        }
    }];
}

#pragma mark - lazy load
- (AVPlayer *)player{
    if (!_player) {
        _player = [AVPlayer new];
    }
    return _player;
}

#pragma mark -- 观察响应
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%@",keyPath);
    NSLog(@"%@",change);
    AVPlayerItemStatus status = [change[@"new"] integerValue];
    switch (status) {
        case AVPlayerItemStatusFailed:
            NSLog(@"加载失败");
            break;
        case AVPlayerItemStatusUnknown:
            NSLog(@"资源不对");
            break;
        case AVPlayerItemStatusReadyToPlay:
            NSLog(@"准备好了,可以播放");
            //开始播放
            //先暂停,将nstimer销毁,然后在播放.创建nstimer
            [self paste];
            [self play];
            break;
        default:
            break;
    }
}

@end
