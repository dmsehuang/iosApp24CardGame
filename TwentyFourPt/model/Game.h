//
//  Game.h
//  TwentyFourPt
//
//  Created by huang huijing on 5/30/13.
//  Copyright (c) 2013 huang huijing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface Game : NSObject

-(void)pushOperation:(NSString *)operation;
-(void)pushCard:(NSString *)card;
-(NSString *)popOperation;
-(int)rankToInt:(NSString *)content;
-(int)performOper:(int)num1 :(NSString *)operation :(int)num2;
-(NSString *)getEquation;
-(int)calculator:(NSString *)equation;
-(BOOL)playable;
-(void)clearPreString;

@end
