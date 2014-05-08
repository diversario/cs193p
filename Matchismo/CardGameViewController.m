//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ilya Shaisultanov on 4/29/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "CardGameViewController.h"
#import "models/PlayingCardDeck.h"
#import "models/Deck.h"
#import "models/Card.h"
#import "models/CardMatchingGame.h"

@interface CardGameViewController ()

@property (nonatomic) Deck *deck;
@property (nonatomic, strong) Card *currentCard;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController

- (Deck *) deck {
    if (!_deck) {
        _deck = [self createDeck];
    }
    
    return _deck;
}

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
}
    
    return _game;
}


- (IBAction)gameModeButton:(UISegmentedControl *)sender {
    NSLog(@"button! %li", (long)sender.selectedSegmentIndex);
    self.game.maxSelectedCards = sender.selectedSegmentIndex + 2;
}

                 
- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void) updateUI {
    for (UIButton *button in self.cardButtons) {
        NSUInteger buttonIndex = [self.cardButtons indexOfObject:button];
        
        Card *card = [self.game cardAtIndex:buttonIndex];
        
        [self setButton:button
                toTitle:[self titleForCard:card]
         withBackground:[self backgroundForCard:card]];
        
        button.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (IBAction)resetButton:(UIButton *)sender {
    _deck = nil;
    _game = nil;
    [self updateUI];
}

- (void) setButton:(UIButton *)sender toTitle:(NSString *)title withBackground:(UIImage *)image {
    [sender setTitle:title forState:UIControlStateNormal];
    [sender setBackgroundImage:image
                      forState:UIControlStateNormal];
}

- (UIImage *) backgroundForCard:(Card *) card {
    UIImage *cardback = [UIImage imageNamed: @"cardback"];
    UIImage *cardfront = [UIImage imageNamed: @"cardfront"];
    
    return card.isChosen ? cardfront : cardback;
}

- (NSString *) titleForCard:(Card *) card {
    return card.isChosen ? card.contents : @"";
}

@end
