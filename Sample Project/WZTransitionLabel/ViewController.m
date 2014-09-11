//
//  ViewController.m
//  WZTransitionLabel
//
//  Created by Wenbin Zhang on 9/10/14.
//  Copyright (c) 2014 Wenbin Zhang. All rights reserved.
//

#import "ViewController.h"
#import "WZTransitionLabel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet WZTransitionLabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sem lorem, vehicula ornare cursus vitae, condimentum quis tellus. Vestibulum nunc nisl, pharetra venenatis massa sed, accumsan semper sapien. Fusce condimentum ipsum sit amet tellus condimentum dictum sed et metus. In hac habitasse platea dictumst. Donec vestibulum dolor tempor, accumsan erat et, sagittis arcu. Cras vulputate eleifend massa, ac luctus turpis" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.label transiteToAttributedString:attributedString animated:YES duration:1.5];
}

- (IBAction)changeText:(id)sender {
    NSAttributedString *toString = [[NSAttributedString alloc] initWithString:@"Curabitur suscipit luctus viverra. Vivamus finibus dolor vel interdum dignissim. Phasellus facilisis est eu massa tempor, in volutpat purus feugiat. Curabitur auctor lectus eget luctus dictum. Suspendisse faucibus erat in turpis auctor pharetra. Etiam sapien justo, tempus nec magna at, cursus scelerisque turpis. Cras at consequat nulla. Pellentesque eu velit nunc. Vestibulum sed luctus nibh. Duis eu nibh volutpat, congue quam non, porta purus. Sed sit amet libero velit. In sed sagittis eros, et ornare massa. Aenean massa lacus, tristique vitae pulvinar at, feugiat ut leo. Praesent sed tempus quam, ut mollis odio." attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.label transiteToAttributedString:toString animated:YES duration:1.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
