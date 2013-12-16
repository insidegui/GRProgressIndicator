//
//  GRProgressIndicator.m
//  GRProgressIndicator
//
//  Created by Guilherme Rambo on 13/12/13.
//  Copyright (c) 2013 Guilherme Rambo. All rights reserved.
//

#import "GRProgressIndicator.h"

#import <QuartzCore/QuartzCore.h>

// progress bar corner radius
#define kProgressBarCornerRadius 3.0

// defines the width and spacing of the "water" particles
#define kParticleWidth 34.0
#define kParticleSpacing 15.0

// defines the duration of each animation step,
// tweak this to change animation behavior
#define kProgressIndicatorAnimationSleepInterval 0.02

// defines the duration of the animation used
// when doubleValue is changed
#define kDoubleValueAnimationDuration 0.3

@interface GRProgressIndicator ()

@property (nonatomic, assign) double internalDoubleValue;

@end

@implementation GRProgressIndicator
{
    // cached data
    NSColor *_particleGrad1;
    NSColor *_particleGrad2;
    NSGradient *_particleGradient;
    NSImage *_bezelTopLeftCorner;
    NSImage *_bezelTopEdgeFill;
    NSImage *_bezelTopRightCorner;
    NSImage *_bezelLeftEdgeFill;
    NSImage *_bezelCenterFill;
    NSImage *_bezelRightEdgeFill;
    NSImage *_bezelBottomLeftCorner;
    NSImage *_bezelBottomEdgeFill;
    NSImage *_bezelBottomRightCorner;
    NSShadow *_progressBarInnerShadow;
    NSGradient *_progressBarGradient;
    NSGradient *_progressBarLineGradient;
    NSColor *_indeterminateGradientColor0;
    NSColor *_indeterminateGradientColor1;
    NSColor *_indeterminateGradientColor2;
    NSColor *_indeterminateGradientColor3;
    NSGradient *_indeterminateGradient;
    
    // theme colors
    NSColor *_gradientColor0;
    NSColor *_gradientColor1;
    NSColor *_gradientColor2;
    NSColor *_gradientColor3;
    NSColor *_gradientColor4;
    NSColor *_graphiteGradientColor0;
    NSColor *_graphiteGradientColor1;
    NSColor *_graphiteGradientColor2;
    NSColor *_graphiteGradientColor3;
    NSColor *_graphiteGradientColor4;
    NSColor *_inactiveGradientColor0;
    NSColor *_inactiveGradientColor1;
    NSColor *_inactiveGradientColor2;
    NSColor *_inactiveGradientColor3;
    NSColor *_inactiveGradientColor4;
    
    // defines if we are currently animating or not
    BOOL _animating;
    
    // animation counter
    int _currentAnimationStep;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // initialize images used to draw our bezel
        _bezelTopLeftCorner = [NSImage imageNamed:@"pi_topLeft"];
        _bezelTopEdgeFill = [NSImage imageNamed:@"pi_topFill"];
        _bezelTopRightCorner = [NSImage imageNamed:@"pi_topRight"];
        _bezelLeftEdgeFill = [NSImage imageNamed:@"pi_leftFill"];
        _bezelCenterFill = [NSImage imageNamed:@"pi_centerFill"];
        _bezelRightEdgeFill = [NSImage imageNamed:@"pi_rightFill"];
        _bezelBottomLeftCorner = [NSImage imageNamed:@"pi_bottomLeft"];
        _bezelBottomEdgeFill = [NSImage imageNamed:@"pi_bottomFill"];
        _bezelBottomRightCorner = [NSImage imageNamed:@"pi_bottomRight"];
        
        // setup defaults
        self.theme = GRProgressIndicatorThemeDefault;
        self.minValue = 0;
        self.maxValue = 100;
        self.doubleValue = 0;
    }
    return self;
}

- (void)setTheme:(GRProgressIndicatorTheme_t)theme
{
    _theme = theme;
    [self setupTheme];
    _progressBarGradient = nil;
}

// set up instance variables according to the current theme
- (void)setupTheme
{
    // by default the inactive state and graphite look don't change
    // for each theme, but this can be changed by creating new constants and
    // using them here, that's why I've decided to keep setting "_graphiteGradientColor..."
    // and "_inactiveGradientColor..." in all cases
    switch (self.theme) {
        case GRProgressIndicatorThemeForceGraphite:
            _gradientColor0 = kProgressBarGraphiteGradientColor0;
            _gradientColor1 = kProgressBarGraphiteGradientColor1;
            _gradientColor2 = kProgressBarGraphiteGradientColor2;
            _gradientColor3 = kProgressBarGraphiteGradientColor3;
            _gradientColor4 = kProgressBarGraphiteGradientColor4;
            _graphiteGradientColor0 = kProgressBarGraphiteGradientColor0;
            _graphiteGradientColor1 = kProgressBarGraphiteGradientColor1;
            _graphiteGradientColor2 = kProgressBarGraphiteGradientColor2;
            _graphiteGradientColor3 = kProgressBarGraphiteGradientColor3;
            _graphiteGradientColor4 = kProgressBarGraphiteGradientColor4;
            _inactiveGradientColor0 = kProgressBarInactiveGradientColor0;
            _inactiveGradientColor1 = kProgressBarInactiveGradientColor1;
            _inactiveGradientColor2 = kProgressBarInactiveGradientColor2;
            _inactiveGradientColor3 = kProgressBarInactiveGradientColor3;
            _inactiveGradientColor4 = kProgressBarInactiveGradientColor4;
            break;
        case GRProgressIndicatorThemeGreen:
            _gradientColor0 = kProgressBarGreenGradientColor0;
            _gradientColor1 = kProgressBarGreenGradientColor1;
            _gradientColor2 = kProgressBarGreenGradientColor2;
            _gradientColor3 = kProgressBarGreenGradientColor3;
            _gradientColor4 = kProgressBarGreenGradientColor4;
            _graphiteGradientColor0 = kProgressBarGraphiteGradientColor0;
            _graphiteGradientColor1 = kProgressBarGraphiteGradientColor1;
            _graphiteGradientColor2 = kProgressBarGraphiteGradientColor2;
            _graphiteGradientColor3 = kProgressBarGraphiteGradientColor3;
            _graphiteGradientColor4 = kProgressBarGraphiteGradientColor4;
            _inactiveGradientColor0 = kProgressBarInactiveGradientColor0;
            _inactiveGradientColor1 = kProgressBarInactiveGradientColor1;
            _inactiveGradientColor2 = kProgressBarInactiveGradientColor2;
            _inactiveGradientColor3 = kProgressBarInactiveGradientColor3;
            _inactiveGradientColor4 = kProgressBarInactiveGradientColor4;
            break;
        case GRProgressIndicatorThemeRed:
            _gradientColor0 = kProgressBarRedGradientColor0;
            _gradientColor1 = kProgressBarRedGradientColor1;
            _gradientColor2 = kProgressBarRedGradientColor2;
            _gradientColor3 = kProgressBarRedGradientColor3;
            _gradientColor4 = kProgressBarRedGradientColor4;
            _graphiteGradientColor0 = kProgressBarGraphiteGradientColor0;
            _graphiteGradientColor1 = kProgressBarGraphiteGradientColor1;
            _graphiteGradientColor2 = kProgressBarGraphiteGradientColor2;
            _graphiteGradientColor3 = kProgressBarGraphiteGradientColor3;
            _graphiteGradientColor4 = kProgressBarGraphiteGradientColor4;
            _inactiveGradientColor0 = kProgressBarInactiveGradientColor0;
            _inactiveGradientColor1 = kProgressBarInactiveGradientColor1;
            _inactiveGradientColor2 = kProgressBarInactiveGradientColor2;
            _inactiveGradientColor3 = kProgressBarInactiveGradientColor3;
            _inactiveGradientColor4 = kProgressBarInactiveGradientColor4;
            break;
        case GRProgressIndicatorThemePink:
            _gradientColor0 = kProgressBarPinkGradientColor0;
            _gradientColor1 = kProgressBarPinkGradientColor1;
            _gradientColor2 = kProgressBarPinkGradientColor2;
            _gradientColor3 = kProgressBarPinkGradientColor3;
            _gradientColor4 = kProgressBarPinkGradientColor4;
            _graphiteGradientColor0 = kProgressBarGraphiteGradientColor0;
            _graphiteGradientColor1 = kProgressBarGraphiteGradientColor1;
            _graphiteGradientColor2 = kProgressBarGraphiteGradientColor2;
            _graphiteGradientColor3 = kProgressBarGraphiteGradientColor3;
            _graphiteGradientColor4 = kProgressBarGraphiteGradientColor4;
            _inactiveGradientColor0 = kProgressBarInactiveGradientColor0;
            _inactiveGradientColor1 = kProgressBarInactiveGradientColor1;
            _inactiveGradientColor2 = kProgressBarInactiveGradientColor2;
            _inactiveGradientColor3 = kProgressBarInactiveGradientColor3;
            _inactiveGradientColor4 = kProgressBarInactiveGradientColor4;
            break;
        case GRProgressIndicatorThemeOrange:
            _gradientColor0 = kProgressBarOrangeGradientColor0;
            _gradientColor1 = kProgressBarOrangeGradientColor1;
            _gradientColor2 = kProgressBarOrangeGradientColor2;
            _gradientColor3 = kProgressBarOrangeGradientColor3;
            _gradientColor4 = kProgressBarOrangeGradientColor4;
            _graphiteGradientColor0 = kProgressBarGraphiteGradientColor0;
            _graphiteGradientColor1 = kProgressBarGraphiteGradientColor1;
            _graphiteGradientColor2 = kProgressBarGraphiteGradientColor2;
            _graphiteGradientColor3 = kProgressBarGraphiteGradientColor3;
            _graphiteGradientColor4 = kProgressBarGraphiteGradientColor4;
            _inactiveGradientColor0 = kProgressBarInactiveGradientColor0;
            _inactiveGradientColor1 = kProgressBarInactiveGradientColor1;
            _inactiveGradientColor2 = kProgressBarInactiveGradientColor2;
            _inactiveGradientColor3 = kProgressBarInactiveGradientColor3;
            _inactiveGradientColor4 = kProgressBarInactiveGradientColor4;
            break;
        default:
            _gradientColor0 = kProgressBarGradientColor0;
            _gradientColor1 = kProgressBarGradientColor1;
            _gradientColor2 = kProgressBarGradientColor2;
            _gradientColor3 = kProgressBarGradientColor3;
            _gradientColor4 = kProgressBarGradientColor4;
            _graphiteGradientColor0 = kProgressBarGraphiteGradientColor0;
            _graphiteGradientColor1 = kProgressBarGraphiteGradientColor1;
            _graphiteGradientColor2 = kProgressBarGraphiteGradientColor2;
            _graphiteGradientColor3 = kProgressBarGraphiteGradientColor3;
            _graphiteGradientColor4 = kProgressBarGraphiteGradientColor4;
            _inactiveGradientColor0 = kProgressBarInactiveGradientColor0;
            _inactiveGradientColor1 = kProgressBarInactiveGradientColor1;
            _inactiveGradientColor2 = kProgressBarInactiveGradientColor2;
            _inactiveGradientColor3 = kProgressBarInactiveGradientColor3;
            _inactiveGradientColor4 = kProgressBarInactiveGradientColor4;
            break;
    }
    
    if(!_animating) [self setNeedsDisplay:YES];
}

// setup our observation of the window's properties
- (void)viewDidMoveToWindow
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowKeyChanged:) name:NSWindowDidBecomeKeyNotification object:self.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowKeyChanged:) name:NSWindowDidResignKeyNotification object:self.window];
}

- (void)windowKeyChanged:(NSNotification *)notification
{
    _progressBarGradient = nil;
    
    // we avoid calling setNeedsDisplay: while animation is on to prevent glitches
    if(!_animating) [self setNeedsDisplay:YES];
}

- (void)setDoubleValue:(double)doubleValue
{
    // the setting of the doubleValue is not animated if the new value is less than
    // the current value and if the PI is indeterminate
    if (doubleValue > _doubleValue && !self.isIndeterminate) {
        self.animator.internalDoubleValue = doubleValue;
    } else {
        self.internalDoubleValue = doubleValue;
    }
    
    _doubleValue = doubleValue;
}

- (void)setInternalDoubleValue:(double)internalDoubleValue
{
    _internalDoubleValue = internalDoubleValue;
    
    // we only call setNeedsDisplay: if the animation is not in progress,
    // if we where to call It during animation, this could cause glitches
    if(!_animating) [self setNeedsDisplay:YES];
}

- (void)setIndeterminate:(BOOL)indeterminate
{
    _indeterminate = indeterminate;
}

// calculate the rect of the progress bar inside based on the current doubleValue
- (NSRect)progressBarRect
{
    double scaledDoubleValue;
    
    if (_indeterminate) {
        scaledDoubleValue = _maxValue;
    } else {
        scaledDoubleValue = _internalDoubleValue*(_maxValue-_minValue)/_maxValue-_minValue;
    }
    
    return NSMakeRect(1, 2, round(scaledDoubleValue/_maxValue*NSWidth(self.frame)), NSHeight(self.frame)-3);
}

- (void)startAnimation:(id)sender
{
    if(_animating) return;
    
    // detach a new thread to handle animation updates
    [NSThread detachNewThreadSelector:@selector(render:) toTarget:self withObject:nil];
}

- (void)stopAnimation:(id)sender
{
    if(!_animating) return;
    
    _animating = NO;
    [self setNeedsDisplay:YES];
}

- (id)animationForKey:(NSString *)key
{
    // our internalDoubleValue is used to make the value increments smoother
    if ([key isEqualToString:@"internalDoubleValue"]) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.duration = kDoubleValueAnimationDuration;
        
        return animation;
    }
    
    return [super animationForKey:key];
}

// animation thread loop
- (void)render:(id)sender
{
    @autoreleasepool {
        
        // we are now animating
        _animating = YES;
        
        // animation loop
        while (_animating) {
            // the animation happens until it's walked back the width of a particle,
            // when this is the case, the frame will look the same as in the start, so we go back and loop
            if(_currentAnimationStep >= kParticleWidth) _currentAnimationStep = 0;

            _currentAnimationStep++;
            
            // render the view
            [self setNeedsDisplay:YES];
            
            // delay to control framerate
            [NSThread sleepForTimeInterval:kProgressIndicatorAnimationSleepInterval];
        }
        
    }
    
    [NSThread exit];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // draw bezel using nine images
    NSDrawNinePartImage(dirtyRect, _bezelTopLeftCorner, _bezelTopEdgeFill, _bezelTopRightCorner, _bezelLeftEdgeFill, _bezelCenterFill, _bezelRightEdgeFill, _bezelBottomLeftCorner, _bezelBottomEdgeFill, _bezelBottomRightCorner, NSCompositeSourceOver, 1.0, NO);
    
    // this will limit our drawing to the inside of the bezel
    NSRect clipRect = NSMakeRect(1, 2, NSWidth(self.frame)-2, NSHeight([self progressBarRect]));
    [[NSBezierPath bezierPathWithRoundedRect:clipRect xRadius:kProgressBarCornerRadius yRadius:kProgressBarCornerRadius] addClip];
    
    // draw progress bar
    [self drawProgressBar];
    
    // draw particle animation step if needed
    if(_animating) {
        if (!self.isIndeterminate) {
            [self drawAnimationStep];
        } else {
            [self drawIndeterminateAnimationStep];
        }
    }
}

// this method is responsible of drawing the progress bar itself
- (void)drawProgressBar
{
    if (self.doubleValue <= 0) return;
    
    NSRect progressBarRect = [self progressBarRect];
    
    // the progress bar innner shadow
    if (!_progressBarInnerShadow) {
        _progressBarInnerShadow = [[NSShadow alloc] init];
        
        [_progressBarInnerShadow setShadowOffset: NSMakeSize(0.1, -1.1)];
        [_progressBarInnerShadow setShadowBlurRadius: 1];
    }
    
    // determine the correct gradient and shadow colors based on
    // the window's key state, the system's appearance preferences and current theme
    if(!_progressBarGradient) {
        if ([self.window isKeyWindow]) {
            if ([NSColor currentControlTint] == NSGraphiteControlTint) {
                [_progressBarInnerShadow setShadowColor: kProgressBarGraphiteInnerShadowColor];
                
                _progressBarGradient = [[NSGradient alloc] initWithColorsAndLocations:
                            _graphiteGradientColor0, 0.0,
                            _graphiteGradientColor1, 0.48,
                            _graphiteGradientColor2, 0.49,
                            _graphiteGradientColor3, 0.82,
                            _graphiteGradientColor4, 1.0, nil];
            } else {
                [_progressBarInnerShadow setShadowColor: kProgressBarInnerShadowColor];
                
                _progressBarGradient = [[NSGradient alloc] initWithColorsAndLocations:
                            _gradientColor0, 0.0,
                            _gradientColor1, 0.48,
                            _gradientColor2, 0.49,
                            _gradientColor3, 0.82,
                            _gradientColor4, 1.0, nil];
            }
        } else {
            [_progressBarInnerShadow setShadowColor: kProgressBarInnerShadowColor];
            
            _progressBarGradient = [[NSGradient alloc] initWithColorsAndLocations:
                        _inactiveGradientColor0, 0.0,
                        _inactiveGradientColor1, 0.48,
                        _inactiveGradientColor2, 0.49,
                        _inactiveGradientColor3, 1.0, nil];
        }
    }
    
    // the progress bar rectangle
    NSBezierPath *rectanglePath = [NSBezierPath bezierPathWithRect:progressBarRect];
    [_progressBarGradient drawInBezierPath: rectanglePath angle: -90];
    
    // this huge code section is used to draw a tiny whiteish inner shadow
    NSRect roundedRectangleBorderRect = NSInsetRect([rectanglePath bounds], -_progressBarInnerShadow.shadowBlurRadius, -_progressBarInnerShadow.shadowBlurRadius);
    roundedRectangleBorderRect = NSOffsetRect(roundedRectangleBorderRect, -_progressBarInnerShadow.shadowOffset.width, -_progressBarInnerShadow.shadowOffset.height);
    roundedRectangleBorderRect = NSInsetRect(NSUnionRect(roundedRectangleBorderRect, [rectanglePath bounds]), -1, -1);
    
    NSBezierPath* roundedRectangleNegativePath = [NSBezierPath bezierPathWithRect: roundedRectangleBorderRect];
    [roundedRectangleNegativePath appendBezierPath: rectanglePath];
    [roundedRectangleNegativePath setWindingRule: NSEvenOddWindingRule];
    
    [NSGraphicsContext saveGraphicsState];
    {
        NSShadow* shadowWithOffset = [_progressBarInnerShadow copy];
        CGFloat xOffset = shadowWithOffset.shadowOffset.width + round(roundedRectangleBorderRect.size.width);
        CGFloat yOffset = shadowWithOffset.shadowOffset.height;
        shadowWithOffset.shadowOffset = NSMakeSize(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset));
        [shadowWithOffset set];
        [[NSColor grayColor] setFill];
        [rectanglePath addClip];
        NSAffineTransform* transform = [NSAffineTransform transform];
        [transform translateXBy: -round(roundedRectangleBorderRect.size.width) yBy: 0];
        [[transform transformBezierPath: roundedRectangleNegativePath] fill];
    }
    [NSGraphicsContext restoreGraphicsState];
    
    // draw line after progress bar

    if(!_progressBarLineGradient) _progressBarLineGradient = [[NSGradient alloc] initWithStartingColor: kProgressBarProgressLineGradient0 endingColor: kProgressBarProgressLineGradient1];

    NSBezierPath *progressLinePath = [NSBezierPath bezierPathWithRect: NSMakeRect(NSWidth(progressBarRect)+1, progressBarRect.origin.y, 1, NSHeight(progressBarRect))];
    [_progressBarLineGradient drawInBezierPath: progressLinePath angle: 90];
}


// this method is responsible of drawing the aqua "water" particles animation
- (void)drawAnimationStep
{
    // initialize colors and gradient only once
    if(!_particleGrad1) {
        _particleGrad1 = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 0.07];
        _particleGrad2 = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 0];
        _particleGradient = [[NSGradient alloc] initWithStartingColor: _particleGrad1 endingColor: _particleGrad2];
    }

    // get progress rect and check if it's empty
    NSRect progressBarRect = [self progressBarRect];
    NSBezierPath *progressPath = [NSBezierPath bezierPathWithRoundedRect:progressBarRect xRadius:kProgressBarCornerRadius yRadius:kProgressBarCornerRadius];
    // if the rect is empty we don't do anything
    if ([progressPath isEmpty]) return;
    
    // limits the drawing of the particles to be only inside the progress area
    [progressPath addClip];
    
    // calculate how many particles we can fit inside the progress rect and add some extra for good luck :P
    int particlePitch = round(NSWidth(progressBarRect)/kParticleWidth)+2;
    
    // value used to calculate the X position of a particle
    CGFloat particleDelta = kParticleWidth+kParticleSpacing-kParticleWidth/2;
    
    for (int i = 0; i < particlePitch; i++) {
        // calculate X position of particle
        CGFloat particleX = (i*particleDelta)-_currentAnimationStep;
        
        // make circle used do draw the particle's gradient
        NSBezierPath *particlePath = [NSBezierPath bezierPathWithOvalInRect: NSMakeRect(particleX, 3, kParticleWidth, 15)];
        [NSGraphicsContext saveGraphicsState];
        [[NSGraphicsContext currentContext] setCompositingOperation:NSCompositePlusLighter];
        [particlePath addClip];
        
        // draw particle gradient
        NSPoint gradientPoint = NSMakePoint(particleX+17, NSHeight(self.frame)/2.0);
        NSGradientDrawingOptions options = NSGradientDrawsBeforeStartingLocation | NSGradientDrawsAfterEndingLocation;
        [_particleGradient drawFromCenter: gradientPoint radius: 0
                        toCenter: gradientPoint radius: 12.72
                         options: options];
        
        [NSGraphicsContext restoreGraphicsState];
    }
}

// this method is responsible of drawing the stripes animation when the PI is indeterminate
- (void)drawIndeterminateAnimationStep
{
#define kIndeterminateParticleWidth 34.0
#define kIndeterminateParticleSpacing 16.0
    
    if(!_indeterminateGradient) {
        _indeterminateGradientColor0 = [NSColor colorWithCalibratedRed: 0.917 green: 0.917 blue: 0.916 alpha: 1];
        _indeterminateGradientColor1 = [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 1];
        _indeterminateGradientColor2 = [NSColor colorWithCalibratedRed: 0.951 green: 0.951 blue: 0.951 alpha: 1];
        _indeterminateGradientColor3 = [NSColor colorWithCalibratedRed: 0.907 green: 0.907 blue: 0.907 alpha: 1];
        
        _indeterminateGradient = [[NSGradient alloc] initWithColorsAndLocations:
                                  _indeterminateGradientColor0, 0.0,
                                  _indeterminateGradientColor1, 0.48,
                                  _indeterminateGradientColor2, 0.49,
                                  _indeterminateGradientColor3, 1.0, nil];
    }
    
    NSRect progressBarRect = [self progressBarRect];
    int particlePitch = round(NSWidth(progressBarRect)/kIndeterminateParticleWidth)+2;

    CGFloat particleDelta = kIndeterminateParticleWidth+kIndeterminateParticleSpacing-kIndeterminateParticleWidth/2;
    
    for (int i = 0; i < particlePitch; i++) {
        CGFloat particleX = (i*particleDelta)+_currentAnimationStep;
        
        NSBezierPath *particlePath = [NSBezierPath bezierPath];
        [particlePath moveToPoint: NSMakePoint(particleX-10, NSHeight(self.frame))];
        [particlePath lineToPoint: NSMakePoint(particleX+kIndeterminateParticleWidth/2-30, NSHeight(self.frame))];
        [particlePath lineToPoint: NSMakePoint(particleX+kIndeterminateParticleWidth-30, 0)];
        [particlePath lineToPoint: NSMakePoint(particleX+kIndeterminateParticleWidth/2-30, 0)];
        [particlePath lineToPoint: NSMakePoint(particleX-30, NSHeight(self.frame))];
        [particlePath closePath];
        [_indeterminateGradient drawInBezierPath:particlePath angle:-90];
    }
}

@end
