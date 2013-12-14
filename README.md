# GRProgressIndicator

This is a reimplementation of NSProgressIndicator with some customization support

## Usage

Place a custom view in your xib and set its class to "GRProgressIndicator"

IMPORTANT: this view will work best if It's height is 19 or less, you can use bigger heights but the gradient may look strange

## Changing the look

Without any changes the progress indicator looks pretty much the same as NSProgressIndicator, but you can change its look by setting the theme property

Available themes:
* GRProgressIndicatorThemeDefault
* GRProgressIndicatorThemeForceGraphite
* GRProgressIndicatorThemeGreen
* GRProgressIndicatorThemeRed
* GRProgressIndicatorThemePink
* GRProgressIndicatorThemeOrange

You can change the colors or create your own themes by editing the "GRProgressIndicatorThemes.h" file

### Animated Gif Demo :)

![screenshot](https://raw.github.com/insidegui/GRProgressIndicator/master/GRProgressIndicatorDemo.gif)