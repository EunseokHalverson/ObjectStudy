//
//  Movie.swift
//  Object_Study
//
//  Created by Klown on 2022/01/24.
//

import Foundation

public class Screening {
    private var movie: Movie
    private var sequence: Int
    private var whenScreened: Date
    
    init(movie: Movie, sequence: Int, whenScreened: Date) {
        self.movie = movie
        self.sequence = sequence
        self.whenScreened = whenScreened
    }
    
    public func getStartTime() -> Date {
        return whenScreened
    }
    
    public func isSequence(sequence: Int) -> Bool {
        return self.sequence == sequence
    }
    
    public func getMovieFee() -> Money {
        return movie.getFee()
    }
    
    public func reserve(customer: Customer, audienceCount: Int) -> Reservation {
        return Reservation(customer: customer, screening: self, fee: calculateFee(audienceCount: audienceCount), audienceCount: audienceCount)
    }
    
    public func calculateFee(audienceCount: Int) -> Money {
        return movie.calculateMovieFee(screening: self).times(percent: Double(audienceCount))
    }
}

public class Movie {
    private var title: String
    private var runningTime: Int
    private var fee: Money
    private var discountPolicy: DiscountPolicy
    
    init(title: String, runningTime: Int, fee: Money, discountPolicy: DiscountPolicy) {
        self.title = title
        self.runningTime = runningTime
        self.fee = fee
        self.discountPolicy = discountPolicy
    }
    
    public func getFee() -> Money {
        return fee
    }
    
    public func calculateMovieFee(screening: Screening) -> Money {
        return fee.minis(amount: discountPolicy.calculateDiscountAmount(screening: screening))
    }
}

public class Money {
    public static var ZERO: Money = Money(amount: 0)
    private final var amount: Int
    
    init(amount: Int) {
        self.amount = amount
    }
    
    public func times(percent: Double) -> Money {
        return Money(amount: self.amount * Int(percent))
    }
    
    public func wons(amount: Int) -> Money {
        return Money(amount: amount)
    }
    
    public func plus(amount: Money) -> Money {
        return Money(amount: self.amount + amount.amount)
    }
    
    public func minis(amount: Money) -> Money {
        return Money(amount: self.amount - amount.amount)
    }
    
    public func isLessThan(other: Money) -> Bool {
        return self.amount < other.amount
    }
    
    public func isGreateThanOrEqual(other: Money) -> Bool {
        return self.amount >= other.amount
    }
}

public class Customer { }

public class Reservation {
    private var customer: Customer
    private var screening: Screening
    private var fee: Money
    private var audienceCount: Int
    
    init(customer: Customer, screening: Screening, fee: Money, audienceCount: Int) {
        self.customer = customer
        self.screening = screening
        self.fee = fee
        self.audienceCount = audienceCount
    }
}

protocol DiscountCondition {
    func isSatisfiedBy(screening: Screening) -> Bool
}

protocol DiscountPolicy {
    func getDiscountAmount(screening: Screening) -> Money
}

extension DiscountPolicy {
    var conditions: [DiscountCondition] {
        get {
            return self.conditions
        }
        set {
            self.conditions = newValue
        }
    }
    
    func calculateDiscountAmount(screening: Screening) -> Money {
        conditions.forEach {
            if $0.isSatisfiedBy(screening: screening) {
                return getDiscountAmount(screening: screening)
            }
        }
        return Money.ZERO
    }
}

public class SequenceCondition: DiscountCondition {
    private var sequence: Int
    
    init(sequence: Int) {
        self.sequence = sequence
    }
    
    func isSatisfiedBy(screening: Screening) -> Bool {
        return screening.isSequence(sequence: sequence)
    }
}

public class PeriodCondition: DiscountCondition {
    private var dayOfWeek: Date
    private var startTime: Date
    private var endTime: Date
    
    init(dayOfWeek: Date, startTime: Date, endTime: Date) {
        self.dayOfWeek = dayOfWeek
        self.startTime = startTime
        self.endTime = endTime
    }
    
    func isSatisfiedBy(screening: Screening) -> Bool {
        return screening.getStartTime().getDayOfWeek() &&
        startTime < screening.getStartTime() && endTime >= screening.getStartTime()
    }
}

public class AmountDiscountPolicy: DiscountPolicy {
    private var discountAmount: Money
    
    init(discountAmount: Money, conditions: [DiscountCondition]) {
        self.discountAmount = discountAmount
        self.conditions = conditions
    }
    
    func getDiscountAmount(screening: Screening) -> Money {
        return discountAmount
    }
}

public class PercentDiscountPolicy: DiscountPolicy {
    private var percent: Double
    
    init(percent: Double, conditions: DiscountCondition) {
        self.percent = percent
        self.conditions = conditions
    }
    
    func getDiscountAmount(screening: Screening) -> Money {
        return screening.getMovieFee().times(percent: percent)
    }
}


var avatar: Movie = Movie(title: "아바타",
                          runningTime: 120,
                          fee: Money(amount: 11800),
                          discountPolicy: AmountDiscountPolicy(discountAmount: Money(amount: 800), conditions: [
                                SequenceCondition(sequence: 1),
                                SequenceCondition(sequence: 10),
                                PeriodCondition(dayOfWeek: Date(), startTime: Date(), endTime: Date()),
                                PeriodCondition(dayOfWeek: Date(), startTime: Date(), endTime: Date())
                          ]))
