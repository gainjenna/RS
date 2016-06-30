//
//  LevelOne.m
//  Rocket Sloth
//
//  Created by Jenna Gain on 4/16/14.
//  Copyright (c) 2014 Snacks. All rights reserved.
//

#import "SKLevelOne.h"
#import "SKPizza.h"
#define kScoreHudName @"scoreHud"
#define kHealthHudName @"healthHud"

static const float OBJECT_VELOCITY = 50.0;
static const uint32_t shipCategory = 0x1 << 0;
static const uint32_t obstacleCategory =  0x1 << 1;
static const float BG_VELOCITY = 50.0;
static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b)
    {
        return CGPointMake(a.x + b.x, a.y + b.y);
    }
static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b)
    {
        return CGPointMake(a.x * b, a.y * b);
    }
NSTimeInterval _dt;
@interface SKLevelOne ()
@property BOOL contentCreated;
@property (nonatomic) NSTimeInterval lastUpdateTime;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property NSTimeInterval _lastPizzaAdded;
@end

@implementation SKLevelOne {
    SKSpriteNode *rocket1;
    SKAction *actionMoveUp;
    SKAction *actionMoveDown;
}

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        self.contentCreated = YES;
    }
}

-(id)initWithSize:(CGSize)size 
{
    if (self = [super initWithSize:size]) {
        NSLog(@"Size: %@", NSStringFromCGSize(size));
        self.backgroundColor = [SKColor whiteColor];
        [self initalizingScrollingBackground];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        [self newRocket];
        [self addPizza];
        [self addPizza2];
        actionMoveUp = [SKAction moveByX:0 y:40 duration:.2];
        actionMoveDown = [SKAction moveByX:0 y:-40 duration:.2];
        [self setupHud];
    }
    return self;
}

-(void)setupHud 
{
    SKLabelNode* scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    //1
    scoreLabel.name = kScoreHudName;
    scoreLabel.fontSize = 15;
    //2
    scoreLabel.fontColor = [SKColor blueColor];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %04u", 0];
    //3
    scoreLabel.position = CGPointMake(20 + scoreLabel.frame.size.width/2, self.size.height - (50 + scoreLabel.frame.size.height/2));
    [self addChild:scoreLabel];
    SKLabelNode* healthLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    //4
    healthLabel.name = kHealthHudName;
    healthLabel.fontSize = 15;
    //5
    healthLabel.fontColor = [SKColor blueColor];
    healthLabel.text = [NSString stringWithFormat:@"Health: %.1f%%", 100.0f];
    //6
    healthLabel.position = CGPointMake(self.size.width - healthLabel.frame.size.width/2 - 20, self.size.height - (50 + healthLabel.frame.size.height/2));
    [self addChild:healthLabel];
}

- (void)moveObstacle
{
    NSArray *nodes = self.children;//1
    for(SKNode * node in nodes){
        if (![node.name  isEqual: @"bg"] && ![node.name  isEqual: @"ship"]) {
            SKSpriteNode *ob = (SKSpriteNode *) node;
            CGPoint obVelocity = CGPointMake(-OBJECT_VELOCITY, 0); //2
            CGPoint amtToMove = CGPointMultiplyScalar(obVelocity,_dt); //3
            
            ob.position = CGPointAdd(ob.position, amtToMove); //4
            if(ob.position.x < -100)
            {
                [ob removeFromParent]; //5
            }
        }
    }
}

- (void)newRocket
{
    rocket1= [SKSpriteNode new];
    rocket1 = [SKSpriteNode spriteNodeWithImageNamed:@"RocketSlothHorizontal2.png"];
    rocket1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rocket1.size];
    rocket1.physicsBody.categoryBitMask = shipCategory;
    rocket1.physicsBody.dynamic = YES;
    rocket1.physicsBody.contactTestBitMask = obstacleCategory;
    rocket1.physicsBody.collisionBitMask = 0;
    rocket1.name = @"rocket";
    rocket1.position = CGPointMake(120,160);
    [self addChild:rocket1];
    [rocket1 setScale:0.25];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    
    CGPoint touchLocation = [touch locationInNode:self.scene]; //1
    if (touchLocation.y > rocket1.position.y){ //2
        if(rocket1.position.y < 1000){ //3
            [rocket1 runAction:actionMoveUp]; //4
        }
    } else {
        if (rocket1.position.y > 50){
            [rocket1 runAction:actionMoveDown]; //5
        }
    }
}

-(void)initalizingScrollingBackground
{
    for (int i = 0; i < 2; i++) {
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"BlueLand.png"];
        bg.position = CGPointMake(i * bg.size.width, 0);
        bg.anchorPoint = CGPointZero;
        bg.name = @"bg";
        [self addChild:bg];
    }
}

- (void)moveBg
{
    [self enumerateChildNodesWithName:@"bg" usingBlock: ^(SKNode *node, BOOL *stop)
     {
         SKSpriteNode * bg = (SKSpriteNode *) node;
         CGPoint bgVelocity = CGPointMake(-BG_VELOCITY, 0);
         CGPoint amtToMove = CGPointMultiplyScalar(bgVelocity,_dt);
         bg.position = CGPointAdd(bg.position, amtToMove);
         
         //Checks if bg node is completely scrolled of the screen, if yes then put it at the end of the other node
         if (bg.position.x <= -bg.size.width)
         {
             bg.position = CGPointMake(bg.position.x + bg.size.width*2,
                                       bg.position.y);
         }
     }];
}

-(void)update:(CFTimeInterval)currentTime 
{
    if (_lastUpdateTime)
    {
        _dt = currentTime - _lastUpdateTime;
    }
    else
    {
        _dt = 0;
    }
    _lastUpdateTime = currentTime;
    
    if( currentTime - __lastPizzaAdded > 1)
    {
        __lastPizzaAdded = currentTime + 1;
        [self addPizza];
    }
    
    [self moveBg];
}

- (SKSpriteNode *)newPizza
{
    SKSpriteNode *pizza = [SKSpriteNode
                           spriteNodeWithImageNamed:@"pizza.png"];

    [pizza setScale:0.35];
    return pizza;
}

- (void)addPizza 
{
    SKSpriteNode * pizza = [SKSpriteNode spriteNodeWithImageNamed:@"pizza.png"];
    int minY = pizza.size.height / 6;
    int maxY = self.frame.size.height - pizza.size.height / 2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;

    // Create the pizza slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    int r = arc4random() % 300;
    pizza.position = CGPointMake(self.frame.size.width + 20,r);
    [self addChild:pizza];
    
    //Physics body for pizza
    pizza.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pizza.size];
    pizza.physicsBody.categoryBitMask = obstacleCategory;
    pizza.physicsBody.dynamic = YES;
    pizza.physicsBody.contactTestBitMask = shipCategory;
    pizza.physicsBody.collisionBitMask = 0;
    pizza.physicsBody.usesPreciseCollisionDetection = YES;
    pizza.name = @"pizza";
    
    // Determine speed of the pizza
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    SKAction * actionMove = [SKAction moveTo:CGPointMake(-pizza.size.width/2, actualY) duration:actualDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [pizza runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
}

- (void)addPizza2 
{
    // Create sprite
    SKSpriteNode * pizza = [SKSpriteNode spriteNodeWithImageNamed:@"pizza.png"];
    
    // Determine where to spawn the monster along the Y axis
    int minY = pizza.size.height / 9;
    int maxY = self.frame.size.height - pizza.size.height / 7;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the pizza slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    pizza.position = CGPointMake(self.frame.size.width + pizza.size.width/2, actualY);
    [self addChild:pizza];
}

@end
