//
//  MyScene.m
//  arabaOyunu
//
//  Created by tellioglu on 25.06.2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "MyScene.h"
#import "GameScene.h"
@implementation MyScene
NSTimeInterval lastBaloons;
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        lastBaloons = 0;
        SKSpriteNode * menunode= [SKSpriteNode spriteNodeWithImageNamed:@"menuitem.png"];
        menunode.name = @"startgame";
        menunode.size = CGSizeMake(CGRectGetWidth(self.frame)*4/5, CGRectGetHeight(self.frame)/10);
        menunode.position =CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame)*6/10);
        SKLabelNode * node = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
        node.text=@"Start New Game";
        node.name=@"StartLabel";
        node.fontSize = 10;
        node.position = CGPointMake(0,0);
        SKSpriteNode * aboutusNode = [SKSpriteNode spriteNodeWithImageNamed:@"menuitem.png"];
        aboutusNode.name = @"aboutusnode";
        aboutusNode.size =CGSizeMake(CGRectGetWidth(self.frame)*4/5, CGRectGetHeight(self.frame)/10);
        aboutusNode.position =CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame)*4/10);
        SKLabelNode * about = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
        about.text = @"About Us";
        about.position = CGPointMake(0, 0);
        about.fontSize = 10;
        about.name = @"aboutus";
        [aboutusNode addChild:about];
        [menunode addChild:node];
        [self addChild:menunode];
        [self addChild:aboutusNode];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    SKNode * nd = [self nodeAtPoint:point];
    if([nd.name isEqualToString:@"StartLabel"] || [nd.name isEqualToString:@"startgame"]){
        [self removeAllChildren];
        
        SKTransition * trans = [SKTransition crossFadeWithDuration:1];
        [self.view presentScene:[[GameScene alloc] initWithSize:self.frame.size] transition:trans ];
    }else if ([nd.name isEqualToString:@"aboutusnode"] || [nd.name isEqualToString:@"aboutus"]){
        
    }
}
-(void) CreateRandomBaloons{
    SKSpriteNode * nd = [SKSpriteNode spriteNodeWithImageNamed:@"balonlar.png"];
    int r = rand()%3;
    r-=1;
    nd.position = CGPointMake(CGRectGetMidX(self.frame)+r*100, CGRectGetMinY(self.frame));
    nd.size = CGSizeMake(30, 100);
    SKAction * act = [SKAction moveBy:CGVectorMake(0, 100) duration:1];
    SKAction * moveright = [SKAction moveBy:CGVectorMake(3, 0) duration:1];
    SKAction * moveleft = [SKAction moveBy:CGVectorMake(-3, 0) duration:1];
    [nd runAction:[SKAction repeatActionForever:act]];
    [nd runAction:[SKAction repeatActionForever:[SKAction sequence:@[moveright,moveleft]]]];
    [self addChild:nd];
}
-(void)update:(CFTimeInterval)currentTime {
    if(currentTime-lastBaloons>=3){
        lastBaloons = currentTime;
        [self CreateRandomBaloons];
    }
}

@end
