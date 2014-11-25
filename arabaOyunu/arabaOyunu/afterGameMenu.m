//
//  afterGameMenu.m
//  arabaOyunu
//
//  Created by tellioglu on 29.06.2014.
//  Copyright (c) 2014 tellioglu. All rights reserved.
//

#import "afterGameMenu.h"
#import <Social/Social.h>
#import "ViewController.h"
#import "GameScene.h"
@implementation afterGameMenu
-(id) initWithScoreAndLevel:(float)Score :(int)Level :(CGSize) size{
    if (self = [super initWithSize:size]) {
        SKSpriteNode * background = [SKSpriteNode spriteNodeWithImageNamed:@"backgroundAfter.png"];
        background.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        SKNode * labels = [[SKNode alloc]init];
        SKLabelNode * levels = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
        levels.text = [NSString stringWithFormat:@"Score : %.0f",Score];
        levels.fontSize = 20;
        levels.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-100);
        [labels addChild:levels];
        SKLabelNode* score= [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
        score.text = [NSString stringWithFormat:@"Level : %d",Level];
        score.fontSize = 20;
        score.position = CGPointMake(levels.position.x, levels.position.y+25);
        [labels addChild:score];
        labels.position = CGPointMake(0, 0);
        [self addChild:labels];
        [self CreateTwitterLabel:Score];
        SKSpriteNode * retrynode = [SKSpriteNode spriteNodeWithImageNamed:@"refreshicon.png"];
        retrynode.name = @"retry";
        retrynode.size = CGSizeMake(50, 50);
        retrynode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-100);
        [self addChild:retrynode];
    }
    return self;
}
-(void) CreateTwitterLabel:(float) score{
    SKSpriteNode * node = [SKSpriteNode spriteNodeWithImageNamed:@"twitter.png"];
    node.position = CGPointMake(CGRectGetMidX(self.frame)*1/3, CGRectGetMinY(self.frame)+120);
    node.size = CGSizeMake(50 , 50);
    node.name = @"twitter";
    [self addChild:node];
    SKSpriteNode * nodeface = [SKSpriteNode spriteNodeWithImageNamed:@"facebook-icon.png"];
    nodeface.position = CGPointMake(CGRectGetMidX(self.frame)*2/3, CGRectGetMinY(self.frame)+120);
    nodeface.size = CGSizeMake(50, 50);
    nodeface.name = @"facebook";
    [self addChild:nodeface];
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    SKNode * node = [self nodeAtPoint:point];
    if([node.name isEqualToString:@"twitter"]){
        ViewController * cont = (ViewController*)self.view.window.rootViewController;
        float a = 1000;
        [cont showTwitter:[NSString stringWithFormat:@"Your Score is : %.0f",a]];
    }else if([node.name isEqualToString:@"facebook-icon.png"]){
        ViewController * cont = (ViewController*)self.view.window.rootViewController;
        float a = 1000;
        [cont showFaceBook:[NSString stringWithFormat:@"Your Score is : %.0f",a]];
    }else if([node.name isEqualToString:@"retry"]){
        [self.view presentScene:[[GameScene alloc] initWithSize:self.frame.size]];
    }
}
@end
