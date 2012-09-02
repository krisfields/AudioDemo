//
//  AudioRecordAndPlayViewController.m
//  AudioDemo
//
//  Created by Edward Ruggeri on 9/2/12.
//  Copyright (c) 2012 Edward Ruggeri. All rights reserved.
//

#import "AudioRecordAndPlayViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface AudioRecordAndPlayViewController ()
@property (strong) AVAudioRecorder* recorder;
@property (strong) AVAudioPlayer* player;

- (IBAction)beginRecording;
- (IBAction)endRecording;

- (IBAction)playbackRecording;
@end

@implementation AudioRecordAndPlayViewController
- (IBAction)beginRecording {
  CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
  NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject);
  CFRelease(uuidObject);
  
  NSURL* documentDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  
  NSURL* audioURL = [documentDir URLByAppendingPathComponent:@"audio.wav"];
  
  NSDictionary* options = @{
    AVFormatIDKey : [NSNumber numberWithInt:kAudioFormatLinearPCM],
    AVSampleRateKey : [NSNumber numberWithDouble:48000],
    AVNumberOfChannelsKey : [NSNumber numberWithInt:2]
  };
  
  self.recorder = [[AVAudioRecorder alloc] initWithURL:audioURL settings:options error:nil];
  
  [self.recorder record];
}

- (IBAction)endRecording {
  [self.recorder stop];
  
  self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recorder.url error:nil];
  self.player.volume = 1.0;
  [self.player play];
}

- (IBAction)playbackRecording {
}
@end
