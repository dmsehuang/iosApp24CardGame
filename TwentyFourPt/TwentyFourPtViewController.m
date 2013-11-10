//
//  TwentyFourPtViewController.m
//  TwentyFourPt
//
//  Created by huang huijing on 5/29/13.
//  Copyright (c) 2013 huang huijing. All rights reserved.
//

#import "TwentyFourPtViewController.h"
#import "Card.h"
#import "Deck.h"
#import "Game.h"

@interface TwentyFourPtViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *operButtons;

@property (strong,nonatomic) Deck *deck;
@property (strong,nonatomic) Game *game;
@property (weak, nonatomic) IBOutlet UILabel *calculation;
@property (nonatomic) int cardSelected;
@property (nonatomic) int result;
@property (nonatomic) int score;
@property (weak, nonatomic) IBOutlet UILabel *calResult;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation TwentyFourPtViewController

-(Game *)game
{
    if(!_game) _game = [[Game alloc]init];
    return _game;
}

- (IBAction)startGame:(UIButton *)sender {
    self.cardSelected = 0;
    self.result = 0;
    self.score = 0;
    [self resetUI];
    sender.selected = !sender.isSelected;
    if(sender.selected){
        [self randomCards];
    }
    else{
        [self backCards];
        // if click restart, all cards will be flipped
    }
    self.scoreLabel.text = @"0";
}
- (IBAction)nextCards:(UIButton *)sender {
    //skip

    self.cardSelected = 0;
    self.result = 0;
    [self randomCards];
    [self resetUI];
}
- (IBAction)enterResult:(UIButton *)sender {
    [self.game playable];
    //后更新界面
    //update user interface
    //[self randomCards];
    self.cardSelected = 0;
    
    NSString *equation = [self.game getEquation];
    self.result = [self.game calculator:equation];
    NSString *resultStr = [NSString stringWithFormat:@"%d",self.result];
    self.calResult.text = resultStr;
    
    if (self.result == 24) {
        self.score +=4;
    }else{
        self.score -=2;
    }

    NSString *scoreStr = [NSString stringWithFormat:@"%d",self.score];
    self.scoreLabel.text = scoreStr;
    
    [self.game clearPreString];
}

-(void)resetUI
{
    for(UIButton *cardButton in self.cardButtons){
        cardButton.enabled = YES;
        cardButton.alpha = 1.0;
    }
    self.calResult.text = @"";
    self.calculation.text = @"";
}

//update four cards
-(void)randomCards
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.deck drawRandomCard];
        [cardButton setTitle:[NSString stringWithFormat:@"%@%@",card.suit,card.rank] forState:normal];
    }
}
-(void)backCards
{
    for(UIButton *cardButton in self.cardButtons){
        [cardButton setTitle:@"" forState:normal];
    }
}

- (IBAction)chooseCard:(UIButton *)sender {

    self.cardSelected++;
    sender.enabled = NO;
    if (!sender.enabled) {
        sender.alpha = 0.3;
    }
    NSString *content = [sender currentTitle];
    NSMutableString *newStr = [[NSMutableString alloc] initWithString:self.calculation.text];
    [newStr appendString:content];
    self.calculation.text = newStr;
    [self.game pushCard:[sender currentTitle]];
    

}

- (IBAction)operation:(UIButton *)sender {
    NSString *content = [sender currentTitle];
    sender.selected = !sender.isSelected;
    NSMutableString *newStr = [[NSMutableString alloc] init];
    [newStr appendString:self.calculation.text];
    [newStr appendString:content];
    self.calculation.text = newStr;
    [self.game pushOperation:[sender currentTitle]];

}



-(Deck *)deck
//lazy instantiation
{
    if (!_deck) {
        _deck = [[Deck alloc]init];
    }
    return _deck;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
