//
//  PlayingCard.m
//  Matchismo
//
//  Created by 张 俊 on 14-2-11.
//  Copyright (c) 2014年 zhangjun. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

//重写父类的match方法，不需要再在.h文件中定义
//otherCards 用于比较的牌，目前仅为一个内容（比较一张牌即可）
- (int)match:(NSArray *)otherCards{
    int score = 0;
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 13;//2张牌点数一样的奖励。概率：(1/13) * (1/13) * 13 = 1/13
        }else if ([otherCard.suit isEqualToString:self.suit]){
            score = 4;//2张牌花色一样的奖励。概率：1/4 * 1/4 * 4 = 1/4
        }
    }else if ([otherCards count] == 2){
        PlayingCard *otherCard1 = [otherCards firstObject];
        PlayingCard *otherCard2 = [otherCards objectAtIndex:1];
        //按概率从小到大排列，奖励从大到小排列，不考虑给2种奖励
        if (otherCard1.rank == self.rank && otherCard2.rank == self.rank) {
            score = 169;//3张牌点数一样的奖励。概率：(1/13) * (1/13) * (1/13) * 13 = 1/169
            return score;
        }
        if ([otherCard1.suit isEqualToString:self.suit] && [otherCard2.suit isEqualToString:self.suit]) {
            score = 16;//3张牌花色一样的奖励。概率：1/4 * 1/4 * 1/4 * 4 = 1/16;
            return score;
        }
        if (otherCard1.rank == self.rank || otherCard2.rank == self.rank) {
            score = 4;//3张牌中有2张的点数一样的奖励。概率：1/13 * 1/13 * 13 * 3 = 3/13
            return score;
        }
        if ([otherCard1.suit isEqualToString:self.suit] || [otherCard2.suit isEqualToString:self.suit]) {
            score = 1;//3张牌中有2张的花色一样的奖励。概率：1/4 * 1/4 * 4 * 3 = 3/4
            return score;
        }
    }
    return score;
}

/**
 使用此牌的花色和点数组合成此牌的内容。
 **/
- (NSString *)contents{
    NSArray *rankString = [PlayingCard rankStrings];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSArray *)validSuits{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

//重写了getter和setter方法，需要显式声明下。
@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
