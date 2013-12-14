//
//  GRProgressIndicator.h
//  GRProgressIndicator
//
//  Created by Guilherme Rambo on 13/12/13.
//  Copyright (c) 2013 Guilherme Rambo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GRProgressIndicatorThemes.h"

@interface GRProgressIndicator : NSView

@property (nonatomic, assign) double doubleValue;
@property (nonatomic, assign) GRProgressIndicatorTheme_t theme;

- (void)startAnimation:(id)sender;
- (void)stopAnimation:(id)sender;

@end
