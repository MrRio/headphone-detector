//
//  main.m
//  headphone-detector
//
//  Created by James Hall on 10/06/2011.
//  Copyright 2011 Snapshot Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudio.h>

int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    AudioDeviceID deviceID;
    UInt32 size = sizeof(deviceID);
    OSStatus err = AudioHardwareGetProperty(kAudioHardwarePropertyDefaultSystemOutputDevice, &size, &deviceID);
    NSCAssert((err == noErr), @"AudioHardwareGetProperty failed to get the kAudioHardwarePropertyDefaultSystemOutputDevice property");
    //To be notified when something is plugged/unplugged into the headphones jack
    //listen for a kAudioDevicePropertyDataSource or kAudioDevicePropertyDataSources notification on deviceID
    
    //Check if headphones are plugged in right now:
    UInt32 dataSource;
    size = sizeof(dataSource);
    err = AudioDeviceGetProperty(deviceID, 0, 0, kAudioDevicePropertyDataSource, &size, &dataSource);
    NSCAssert((err == noErr), @"AudioDeviceGetProperty failed to get the kAudioDevicePropertyDataSource property");
    
    //'ispk' => internal speakers
    //'hdpn' => headphones
    if(dataSource == 'ispk') {
        printf("Internal Speakers");
    } else {
        printf("Headphones");
    }
    
    [pool drain];
    return 0;
}

