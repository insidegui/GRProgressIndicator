//
//  AppDelegate.m
//  Progressbar Fun
//
//  Created by Guilherme Rambo on 13/12/13.
//  Copyright (c) 2013 Guilherme Rambo. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
{
    NSTimer *_appleTimer;
    double _appleDoubleValue;
    
    NSTimer *_grTimer;
    double _grDoubleValue;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.appleProgress setUsesThreadedAnimation:YES];
}

- (IBAction)startApple:(id)sender {
    if(_appleTimer) return;
    
    [self.appleProgress startAnimation:nil];
    _appleDoubleValue = 0;
    _appleTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateAppleProgress:) userInfo:nil repeats:YES];
}

- (void)updateAppleProgress:(NSTimer *)timer
{
    _appleDoubleValue++;
    self.appleProgress.doubleValue = _appleDoubleValue;
    
    if(_appleDoubleValue >= 100) {
        [_appleTimer invalidate];
        _appleTimer = nil;
        [self.appleProgress stopAnimation:nil];
    }
}

- (IBAction)startGR:(id)sender {
    if(_grTimer) return;
    
    [self.grProgress startAnimation:nil];
    _grDoubleValue = 0;
    _grTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateGRProgress:) userInfo:nil repeats:YES];
}

- (void)updateGRProgress:(NSTimer *)timer
{
    _grDoubleValue++;
    self.grProgress.doubleValue = _grDoubleValue;
    
    if(_grDoubleValue >= 100) {
        [_grTimer invalidate];
        _grTimer = nil;
        [self.grProgress stopAnimation:nil];
    }
}

- (IBAction)changeTheme:(id)sender {
    if([self.themeSelect.selectedItem.title isEqualToString:@"Force Graphite"]) {
        self.grProgress.theme = GRProgressIndicatorThemeForceGraphite;
    } else if([self.themeSelect.selectedItem.title isEqualToString:@"Red"]) {
        self.grProgress.theme = GRProgressIndicatorThemeRed;
    } else if([self.themeSelect.selectedItem.title isEqualToString:@"Green"]) {
        self.grProgress.theme = GRProgressIndicatorThemeGreen;
    } else if([self.themeSelect.selectedItem.title isEqualToString:@"Orange"]) {
        self.grProgress.theme = GRProgressIndicatorThemeOrange;
    } else if([self.themeSelect.selectedItem.title isEqualToString:@"Pink"]) {
        self.grProgress.theme = GRProgressIndicatorThemePink;
    } else {
        self.grProgress.theme = GRProgressIndicatorThemeDefault;
    }
}

@end
