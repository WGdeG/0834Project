//
//  LyricManager.m
//  0834MusicPlayer
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "LyricManager.h"
#import "LyricModel.h"

@interface LyricManager()
//用来存放歌词
@property(nonatomic,strong)NSMutableArray *lyrics;

@end

static LyricManager *manager = nil;
@implementation LyricManager

+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [LyricManager new];
    });
    return manager;
}

-(void)loadLyricWith:(NSString *)lyricStr{
    
    //要先讲之前歌曲的歌词移除
    [self.lyrics removeAllObjects];
    
    //1.分行
    NSArray *lyricStringArray = [lyricStr componentsSeparatedByString:@"\n"];
    for (NSString *str in lyricStringArray) {
        if ([str isEqualToString:@""]) {
            continue;
        }
   // [lyricStringArray removeLastObject];
    
        //分开时间和歌词
        NSArray *timeAndLyric = [str componentsSeparatedByString:@"]"];
        //3.去掉时间左边的"["
        NSString *time = [timeAndLyric[0] substringFromIndex:1];
        //time = 02:32.080
        //4.截取时间获取分和秒
        NSArray *minuteAndSecond = [time componentsSeparatedByString:@":"];
        //分
        NSInteger minute = [minuteAndSecond[0] integerValue];
        //秒
        double second = [minuteAndSecond[1] doubleValue];
        //5.装成一个model
        LyricModel *model = [[LyricModel alloc] initWithTime:(minute * 60 +second) lyric:timeAndLyric[1]];
        //6.添加到数组
        [self.lyrics addObject:model];
    }
}
-(NSInteger)indexWith:(NSTimeInterval)time{
    NSInteger index = 0;
    //遍历数组,找到还没有播放的歌词
    for (int i=0; i<self.lyrics.count; i++) {
        LyricModel *model = self.lyrics[i];
        if (model.time >time) {
            //注意如果是第0个元素,而且元素时间要比播放的时间大,i-1 就会小于0,这样tableview就会crash
            index = (i - 1 >0)? i - 1 : 0;
            break;
        }
    }
    return index;
}

-(NSMutableArray *)lyrics{
    if (!_lyrics) {
        _lyrics = [NSMutableArray new];
    }
    return _lyrics;
}

-(NSArray *)allLyric{
    return self.lyrics;
}

@end
