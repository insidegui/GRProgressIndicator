//
//  GRProgressIndicatorThemes.h
//  Progressbar Fun
//
//  Created by Guilherme Rambo on 13/12/13.
//  Copyright (c) 2013 Guilherme Rambo. All rights reserved.
//

typedef enum GRProgressIndicatorTheme {
    GRProgressIndicatorThemeDefault = 0,
    GRProgressIndicatorThemeForceGraphite = 1,
    GRProgressIndicatorThemeGreen = 2,
    GRProgressIndicatorThemeRed = 3,
    GRProgressIndicatorThemePink = 4,
    GRProgressIndicatorThemeOrange = 5
} GRProgressIndicatorTheme_t;

/**** these constants define the colors for the themes ****/

// progress bar gradient colors from top to bottom, aqua
#define kProgressBarGradientColor0 [NSColor colorWithCalibratedRed: 0.635 green: 0.766 blue: 0.957 alpha: 1]
#define kProgressBarGradientColor1 [NSColor colorWithCalibratedRed: 0.395 green: 0.647 blue: 0.935 alpha: 1]
#define kProgressBarGradientColor2 [NSColor colorWithCalibratedRed: 0.248 green: 0.582 blue: 0.935 alpha: 1]
#define kProgressBarGradientColor3 [NSColor colorWithCalibratedRed: 0.425 green: 0.7 blue: 0.947 alpha: 1]
#define kProgressBarGradientColor4 [NSColor colorWithCalibratedRed: 0.622 green: 0.842 blue: 0.957 alpha: 1]

// progress bar gradient colors from top to bottom, green
#define kProgressBarGreenGradientColor0 [NSColor colorWithCalibratedRed:0.787 green:0.904 blue:0.765 alpha:1.000]
#define kProgressBarGreenGradientColor1 [NSColor colorWithCalibratedRed:0.562 green:0.795 blue:0.518 alpha:1.000]
#define kProgressBarGreenGradientColor2 [NSColor colorWithCalibratedRed:0.460 green:0.742 blue:0.404 alpha:1.000]
#define kProgressBarGreenGradientColor3 [NSColor colorWithCalibratedRed:0.546 green:0.786 blue:0.501 alpha:1.000]
#define kProgressBarGreenGradientColor4 [NSColor colorWithCalibratedRed:0.732 green:0.876 blue:0.701 alpha:1.000]

// progress bar gradient colors from top to bottom, red
#define kProgressBarRedGradientColor0 [NSColor colorWithCalibratedRed:0.873 green:0.637 blue:0.643 alpha:1.000]
#define kProgressBarRedGradientColor1 [NSColor colorWithCalibratedRed:0.761 green:0.344 blue:0.357 alpha:1.000]
#define kProgressBarRedGradientColor2 [NSColor colorWithCalibratedRed:0.729 green:0.263 blue:0.279 alpha:1.000]
#define kProgressBarRedGradientColor3 [NSColor colorWithCalibratedRed:0.780 green:0.396 blue:0.408 alpha:1.000]
#define kProgressBarRedGradientColor4 [NSColor colorWithCalibratedRed:0.853 green:0.583 blue:0.590 alpha:1.000]

// progress bar gradient colors from top to bottom, pink
#define kProgressBarPinkGradientColor0 [NSColor colorWithCalibratedRed:0.860 green:0.708 blue:0.811 alpha:1.000]
#define kProgressBarPinkGradientColor1 [NSColor colorWithCalibratedRed:0.801 green:0.552 blue:0.714 alpha:1.000]
#define kProgressBarPinkGradientColor2 [NSColor colorWithCalibratedRed:0.777 green:0.473 blue:0.669 alpha:1.000]
#define kProgressBarPinkGradientColor3 [NSColor colorWithCalibratedRed:0.820 green:0.592 blue:0.751 alpha:1.000]
#define kProgressBarPinkGradientColor4 [NSColor colorWithCalibratedRed:0.894 green:0.739 blue:0.864 alpha:1.000]

// progress bar gradient colors from top to bottom, orange
#define kProgressBarOrangeGradientColor0 [NSColor colorWithCalibratedRed:0.926 green:0.682 blue:0.535 alpha:1.000]
#define kProgressBarOrangeGradientColor1 [NSColor colorWithCalibratedRed:0.885 green:0.522 blue:0.320 alpha:1.000]
#define kProgressBarOrangeGradientColor2 [NSColor colorWithCalibratedRed:0.865 green:0.446 blue:0.225 alpha:1.000]
#define kProgressBarOrangeGradientColor3 [NSColor colorWithCalibratedRed:0.885 green:0.526 blue:0.332 alpha:1.000]
#define kProgressBarOrangeGradientColor4 [NSColor colorWithCalibratedRed:0.936 green:0.727 blue:0.604 alpha:1.000]

// progress bar gradient colors from top to bottom, graphite
#define kProgressBarGraphiteGradientColor0 [NSColor colorWithCalibratedRed:0.688 green:0.718 blue:0.765 alpha:1.000]
#define kProgressBarGraphiteGradientColor1 [NSColor colorWithCalibratedRed:0.527 green:0.580 blue:0.646 alpha:1.000]
#define kProgressBarGraphiteGradientColor2 [NSColor colorWithCalibratedRed:0.448 green:0.511 blue:0.598 alpha:1.000]
#define kProgressBarGraphiteGradientColor3 [NSColor colorWithCalibratedRed:0.493 green:0.554 blue:0.633 alpha:1.000]
#define kProgressBarGraphiteGradientColor4 [NSColor colorWithCalibratedRed:0.729 green:0.779 blue:0.807 alpha:1.000]

// progress bar gradient colors from top to bottom, inactive window
#define kProgressBarInactiveGradientColor0 [NSColor colorWithCalibratedWhite:0.845 alpha:1.000]
#define kProgressBarInactiveGradientColor1 [NSColor colorWithCalibratedWhite:0.737 alpha:1.000]
#define kProgressBarInactiveGradientColor2 [NSColor colorWithCalibratedWhite:0.665 alpha:1.000]
#define kProgressBarInactiveGradientColor3 [NSColor colorWithCalibratedWhite:0.585 alpha:1.000]
#define kProgressBarInactiveGradientColor4 [NSColor colorWithCalibratedRed: 0.53 green: 0.587 blue: 0.662 alpha: 1]

// progress bar inner shadow, aqua
#define kProgressBarInnerShadowColor [NSColor colorWithCalibratedRed: 1 green: 1 blue: 1 alpha: 0.293]

// progress bar inner shadow, graphite
#define kProgressBarGraphiteInnerShadowColor [NSColor colorWithCalibratedRed: 0.776 green: 0.801 blue: 0.828 alpha: 1]

// line after progress bar gradient colors from top to bottom
#define kProgressBarProgressLineGradient0 [NSColor colorWithCalibratedRed: 0.742 green: 0.742 blue: 0.742 alpha: 1]
#define kProgressBarProgressLineGradient1 [NSColor colorWithCalibratedRed: 0.463 green: 0.463 blue: 0.463 alpha: 1]