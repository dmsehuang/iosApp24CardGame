//
//  Game.m
//  TwentyFourPt
//
//  Created by huang huijing on 5/30/13.
//  Copyright (c) 2013 huang huijing. All rights reserved.
//

#import "Game.h"

@interface Game ()

@property (strong,nonatomic) NSMutableArray *operationStack;
@property (strong,nonatomic) NSMutableArray *cardStack;
@property (strong,nonatomic) NSMutableString *equation;

@end

@implementation Game

-(NSMutableString *)equation
{
    if (!_equation) {
        _equation = [[NSMutableString alloc]init];
    }
    return _equation;
}

-(void)pushCard:(NSString *)card
{
    [self.cardStack addObject:card];
    int num = [self rankToInt:card];
    NSString *numStr = [NSString stringWithFormat:@"%d",num];
    [self.equation appendString:numStr]; //put card into the string
}

-(int)rankToInt:(NSString *)content
{
    NSString *rank;
    rank = [content substringFromIndex:1];
    NSLog(@"the rank now is: %@",rank);
    NSArray *lookUpTable = [Deck rankString];
    for (int index = 0; index < 13; index++) {
        if ([lookUpTable[index] isEqual:rank]) {
            int trueIndex = ++index;
            return (trueIndex<=10)?trueIndex:10; //remember!
        }
        //NSLog(@"LUT[%d]: %@",index,lookUpTable[index]);
    }
    NSLog(@"error in LUT!");
    return -1;
}

-(void)clearPreString
{
    [self.equation setString:@""];
}

-(NSString *)getEquation
{
    //NSLog(@"msg: %@",self.equation);
    NSString *equationCopy = self.equation;
    if (equationCopy) {
        return equationCopy;
    }
    return @"null!";
}

-(int)calculator:(NSString *)equation
{
    NSExpression *expression = [NSExpression expressionWithFormat:equation];
    float result = [[expression expressionValueWithObject:nil context:nil] floatValue];
    int intResult = (int)result;
    return intResult;
}

-(BOOL)playable
{
    for(NSString *card in self.cardStack)
    {
        NSLog(@"current card: %@",card);
    }
    
    return YES;
}

//-------------- old functions --------------------
-(NSMutableArray *)operationStack
{
    if (!_operationStack) {
        _operationStack = [[NSMutableArray alloc]init];
    }
    return _operationStack;
}

-(NSMutableArray *)cardStack
{
    if(!_cardStack){
        _cardStack = [[NSMutableArray alloc]init];
    }
    return _cardStack;
}

-(void)pushOperation:(NSString *)operation
{
    [self.operationStack addObject:operation];
    [self.equation appendString:operation];
}

-(NSString *)popOperation
{
    NSString *popOper = [self.operationStack lastObject];
    if (popOper) {
        [self.operationStack removeLastObject];
    }
    return popOper;
}

-(int)performOper:(int)num1 :(NSString *)operation :(int)num2
{
    if ([operation isEqualToString:@"+"]) {
        return num1+num2;
    }else if([operation isEqualToString:@"-"]){
        return num1-num2;
    }else if([operation isEqualToString:@"*"]){
        return num1*num2;
    }else if ([operation isEqualToString:@"/"]){
        if (num2 == 0) {
            NSLog(@"error operation!");
        }
        else
        {
            return num1/num2;
        }
    }
    else{
        NSLog(@"no such operation!");
    }
    NSLog(@"error!");
    return -1000;
}

@end
