//
//  PanelNode.h
//  arabaOyunu
//
//  Created by tellioglu on 25.06.2014.
//  Copyright (c) 2014 tellioglu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PanelNode : SKNode
@property (nonatomic) int LifeCount;
@property (nonatomic) CGSize size;
-(void) addLife;
-(id) initWithLife:(int) lifeCount :(CGSize ) size;
-(void) removeLife;
@end
