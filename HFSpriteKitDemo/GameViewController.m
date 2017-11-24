//
//  GameViewController.m
//  HFSpriteKitDemo
//
//  Created by hanfeng on 2017/11/24.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the SKScene from 'GameScene.sks'
//    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
//    scene.scaleMode = SKSceneScaleModeAspectFill;
    
//    SKView *skView = (SKView *)self.view;
    
    // Present the scene
//    [skView presentScene:scene];
    
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    
    
}

/*
 1;app设置手机先旋转，
 2；旋转完之后，计算的新的的bounds.size，再添加scene，
 
 3；每个SKView中可以渲染和管理一个SKScene，每个Scene中可以装载多个精灵SpriteNode
 
 */
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
//    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    GameScene *scene = [GameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
