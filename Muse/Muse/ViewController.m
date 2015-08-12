//
//  ViewController.m
//  Muse
//
//  Created by Jieyi Hu on 6/28/15.
//  Copyright © 2015 SenseWatch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property WCSession *session;
@property MPMusicPlayerController* musicPlayerCtrl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self setUpNotifications];
    [self setUpWCSession];
    [self setUpMusicPlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lastSongButtonClick:(id)sender {
    NSLog(@"lastSongButton On iPhone is clicked.");
    [self lastSongButtonAction];
}

- (IBAction)playSongButtonClick:(id)sender {
    NSLog(@"playSongButton On iPhone is clicked.");
    [self playSongButtonAction];
}

- (IBAction)nextSongButtonClick:(id)sender {
    NSLog(@"nextSongButton On iPhone is clicked.");
    [self nextSongButtonAction];
}

- (void)playSong{
    [self.musicPlayerCtrl play];
    isPlaying = true;
    [self updateUI];
}

- (void)pauseSong{
    [self.musicPlayerCtrl pause];
    isPlaying = false;
    [self updateUI];
}

- (void)nextSong{
    [self.musicPlayerCtrl skipToNextItem];
    [self updateUI];
}

- (void)lastSong{
    [self.musicPlayerCtrl skipToPreviousItem];
    [self updateUI];
}

- (void)updateUI{
    //  get info
    //  get nowplaying song title
    NSString* nowPlayingSongTitle = [self.musicPlayerCtrl nowPlayingItem].title;
    
    if(nowPlayingSongTitle == nil){
        nowPlayingSongTitle = @"Not playing";
    } else{
        //  taken care by initializing
    }
    
    //  get playButton image name
    NSString* playButtonImageName;
    
    if(isPlaying){
        playButtonImageName = @"pause-icon";
    } else{
        playButtonImageName = @"continue-icon";
    }
    
    //  display info
    [self.songTitleLabel setText:nowPlayingSongTitle];
    [self.playSongButton setImage:[UIImage imageNamed:playButtonImageName] forState:0];
    
    //  send info to Watch
    [self sendUIUpdateInfoWithNowPlayingSongTitle:nowPlayingSongTitle withPlayButtonImageName:playButtonImageName];
}

- (void)setUpWCSession{
    _session = [WCSession defaultSession];
    _session.delegate = self;
    [_session activateSession];
    NSLog(@"WCSession On iPhone is activated.");
}

- (void)setUpMusicPlayer{
    _musicPlayerCtrl = [MPMusicPlayerController systemMusicPlayer];
    NSString* playlistName = @"TaylorSwift";
    MPMediaPropertyPredicate *playlistPredicate = [MPMediaPropertyPredicate predicateWithValue:playlistName
                                                                                   forProperty:MPMediaPlaylistPropertyName];
    
    NSNumber *mediaTypeNumber = [NSNumber numberWithInteger:MPMediaTypeMusic]; // == 1
    MPMediaPropertyPredicate *mediaTypePredicate = [MPMediaPropertyPredicate predicateWithValue:mediaTypeNumber
                                                                                    forProperty:MPMediaItemPropertyMediaType];
    
    NSSet *predicateSet = [NSSet setWithObjects:playlistPredicate, mediaTypePredicate, nil];
    MPMediaQuery *query = [[MPMediaQuery alloc] initWithFilterPredicates:predicateSet];
    [query setGroupingType:MPMediaGroupingPlaylist];
    
    [self.musicPlayerCtrl setQueueWithQuery:query];
    switch ([self.musicPlayerCtrl playbackState]) {
        case MPMusicPlaybackStatePaused:
        case MPMusicPlaybackStateStopped:
            isPlaying = false;
            break;
        case MPMusicPlaybackStatePlaying:
            isPlaying = true;
        default:
            break;
    }
//    [self.musicPlayerCtrl setShuffleMode:MPMusicShuffleModeDefault];
    [self updateUI];
}

- (void)setUpNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lastSongButtonAction) name:@"getGestureLEFT" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playSongButtonAction) name:@"getGesturePUSH" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextSongButtonAction) name:@"getGestureRIGHT" object:nil];
}

- (void)playSongButtonAction{
    switch ([self.musicPlayerCtrl playbackState]) {
        case MPMusicPlaybackStateStopped:
        case MPMusicPlaybackStatePaused:
            [self playSong];
            break;
        case MPMusicPlaybackStatePlaying:
            [self pauseSong];
            break;
        default:
            break;
    }
}

- (void)lastSongButtonAction{
    switch ([self.musicPlayerCtrl playbackState]) {
        case MPMusicPlaybackStatePlaying:
        case MPMusicPlaybackStatePaused:
            [self lastSong];
            break;
        default:
            NSLog(@"MusicPlayerCtrl cannot skip to previous item");
            break;
    }
}

- (void)nextSongButtonAction{
    switch ([self.musicPlayerCtrl playbackState]) {
        case MPMusicPlaybackStatePlaying:
        case MPMusicPlaybackStatePaused:
            [self nextSong];
            break;
        default:
            NSLog(@"MusicPlayerCtrl cannot skip to previous item");
            break;
    }
}

- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message{
    NSString* type = [message objectForKey:@"type"];
    if([type isEqualToString:@"Gesture"]){
        NSLog(@"iPhone receives gesture");
        [self handleGesture:[message objectForKey:@"content"]];
    }
}

- (void)handleGesture:(NSString*)gesture{
    if([gesture isEqualToString:@"UP"]){
        NSLog(@"Receive gesture UP");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self lastSongButtonAction];
        });
    } else if([gesture isEqualToString:@"PUSH"]){
        NSLog(@"Receive gesture PUSH");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self playSongButtonAction];
        });
    } else if([gesture isEqualToString:@"RIGHT"]){
        NSLog(@"Receive gesture RIGHT");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self nextSongButtonAction];
        });
    } else {
        [NSException raise:@"Receive undefined gesture" format:@"Gesture %@ is undefined",gesture];
    }

}

- (void)sendUIUpdateInfoWithNowPlayingSongTitle:(NSString*)songTitle withPlayButtonImageName:(NSString*)imageName{
    if([_session isReachable]){
        [_session sendMessage:@{@"type":@"UIUpdateInfo",
                                @"content":@{
                                            @"nowPlayingSongTitle":songTitle,
                                            @"playButtonImageName":imageName,
                                            },
                                } replyHandler:nil errorHandler:nil];
        NSLog(@"UIUpdateInfo on iPhone is sent");
    } else{
        NSLog(@"WCSession on iPhone is not reachable");
    }

}
@end
