//
//  GameScene.m
//  HFSpriteKitDemo
//
//  Created by hanfeng on 2017/11/24.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
}

- (instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        SKSpriteNode *player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        
        player.position = CGPointMake(player.size.width / 2, KMainScreenHeight / 2);
        
        [self addChild:player];
        
        SKAction *actionAddMonster = [SKAction runBlock:^{
            
            [self addMonster];
        }];
        
        SKAction *actionWaitNextMonster = [SKAction waitForDuration:1.0];
        
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[actionAddMonster, actionWaitNextMonster]]]];
    }
    return self;
}


- (void)addMonster{
    
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithImageNamed:@"monster"];
    
    CGSize winSize = self.size;
    
    CGFloat minY = monster.size.height / 2;
    CGFloat maxY = self.size.height - monster.size.height / 2;
    int rangeY = (int)(maxY - minY);
    CGFloat actualY = minY + (arc4random() % rangeY);
    
    monster.position = CGPointMake(self.size.width, actualY);
    [self addChild:monster];
    
    int minDuration = 2;
    int maxDuration = 5;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    SKAction *actionMove = [SKAction moveTo:CGPointMake(-monster.size.width / 2, actualY) duration:actualDuration];
    
//    SKAction *moveForever = [SKAction repeatActionForever:actionMove];
    
    [monster runAction:actionMove];
}

#pragma mark-
- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    // Get label node from scene and store it for use later
    _label = (SKLabelNode *)[self childNodeWithName:@"//helloLabel"];
    
    _label.alpha = 0.0;
    [_label runAction:[SKAction fadeInWithDuration:2.0]];
    
    CGFloat w = (self.size.width + self.size.height) * 0.05;
    
    // Create shape node to use during mouse interaction
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];
    _spinnyNode.lineWidth = 2.5;
    
    [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
    [_spinnyNode runAction:[SKAction sequence:@[
                                                [SKAction waitForDuration:0.5],
                                                [SKAction fadeOutWithDuration:0.5],
                                                [SKAction removeFromParent],
                                                ]]];
}


- (void)touchDownAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor greenColor];
    [self addChild:n];
}

- (void)touchMovedToPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor blueColor];
    [self addChild:n];
}

- (void)touchUpAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor redColor];
    [self addChild:n];
}

#pragma mark-
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Run 'Pulse' action from 'Actions.sks'
    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];

    for (UITouch *t in touches) {
        [self touchDownAtPoint:[t locationInNode:self]];
        
        SKSpriteNode *projectile = [SKSpriteNode spriteNodeWithImageNamed:@"projectile"];
        projectile.position = CGPointMake(projectile.size.width / 2, self.size.height / 2);
        
        CGPoint location = [t locationInNode:self];
        CGPoint offset = CGPointMake(location.x - projectile.position.x, location.y - projectile.position.y);
        
        if (offset.x <= 0) {
            return;
        }
        [self addChild:projectile];
        
        float ratio = (float)offset.y / (float)offset.x;
        int realX = projectile.size.width * 2;
        int realY = (realX * ratio) + projectile.position.y;
        
        SKAction *moveAction = [SKAction moveTo:CGPointMake(realX, realY) duration:1.0];
        
        [projectile runAction:moveAction];
    }

    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
