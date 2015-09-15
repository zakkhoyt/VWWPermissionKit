//
//  VWWMicrophonePermission.m
//  VWWPermissionsManager
//
//  Created by Zakk Hoyt on 6/12/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWMicrophonePermission.h"
@import AVFoundation;

@interface VWWMicrophonePermission ()
@property (nonatomic, strong) AVAudioSession *audioSession;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@end
@implementation VWWMicrophonePermission

+(instancetype)permissionWithLabelText:(NSString*)labelText{
    return [[super alloc] initWithType:VWWMicrophonePermissionType labelText:labelText];
}

-(void)updatePermissionStatus{
    // Check for availablity
    NSArray *audioDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    if(audioDevices.count == 0){
        self.status = VWWPermissionStatusServiceNotAvailable;
    } else {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        if(status == AVAuthorizationStatusNotDetermined){
            self.status = VWWPermissionStatusNotDetermined;
        } else if(status == AVAuthorizationStatusAuthorized){
            self.status = VWWPermissionStatusAuthorized;
        } else if(status == AVAuthorizationStatusDenied) {
            self.status = VWWPermissionStatusDenied;
        } else if(status == AVAuthorizationStatusRestricted) {
            self.status = VWWPermissionStatusRestricted;
        }
    }
}

-(void)presentSystemPromtWithCompletionBlock:(VWWPermissionEmptyBlock)completionBlock{
    if(self.audioSession == nil){
        self.audioSession = [[AVAudioSession alloc]init];
    }
    [self.audioSession requestRecordPermission:^(BOOL granted) {
        completionBlock();
    }];
}

@end
