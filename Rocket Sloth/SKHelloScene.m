//
//  HelloScene.m
//  Rocket Sloth
//
//  Created by Jenna Gain on 4/15/14.
//  Copyright (c) 2014 Snacks. All rights reserved.
//

#import "SKHelloScene.h"
#import "SKLevelOne.h"


@interface SKHelloScene ()
@property BOOL contentCreated;


@end


@implementation SKHelloScene

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
        
    }
}

- (void)createSceneContents
{
   
    self.backgroundColor = [SKColor whiteColor];
    
    
    self.scaleMode = SKSceneScaleModeAspectFit;
    

    [self addChild:[self newHelloScene]];
    [self addChild:[self newHelloNode]];
    [self addChild:[self newSlothNode]];
    [self addChild:[self newPlayButton]];
    [self addChild:[self newStoreButton]];
    [self addChild:[self newViewMissionsButton]];
}


- (SKSpriteNode *)newHelloScene
{
    SKTexture *blueLand = [SKTexture textureWithImageNamed:@"BlueLand.png"];
    SKSpriteNode *helloScene = [SKSpriteNode spriteNodeWithTexture:blueLand size:self.view.frame.size];
    helloScene.position = (CGPoint) {CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame)};
    
    return helloScene;
}

- (SKSpriteNode *)newHelloNode

{
    SKSpriteNode *helloNode = [SKSpriteNode  spriteNodeWithImageNamed:@"RocketSlothLogo-1.png"];
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+200);
    
    helloNode.name = @"helloNode";
    return helloNode;
    
}

- (SKSpriteNode *)newSlothNode
{
    SKSpriteNode *slothNode = [SKSpriteNode spriteNodeWithImageNamed:@"RocketSlothHorizontal2.png"];
    slothNode.position = CGPointMake(300, 225);
    slothNode.size = CGSizeMake(600, 600);
    
    slothNode.name = @"slothNode";
    return slothNode;
}

- (SKSpriteNode *)newPlayButton
{
    SKSpriteNode *playButton = [SKSpriteNode spriteNodeWithImageNamed:@"PlayButton.png"];
    playButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    playButton.size = CGSizeMake(600, 500);
   
   
    
    playButton.name = @"playButton";
    return playButton;
}


- (SKSpriteNode *)newStoreButton
{
    SKSpriteNode *storeButton = [SKSpriteNode spriteNodeWithImageNamed:@"StoreHouse.png"];
    storeButton.position = CGPointMake(CGRectGetMidX(self.frame)-215, CGRectGetMidY(self.frame)-100);
    storeButton.size = CGSizeMake(350, 450);
    storeButton.userInteractionEnabled = YES;
    storeButton.name = @"storeButton";
    return storeButton;
}

- (SKSpriteNode *)newViewMissionsButton
{
    SKSpriteNode *viewMissionsButton = [SKSpriteNode spriteNodeWithImageNamed:@"ViewMissions-1.png"];
    viewMissionsButton.position = CGPointMake(CGRectGetMidX(self.frame) + 225, CGRectGetMidY(self.frame)-50);
    viewMissionsButton.size = CGSizeMake(350, 250);
    viewMissionsButton.name = @"viewMissionsButton";
    viewMissionsButton.userInteractionEnabled = YES;
    return viewMissionsButton;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKNode *helloNode = [self childNodeWithName:@"helloNode"];
    if (helloNode !=nil)
    {
        helloNode.name = nil;
        SKAction *moveUp = [SKAction moveByX:0 y:25.0 duration: 0.5];
        SKAction *zoom = [SKAction scaleTo: 1.3 duration: 0.25];
        SKAction *pause = [SKAction waitForDuration:0.5];
        SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence: @[moveUp, zoom, pause, fadeAway, remove]];
        [helloNode runAction:moveSequence];
        
    }
    
    SKNode *playButton = [self childNodeWithName:@"playButton"];
    if (playButton !=nil)
    {
        playButton.name = nil;
        SKAction *moveUp = [SKAction moveByX:0 y:25.0 duration: 0.5];
        SKAction *zoom = [SKAction scaleTo: 1.3 duration: 0.25];
        SKAction *pause = [SKAction waitForDuration:0.5];
        SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence: @[moveUp, zoom, pause, fadeAway, remove]];
        
        [playButton runAction:moveSequence completion:^{
            SKScene *levelOne = [[SKLevelOne alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:levelOne transition:doors];
        }];
    }
    
    
    
    SKNode *slothNode = [self childNodeWithName:@"slothNode"];
    if (slothNode !=nil)
    {
        slothNode.name = nil;
        SKAction *moveUp =[SKAction moveByX:0 y:25.0 duration: 0.5];
        SKAction *zoom = [SKAction scaleTo: 1.3 duration: 1];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence: @[moveUp, zoom, remove]];
        [slothNode runAction:moveSequence];
    }
    
    }



@end


