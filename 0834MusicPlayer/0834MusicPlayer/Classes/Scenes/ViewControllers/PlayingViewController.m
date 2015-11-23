//
//  PlayingViewController.m
//  0834MusicPlayer
//
//  Created by 郑建文 on 15/11/5.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "PlayingViewController.h"
#import "PlayerManager.h"
#import "DataManager.h"
#import "LyricManager.h"
#import "LyricModel.h"
@interface PlayingViewController ()<PlayerManagerDelegate,UITableViewDataSource,UITableViewDelegate>
//记录一下当前播放的音乐的索引
@property (nonatomic,assign) NSInteger currentIndex;
//记录当前正在播放的音乐
@property(nonatomic,strong)MusicModel *currentModel;
//控件
@property (strong, nonatomic) IBOutlet UILabel *lab4SongName;
@property (strong, nonatomic) IBOutlet UILabel *lab4SingerName;
@property (strong, nonatomic) IBOutlet UIImageView *img4Pic;
@property (strong, nonatomic) IBOutlet UILabel *lab4PlayedTime;
@property (strong, nonatomic) IBOutlet UILabel *lab4LastTime;
@property (strong, nonatomic) IBOutlet UISlider *slider4Timer;
@property (strong, nonatomic) IBOutlet UISlider *slider4Volume;
@property (strong, nonatomic) IBOutlet UIButton *btn4PlayOrP;
@property (weak, nonatomic) IBOutlet UITableView *tableView4Lyric;

//控件事件
- (IBAction)action4Prev:(id)sender;

- (IBAction)action4PlayOrPause:(UIButton *)sender;
- (IBAction)action4Next:(UIButton *)sender;
- (IBAction)action4ChangeTime:(UISlider *)sender;


@end

static NSString *cellIdentifier = @"cell";
static PlayingViewController *playingVC = nil;
@implementation PlayingViewController

+ (instancetype)sharedPlayingPVC{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //拿到main sb
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //在main sb 拿到我们要用的视图控制器
        playingVC = [sb instantiateViewControllerWithIdentifier:@"playingVC"];
        
    });
    return playingVC;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //如果要播放的音乐和当前播放的音乐一样,就什么都不干了.
    if (_index == _currentIndex) {
        return;
    }
    //如果不等于
    _currentIndex = _index;
    
    [self startPlay];
}

- (void)startPlay{
    
    
    [[PlayerManager sharedManager] playWithUrlString:self.currentModel.mp3Url];
    [self buildUI];
}

-(void)buildUI{
    self.lab4SingerName.text = self.currentModel.singer;
    self.lab4SongName.text = self.currentModel.name;
    [self.img4Pic sd_setImageWithURL:[NSURL URLWithString:self.currentModel.picUrl]];
    //更改btn
    [self.btn4PlayOrP setTitle:@"暂停" forState:UIControlStateNormal];
    //改变进度条的最大值
    self.slider4Timer.maximumValue = [self.currentModel.duration integerValue] /1000;
    self.slider4Timer.value = 0;
    //更改旋转角度,图片归位
    self.img4Pic.transform = CGAffineTransformMakeRotation(0);
    //
    [[LyricManager sharedManager] loadLyricWith:self.currentModel.lyric];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentIndex = -1;
    //设置自己为播放器的代理,帮播放器干一些事情
    [PlayerManager sharedManager].delegate = self;
    //加圆角
    self.img4Pic.layer.masksToBounds = YES;
    self.img4Pic.layer.cornerRadius = 120;
    
    //注册
    [self.tableView4Lyric registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
}

#pragma mark --PlayerManagerDelegate
//播放器播放结束了,开始播放下一首
-(void)playerDidPlayerEnd{
    [self action4Next:nil];
}
//播放器每0.1秒会让代理(也就是这个页面)执行一下这个事件
-(void)playerPlayingWithTimer:(NSTimeInterval)time{
    self.slider4Timer.value = time;
    
    self.lab4PlayedTime.text = [self stringWithTime:time];
    //剩余时间
    NSTimeInterval time2 = [self.currentModel.duration integerValue] /1000 - time;
    self.lab4LastTime.text = [self stringWithTime:time2];
    //每0.1秒旋转1度
    self.img4Pic.transform = CGAffineTransformRotate(self.img4Pic.transform, M_PI / 180);
    
    //根据当前播放时间获取到相应的那句歌词
    NSInteger index = [[LyricManager sharedManager] indexWith:time];
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    //让tableview选中我们的歌词
    [self.tableView4Lyric selectRowAtIndexPath:path animated:YES scrollPosition:(UITableViewScrollPositionMiddle)];
}
//根据时间获取到字符串
-(NSString *)stringWithTime:(NSTimeInterval)time{
    
    NSInteger minutes= time / 60;
    NSInteger seconde = (int)time %60;
    return [NSString stringWithFormat:@"%ld:%ld",(long)minutes,(long)seconde];
}

#pragma mark --UITableViewDataSourse

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [LyricManager sharedManager].allLyric.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    LyricModel *lyric = [LyricManager sharedManager].allLyric[indexPath.row];
    cell.textLabel.text = lyric.lyricContext;
    
    //设置居中
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

#pragma mark--getter
//确保当前播放的音乐是最新的
-(MusicModel *)currentModel{
    //取到要播放的model
    MusicModel *model = [[DataManager sharedManager] musicModelWithIndex:self.currentIndex];
    return model;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)action4Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)action4Prev:(id)sender {
    _currentIndex--;
    //判断是否第一手
    if (_currentIndex == -1) {
        _currentIndex = [DataManager sharedManager].allMusic.count - 1;
    }
    [self startPlay];
}
//暂停或播放事件
- (IBAction)action4PlayOrPause:(UIButton *)sender {

    //判断是否在播放
    if ([PlayerManager sharedManager].isPlaying) {
        //如果正在播放,就让播放器暂停
        [[PlayerManager sharedManager] paste];
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    }else{
        [[PlayerManager sharedManager] play];
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }
}

- (IBAction)action4Next:(UIButton *)sender {
    
//    //在播放下一首时先暂停,销毁timer
//    [PlayerManager
    
    _currentIndex++;
    if (_currentIndex == [DataManager sharedManager].allMusic.count) {
        // 如果是最后一首就播放一首
        _currentIndex = 0;
    }
    [self startPlay];
}
//改变播放的进度
- (IBAction)action4ChangeTime:(UISlider *)sender {
    [[PlayerManager sharedManager] seekToTime:sender.value];
}
@end
