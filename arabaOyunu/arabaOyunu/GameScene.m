//
//  GameScene.m
//  arabaOyunu
//
//  Created by tellioglu on 25.06.2014.
//  Copyright (c) 2014 tellioglu. All rights reserved.
//

#import "GameScene.h"
#import "PanelNode.h"
#import "afterGameMenu.h"
static const uint32_t randomCategory = 0x1 <<0;
static const uint32_t PLayerCategory = 0x2<<1;
#define MAX_LIFE 4;
@implementation GameScene
BOOL isplayin;
long int score;
int level;
int positionofPlayer;
PanelNode * panel;
NSTimeInterval lastUpdate;
NSTimeInterval lastLevelUpdate;
-(id) initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        [self BeginTheGame];
    }
    return self;
}
-(void) BeginTheGame{
    lastUpdate = 0;
    lastLevelUpdate = 0;
    level = 0;
    score = 0;
    positionofPlayer = 0;
    isplayin = NO;
    SKSpriteNode * background = [SKSpriteNode spriteNodeWithImageNamed:@"background.jpg"];
    background.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
    SKSpriteNode * mainchar = [SKSpriteNode spriteNodeWithImageNamed:@"balon.png"];
    mainchar.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame)+30);
    mainchar.size = CGSizeMake(30, 30);
    mainchar.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(30, 30)];
    mainchar.physicsBody.categoryBitMask = PLayerCategory;
    mainchar.physicsBody.collisionBitMask = randomCategory;
    mainchar.physicsBody.contactTestBitMask = randomCategory;
    mainchar.physicsBody.dynamic=YES;
    mainchar.physicsBody.mass = 1000;
    mainchar.physicsBody.allowsRotation=NO;
    mainchar.physicsBody.usesPreciseCollisionDetection=YES;
    mainchar.name = @"main";
    [self addChild:mainchar];
    SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
    label.fontSize=12;
    label.fontColor = [UIColor blueColor];
    label.text=@"Tap To Start";
    label.name = @"tap";
    label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:label];
    [self setUpLevelNode];
    //panel hazirlama
    
    panel = [[PanelNode alloc] initWithLife:1 :self.frame.size];
    panel.position = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame)-100);
    [self addChild:panel];
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * toch = [touches anyObject];
    CGPoint pnt = [toch locationInNode:self];
    if(isplayin==NO){
        isplayin = YES;
        SKNode * node = [self childNodeWithName:@"tap"];
        [node removeFromParent];
    }else{
        if(pnt.x>CGRectGetMidX(self.frame)){
            if(positionofPlayer!=2)
                positionofPlayer++;
        }else{
            if(positionofPlayer!=-2)
                positionofPlayer--;
        }
        SKNode* nd = [self childNodeWithName:@"main"];
        SKAction * act = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame)+(positionofPlayer*70), CGRectGetMinY(self.frame)+60) duration:0.3];
        [nd runAction:act];
    }
}
-(void) update:(NSTimeInterval)currentTime{
    if(isplayin==YES){
        if(currentTime-lastUpdate>=(0.3+(1/((level+1)*10)))){
            int ra = rand();
            ra%=30;
            if(ra<=1)
                [self createLifeNode];
            else{
                lastUpdate = currentTime;
                [self createRandomMons];
                score +=100;
                [self scoreLabel];
            }
        }
        if(currentTime-lastLevelUpdate>=10){
            lastLevelUpdate = currentTime;
            level++;
            SKLabelNode * node =(SKLabelNode*) [self childNodeWithName:@"levelnode"];
            node.text = [NSString stringWithFormat:@"level : %d",level];
        }
        if ((rand()%100)<2) {
            int extra = rand()%3;
            switch (extra) {
                case 0:
                    [self CreateExtraScoreNode];
                    break;
                case 1:
                    
                    break;
                case 2:
                    break;
                default:
                    break;
            }
        }
        
    }
}
-(void) createLifeNode{
    SKSpriteNode * node = [SKSpriteNode spriteNodeWithImageNamed:@"heart.png"];
    node.size = CGSizeMake(30, 30);
    node.name=@"life";
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
    node.physicsBody.categoryBitMask = randomCategory;
    node.physicsBody.contactTestBitMask = PLayerCategory;
    node.physicsBody.collisionBitMask = PLayerCategory;
    node.physicsBody.dynamic = NO;
    node.physicsBody.allowsRotation=NO;
    int a  = rand();
    a %=6;
    a-=2;
    node.position = CGPointMake(CGRectGetMidX(self.frame)+(a*70), CGRectGetMaxY(self.frame)-10);
    [node runAction:[SKAction repeatActionForever:[SKAction moveBy:CGVectorMake(0, -10) duration:0.1]]];
    [self addChild:node];
}
-(void) scoreLabel{
    SKNode * nd = [self childNodeWithName:@"Score"];
    [nd removeFromParent];
    SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
    label.fontSize=12;
    label.fontColor = [UIColor brownColor];
    label.colorBlendFactor=0.7;
    label.text = [NSString stringWithFormat:@"Score :%ld",score];
    label.position = CGPointMake(CGRectGetMinX(self.frame)+50, CGRectGetMaxY(self.frame)-80);
    label.name = @"Score";
    [self addChild:label];
}
-(void) didBeginContact:(SKPhysicsContact *)contact{
    if([contact.bodyA.node.name isEqualToString:@"gold"]){
        score+=150;
        [contact.bodyA.node removeFromParent];
    }else if([contact.bodyB.node.name isEqualToString:@"gold"]){
        score+=150;
        [contact.bodyB.node removeFromParent];
    }else{
        if([contact.bodyA.node.name isEqualToString:@"life"]){
            [contact.bodyA.node removeFromParent];
            score+=30;
            if(panel.LifeCount<=3)
                [panel addLife];
        }else if([contact.bodyB.node.name isEqualToString:@"life"]){
            [contact.bodyB.node removeFromParent];
            score +=30;
            if(panel.LifeCount<=3)
                [panel addLife];
        }else{
            [panel removeLife];
            score-=50;
            if([contact.bodyA.node.name isEqualToString:@"main"])
                [contact.bodyB.node removeFromParent];
            else
                [contact.bodyA.node removeFromParent];
            if(panel.LifeCount==1){
                [self removeAllChildren];
                isplayin = NO;
                afterGameMenu * men =[ [afterGameMenu alloc] initWithScoreAndLevel:score :level :self.frame.size];
                [self.view presentScene:men transition:[SKTransition crossFadeWithDuration:1]];
            }
        }
    }
}
-(void) setUpLevelNode{
    SKLabelNode * levelnode = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
    levelnode.fontSize = 12;
    levelnode.fontColor =[UIColor whiteColor];
    levelnode.name = @"levelnode";
    levelnode.position = CGPointMake(CGRectGetMinX(self.frame)+50, CGRectGetMaxY(self.frame)-50);
    levelnode.text = [NSString stringWithFormat:@"level : %d",level];
    [self addChild:levelnode];
}
-(void) createRandomMons{
    SKSpriteNode * nd = [SKSpriteNode spriteNodeWithImageNamed:@"blade.png"];  nd.size = CGSizeMake(30, 30);
    SKPhysicsBody * bdy = [SKPhysicsBody bodyWithRectangleOfSize:nd.size];
    nd.name = @"bicak";
    bdy.categoryBitMask= randomCategory;
    bdy.collisionBitMask = PLayerCategory;
    bdy.dynamic=YES;
    nd.physicsBody = bdy;
    SKAction *act = [SKAction moveBy:CGVectorMake(0, -10-(rand()%5+(level*rand())%10)) duration:0.1];
    [nd runAction:[SKAction repeatActionForever:act]];
    [nd runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:15 duration:0.3]]];
    int rd  = rand();
    rd %=6;
    rd-=2;
    nd.position = CGPointMake(CGRectGetMidX(self.frame)+(rd*70), CGRectGetMaxY(self.frame)-10);
    [self addChild:nd];
}
-(void) CreateExtraScoreNode{
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"goldCoin"];
    NSMutableArray * ar = [[NSMutableArray alloc]init];
    for (int i =1; i<=atlas.textureNames.count; i++) {
        SKTexture * text = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"goldCoin%d.png",i]];
        [ar addObject:text];
    }
    SKSpriteNode * nd = [SKSpriteNode spriteNodeWithTexture:[ar objectAtIndex:0]];
    int a  = rand();
    a %=6;
    a-=2;
    nd.position = CGPointMake(CGRectGetMidX(self.frame)+(a*70), CGRectGetMaxY(self.frame)-10);
    nd.size = CGSizeMake(20, 20);
    nd.name = @"gold";
    SKPhysicsBody * body = [SKPhysicsBody bodyWithRectangleOfSize:nd.size];
    body.categoryBitMask = randomCategory;
    body.collisionBitMask = PLayerCategory ;
    body.contactTestBitMask = PLayerCategory;
    nd.physicsBody = body;
    SKAction * act = [SKAction moveBy:CGVectorMake(0, -10) duration:0.1];
    [nd runAction:[SKAction repeatActionForever:act]];
    [nd runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:ar timePerFrame:0.33 resize:NO restore:NO]]];
    [self addChild:nd];
}
-(void) CreateBreakNode{
  
}
@end
