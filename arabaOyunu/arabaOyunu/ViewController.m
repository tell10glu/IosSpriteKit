//
//  ViewController.m
//  arabaOyunu
//
//  Created by tellioglu on 25.06.2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import <Social/Social.h>
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
}
-(void) showTwitter:(NSString* ) str{
    NSLog(@"burdayim");
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController * postTwitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [postTwitter setInitialText:str];
        [self presentViewController:postTwitter animated:YES completion:nil];
    }else{
        UIAlertView * view = [[UIAlertView alloc] initWithTitle:@"Twitter error" message:@"Can Not access to twitter" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        view.title = @"Error";
        view.delegate = self;
        [view show];
    }
}
-(void) showFaceBook:(NSString *) str{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController * postTwitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [postTwitter setInitialText:str];
        [self presentViewController:postTwitter animated:YES completion:nil];
    }else{
        UIAlertView * view = [[UIAlertView alloc] initWithTitle:@"Facebook error" message:@"Can Not access to Facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        view.title = @"Error";
        view.delegate = self;
        
        [view show];
    }
}
- (BOOL)shouldAutorotate
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
