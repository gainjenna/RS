//
//  Pizza.m
//  Rocket Sloth
//
//  Created by Jenna Gain on 4/18/14.
//  Copyright (c) 2014 Snacks. All rights reserved.
//

#import "SKPizza.h"

@implementation SKPizza

- (SKSpriteNode *)newPizza
{
    SKSpriteNode *pizza = [SKSpriteNode
                           spriteNodeWithImageNamed:@"pizza.png"];
    pizza.position = CGPointMake(100, 100);
    [pizza setScale:0.35];
    
    return pizza;
}

@end
