//
//  PanelNode.m
//  arabaOyunu
//
//  Created by tellioglu on 25.06.2014.
//  Copyright (c) 2014 tellioglu. All rights reserved.
//

#import "PanelNode.h"

@implementation PanelNode
-(id) initWithLife:(int) lifeCount :(CGSize) size{
    if(self = [super init]){
        self.size = size;
        self.LifeCount = lifeCount;
        for (int i =0; i<lifeCount; i++) {
            [self addLife];
        }
    }
    return self;
}
-(void) addLife{
    self.LifeCount ++;
    [self addSpriteNode];
}
-(void) removeLife{
    SKNode * node = [self childNodeWithName:[NSString stringWithFormat:@"%d",self.LifeCount]];
    [node removeFromParent];
    self.LifeCount--;
}

-(void) addSpriteNode {
    SKSpriteNode * node = [SKSpriteNode spriteNodeWithImageNamed:@"life.png"];
    node.size = CGSizeMake(10, 10);
    node.name = [NSString stringWithFormat:@"%d",self.LifeCount];
    node.position = CGPointMake(self.LifeCount*10+2,0);
    [self addChild:node];
}
@end
