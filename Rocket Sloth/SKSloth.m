//
//  SKSloth.m
//  Rocket Sloth
//
//  Created by Jenna Gain on 4/22/14.
//  Copyright (c) 2014 Snacks. All rights reserved.
//

#import "SKSloth.h"
@interface SKSloth ()



@end

@implementation SKSloth

- (SKSpriteNode *)sloth
{
    SKSpriteNode *sloth = [SKSpriteNode spriteNodeWithImageNamed:@"RocketSlothHorizontal2.png"];
    sloth.position = CGPointMake(0, 0);
    [sloth setScale:0.25];

    return sloth;
}


@end
