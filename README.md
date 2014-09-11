WZTransitionLabel
=================

WZTransitionLabel is a subclass of UILabel that provide custom transition when switching label's text.

![wztransitionlabel](https://cloud.githubusercontent.com/assets/3296551/4230557/b290b576-3985-11e4-9acf-73b34d12a3d0.gif)

INSTALL
=================
You can install it by adding `pod 'WZTransitionLabel'` to your pod spec, or just simply drag `WZTransitionLabel.h` adn `WZTransitionLabel.m` to your project.

USAGE
=================
```objc
WZTransitionLabel *label = [[WZTransitionLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
label.attributedText = [[NSAttributedString alloc] initWithString:@"test string" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
NSAttributedString *toString = [[NSAttributedString alloc] initWithString:@"another string" attributes@{NSForegroundColorAttributeName:[UIColor redColor]}];
[label transiteToAttributedString:toString animated:YES duration:1.5];
```