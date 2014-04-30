//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ilya Shaisultanov on 4/29/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "CardGameViewController.h"
#import "models/PlayingCardDeck.h"
#import "models/Card.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSInteger flipsCount;
@property (nonatomic) PlayingCardDeck *deck;
@property (nonatomic, strong) Card *currentCard;

@end

@implementation CardGameViewController

- (Deck *) deck {
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    
    return _deck;
}

- (void) setFlipsCount:(NSInteger)flipsCount {
    _flipsCount = flipsCount;
    
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %ld", (long)self.flipsCount];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    UIImage *cardback = [UIImage imageNamed: @"cardback"];
    UIImage *cardfront = [UIImage imageNamed: @"cardfront"];
    
    if ([sender.currentTitle length]) {
        if (self.currentCard) {
            [self.deck addCard:self.currentCard];
        }
        
        self.currentCard = nil;
        
        [self setButton:sender toTitle:@"" withBackground:cardback];
    } else {
        Card *card = [self.deck drawRandomCard];
        
        self.currentCard = card;
        
        [self setButton:sender toTitle:[card contents] withBackground:cardfront];
    }
    
    self.flipsCount++;
}

- (void) setButton:(UIButton *)sender toTitle:(NSString *)title withBackground:(UIImage *)image {
    [sender setTitle:title forState:UIControlStateNormal];
    [sender setBackgroundImage:image
                      forState:UIControlStateNormal];
}

@end
