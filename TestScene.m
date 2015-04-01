//
//  TestScene.m
//  TestClipingNode
//
//  Created by Sway007 on 11/28/14.
//  Copyright 2014 Apportable. All rights reserved.
//


// http://stackoverflow.com/questions/22662400/cutting-shaped-holes-in-polygons-in-cocos2d
// mutiple scissor rect node can be add in one stencil node.

#import "TestScene.h"


@implementation TestScene

-(void)didLoadFromCCB
{
//    [self drawHole];
    [_lable setColor:[CCColor redColor]];
    [_lable setPositionType:CCPositionTypeNormalized];
    [_lable setAnchorPoint:ccp(0.5, 0.5)];
    [_lable setPosition:ccp(0.5, 0.5)];
    

    
    CGSize viewSize = [CCDirector sharedDirector].viewSize;
    CCNodeColor* shadow = [CCNodeColor nodeWithColor:[CCColor blueColor] width:viewSize.width height:viewSize.height];
    shadow.anchorPoint = ccp(0.5, 0.5);
    shadow.opacity = 0.5;
    shadow.position = ccp(viewSize.width/2, viewSize.height/2);
    [test addChild:shadow];
    
    CCNodeColor* shadow = [InstructionLayer getShadow];
    [shadow setPositionType:CCPositionTypeNormalized];
    [shadow setPosition:ccp(0.5, 0.5)];
    [test addChild:shadow];
}

- (void) drawHole
{
    CGSize viewSize = [CCDirector sharedDirector].viewSize;
    
    [_lable setColor:[CCColor redColor]];
    [_lable setPositionType:CCPositionTypeNormalized];
    [_lable setAnchorPoint:ccp(0.5, 0.5)];
    [_lable setPosition:ccp(0.5, 0.5)];
    
    
    CCNodeColor* scissorRect2 = [CCNodeColor nodeWithColor:[CCColor redColor] width:_lable.contentSize.width/2 height:_lable.contentSize.height];
    [scissorRect2 setAnchorPoint:ccp(0.5, 0.5)];
    scissorRect2.position = ccp(viewSize.width/2, viewSize.height/2);
    
    CCNodeColor* hole = [CCNodeColor nodeWithColor:[CCColor clearColor] width:_lable.contentSize.width/5 height:_lable.contentSize.height];
    hole.anchorPoint = ccp(0.5, 0.5);
    hole.position = ccp(scissorRect2.position.x + scissorRect2.contentSize.width/2 + 20, scissorRect2.contentSize.height/2 + 20);
    
    
    CCNode* stencilNode = [CCNode node];
    [stencilNode addChild:scissorRect2];
//    [stencilNode addChild:hole];
    
    CCClippingNode* scissor2 = [CCClippingNode clippingNodeWithStencil:stencilNode];
    [scissor2 setAlphaThreshold:0.0];
    [scissor2 setInverted:YES];
    [scissor2.stencil addChild:hole];
    
    
    
    CCNodeColor* shadow = [CCNodeColor nodeWithColor:[CCColor blueColor] width:viewSize.width height:viewSize.height];
    shadow.anchorPoint = ccp(0.5, 0.5);
    shadow.opacity = 0.5;
    shadow.position = ccp(viewSize.width/2, viewSize.height/2);
    
    
    [scissor2 addChild:shadow];
    
    
    [self addChild:scissor2];
}

@end
