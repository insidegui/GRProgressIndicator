//
//  AppDelegate.h
//  Progressbar Fun
//
//  Created by Guilherme Rambo on 13/12/13.
//  Copyright (c) 2013 Guilherme Rambo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GRProgressIndicator.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSProgressIndicator *appleProgress;
@property (weak) IBOutlet GRProgressIndicator *grProgress;
@property (weak) IBOutlet NSPopUpButton *themeSelect;

@end
