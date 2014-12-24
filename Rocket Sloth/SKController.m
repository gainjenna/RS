//
//  SpriteViewController.m
//  Rocket Sloth
//
//  Created by Jenna Gain on 4/15/14.
//  Copyright (c) 2014 Snacks. All rights reserved.
//

#import "SKController.h"
#import "SKHelloScene.h"
#import "SKLevelOne.h"

@interface SKController ()



@end

@implementation SKController

- (void)viewDidLoad
{
    [super viewDidLoad];

    SKView *spriteView = (SKView *) self.view;
    spriteView.showsDrawCount = YES;
    spriteView.showsNodeCount = YES;
    spriteView.showsFPS = YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    SKHelloScene* hello = [[SKHelloScene alloc]initWithSize:CGSizeMake(768, 1024)];
    SKView *spriteView = (SKView *)self.view;
    [spriteView presentScene: hello];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    SKView * skView = (SKView *)self.view;
    
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        SKScene * scene = [SKLevelOne sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
