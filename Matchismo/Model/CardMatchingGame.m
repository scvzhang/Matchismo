//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by 张 俊 on 14-2-15.
//  Copyright (c) 2014年 zhangjun. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSMutableString *hint;

//objective-c中不能标明此array只能放card，（没有强类型检查）所以只能注释一下。
@property (nonatomic, strong) NSMutableArray *cards; //of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

/**
这是designated initializer,所有的初始化函数都需要调用designated initializer,
designated initializer都需要调用父类的designated initializer,

param count:需要初始化的牌的个数
param deck:从哪叠牌中初始化
 **/
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    if (self = [super init]) {//super's designated initializer is init
        self.mode = 1;
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (void)reSet{
    for (Card *card in self.cards) {
        card.chosen = NO;
        card.matched = NO;
    }
    self.score = 0;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

//没有匹配上时的惩罚
static const int MISMATCH_PENALTY = 2;

//每翻一次牌所消耗的点数
static const int COST_TO_CHOOSE = 1;

//更新所选牌的提示, 此处获取的是还没匹配上的选择的牌
- (NSString *)getChosenContent{
    NSMutableString *chosenContent = [NSMutableString stringWithCapacity:50];
    for (Card *hasChosenCard in self.cards) {
        if (hasChosenCard.isChosen && !hasChosenCard.isMatched) {
            [chosenContent appendFormat:@"%@ ", hasChosenCard.contents];
        }
    }
    return [NSString stringWithString:chosenContent];
}

/**
 选中一张牌时，产生的效果。
 **/
- (void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    //只处理还没有匹配上的牌
    if (!card.isMatched) {
        //如果此牌是翻好的，则还原，不扣分
        if (card.isChosen) {
            card.chosen = NO;
            _hint = [NSMutableString stringWithString:[self getChosenContent]];
        }else{
            //找出已被翻牌且还没有匹配的牌
            NSMutableArray *arrayHasChosenCards = [NSMutableArray arrayWithCapacity:2];//of card
            for (Card *hasChosenCard in self.cards) {
                if (hasChosenCard.isChosen && !hasChosenCard.isMatched) {
                    [arrayHasChosenCards addObject:hasChosenCard];
                }
            }
            
            //已翻牌张数还不够
            if ([arrayHasChosenCards count] < self.mode) {
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
                _hint = [NSMutableString stringWithString:[self getChosenContent]];
            }else if ([arrayHasChosenCards count] == self.mode){
                int matchScore = [card match:arrayHasChosenCards];
                if (matchScore) {
                    self.score += matchScore;
                    
                    _hint = [NSMutableString stringWithFormat:@"Matched %@ %@for %d points.",card.contents,[self getChosenContent], matchScore];
                    
                    for (Card *hasChosenCard in self.cards) {
                        if (hasChosenCard.isChosen && !hasChosenCard.isMatched) {
                            hasChosenCard.matched = YES;
                        }
                    }
                    card.matched = YES;
                    card.chosen = YES;
                }else{
                    _hint = [NSMutableString stringWithFormat:@"%@ %@don't match! %d points penalty!",card.contents,[self getChosenContent], MISMATCH_PENALTY];
                    
                    self.score -= MISMATCH_PENALTY;
                    for (Card *hasChosenCard in self.cards) {
                        if (hasChosenCard.isChosen && !hasChosenCard.isMatched) {
                            hasChosenCard.chosen = NO;
                        }
                    }
                }
            }
        }
    }
}
@end
