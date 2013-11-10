//
//  Deck.h
//  TwentyFourPt
//
//  Created by huang huijing on 5/30/13.
//  Copyright (c) 2013 huang huijing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card;
-(Card *)drawRandomCard;
+(NSArray *)validSuit;
+(NSArray *)rankString;

@end
