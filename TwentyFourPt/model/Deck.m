//
//  Deck.m
//  TwentyFourPt
//
//  Created by huang huijing on 5/30/13.
//  Copyright (c) 2013 huang huijing. All rights reserved.
//

#import "Deck.h"

@interface Deck ()

@property (strong,nonatomic) NSMutableArray *cards;

@end

@implementation Deck

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(void)addCard:(Card *)card
{
    //NSLog(@"in the addCard method");
    if (card) {
        [self.cards addObject:card];
    }
    else{
        NSLog(@"card is null");
    }
}

-(id)init
{
    //override init function
    if (self = [super init]) {
        for(NSString *rank in [Deck rankString]){
            for(NSString *suit in [Deck validSuit]){
                Card *card = [[Card alloc]init];
                card.rank = rank;
                card.suit = suit;
                //NSLog(@"%@ %@",card.suit,card.rank);
                [self.cards addObject:card];
            }
        }
    }
    return self;
}

+(NSArray *)validSuit
{
    return @[@"♠",@"♣",@"♥",@"♦"];
}
+(NSArray *)rankString
{
    return @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    NSUInteger numOfCard = [self.cards count];
    //NSLog(@"left card: %ld",numOfCard);
    if(numOfCard){
        int index = arc4random()%numOfCard;
        randomCard = self.cards[index];
        NSLog(@"index is %d",index);
        //NSLog(@"random card: %@ %@",randomCard.suit,randomCard.rank);
        [self.cards removeObjectAtIndex:index];
        //remove object after dealing the card
    }
    return randomCard;
}


@end
