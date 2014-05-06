//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ilya Shaisultanov on 5/1/14.
//  Copyright (c) 2014 Ilya Shaisultanov. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation CardMatchingGame

const static int MISMATCH_PENALTY = 2;
const static int MATCH_BONUS = 4;
const static int COST_TO_CHOOSE = 1;

- (NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (!self) return self;
    
    for (int i = 0; i < count; i++) {
        Card *card = [deck drawRandomCard];
        
        if (!card) {
            self = nil;
            break;
        }
        
        [self.cards addObject:card];
    }
    
    return self;
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void) chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];

    if (card.isMatched) return;
    
    if (card.isChosen) {
        card.chosen = NO;
        return;
    }

    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
            int matchScore = [card match:@[otherCard]];
            
            if (matchScore) {
                self.score += matchScore * MATCH_BONUS;
                
                card.matched = otherCard.matched = YES;
            } else {
                self.score -= MISMATCH_PENALTY;
                otherCard.chosen = NO;
            }
            
            break;
        }
    }
    
    self.score -= COST_TO_CHOOSE;
    card.chosen = YES;
}


@end