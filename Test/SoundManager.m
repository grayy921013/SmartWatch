//
//  SoundManager.m
//  Test
//
//  Created by vincent on 4/5/16.
//  Copyright © 2016 vincent. All rights reserved.
//

#import "SoundManager.h"
#import "Constants.h"
#import <AudioToolbox/AudioToolbox.h>
@interface SoundManager ()

@property (nonatomic, strong) NSMutableArray* audioFileList;
@property (nonatomic, strong) NSURL* reachZoneSound;
@property (nonatomic, strong) NSURL* dropOutSound;

@end
@implementation SoundManager
static SoundManager *sharedInstance;
-(instancetype)init {
    if (self) {
        self.audioFileList = [[NSMutableArray alloc] init];
        
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSURL *directoryURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds"];
        NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
        
        NSDirectoryEnumerator *enumerator = [fileManager
                                             enumeratorAtURL:directoryURL
                                             includingPropertiesForKeys:keys
                                             options:0
                                             errorHandler:^(NSURL *url, NSError *error) {
                                                 // Handle the error.
                                                 // Return YES if the enumeration should continue after the error.
                                                 return YES;
                                             }];
        
        for (NSURL *url in enumerator) {
            NSError *error;
            NSNumber *isDirectory = nil;
            if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
                // handle error
            }
            else if (! [isDirectory boolValue]) {
                [self.audioFileList addObject:url];
            }
        }
        self.reachZoneSound = [self.audioFileList objectAtIndex:[[NSUserDefaults standardUserDefaults] integerForKey:REACH_SOUND_KEY]];
        self.dropOutSound = [self.audioFileList objectAtIndex:[[NSUserDefaults standardUserDefaults] integerForKey:DROP_SOUND_KEY]];
    }
    return self;
}
-(void)playSound:(NSURL*)fileName {
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)fileName,&soundID);
    AudioServicesPlaySystemSound(soundID);
}

-(void)playReachSound {
    [self playSound:self.reachZoneSound];
}
-(void)playDropSound {
    [self playSound:self.dropOutSound];
}
-(NSInteger)getReachSound{
    return [[NSUserDefaults standardUserDefaults] integerForKey:REACH_SOUND_KEY];
}
-(NSInteger)getDropSound{
    return [[NSUserDefaults standardUserDefaults] integerForKey:DROP_SOUND_KEY];
}
-(void)setReachSound:(NSInteger)index {
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:REACH_SOUND_KEY];
    self.reachZoneSound = [self.audioFileList objectAtIndex:index];
}
-(void)setDropSound:(NSInteger)index {
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:DROP_SOUND_KEY];
    self.dropOutSound = [self.audioFileList objectAtIndex:index];
}
-(NSArray*)getSoundArray {
    return self.audioFileList;
}
+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    return sharedInstance;
}
-(id)copyWithZone:(NSZone *)zone
{
    return [[self class] sharedInstance];
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}
@end
