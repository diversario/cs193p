//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ilya Shaisultanov on 5/1/14.
//  Copyright (c) 2014 Ilya Shaisultanov. All rights reserved.
//

@import Foundation;
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount:(NSUInteger) count
                         usingDeck:(Deck *) deck;

-(void) chooseCardAtIndex:(NSUInteger)index;
-(Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger maxSelectedCards;

@end
