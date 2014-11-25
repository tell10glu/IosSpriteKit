//
//  afterGameMenu.h
//  arabaOyunu
//
//  Created by tellioglu on 29.06.2014.
//  Copyright (c) 2014 tellioglu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface afterGameMenu : SKScene
@property (nonatomic,weak) SKScene * gameScene;
-(id) initWithScoreAndLevel : (float) Score : (int) Level : (CGSize) size;
@end
