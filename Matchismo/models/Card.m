//
//  Card.m
//  Matchismo
//
//  Created by Ilya Shaisultanov on 4/29/14.
//  Copyright (c) 2014 Ilya Shaisultanov. All rights reserved.
//

@import Foundation;
#import "Card.h"

@implementation Card

- (int) match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
