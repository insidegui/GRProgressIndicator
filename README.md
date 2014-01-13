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

### Contributing

You can contribute with code, just send me a pull request, or open an issue for any bug/enhancement.

If you like this and will use It in one of your apps, you can show me some love by [donating through PayPal](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=386Y2DFSN5X94&lc=BR&item_name=Guilherme%20Rambo&item_number=1001&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted)