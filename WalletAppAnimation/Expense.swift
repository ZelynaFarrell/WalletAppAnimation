//
//  Expense.swift
//  WalletAppAnimation
//
//  Created by Zelyna Sillas on 11/15/23.
//

import Foundation

struct Expense: Identifiable {
    var id = UUID()
    var amountSpent: String
    var product: String
    var spendType: String
}

var expenses: [Expense] = [
    Expense(amountSpent: "$15", product: "Hulu", spendType: "Streaming"),
    Expense(amountSpent: "$128", product: "Amazon", spendType: "Groceries"),
    Expense(amountSpent: "$16", product: "Netflix", spendType: "Streaming"),
    Expense(amountSpent: "$300", product: "Whole Foods", spendType: "Groceries"),
    Expense(amountSpent: "$188", product: "Apple", spendType: "Tech"),
    Expense(amountSpent: "$8", product: "Patreon", spendType: "Membership"),
    Expense(amountSpent: "$19", product: "The Ace", spendType: "Social Outting"),
    Expense(amountSpent: "$2668", product: "Apple", spendType: "Tech"),
    Expense(amountSpent: "$65", product: "Chevron", spendType: "Gasoline"),
    Expense(amountSpent: "$400", product: "Apple", spendType: "Tech"),
    Expense(amountSpent: "$12", product: "Amazon", spendType: "Household"),
    Expense(amountSpent: "$15", product: "Hulu", spendType: "Streaming"),
    Expense(amountSpent: "$128", product: "Amazon", spendType: "Groceries"),
    Expense(amountSpent: "$16", product: "Netflix", spendType: "Streaming"),
    Expense(amountSpent: "$300", product: "Whole Foods", spendType: "Groceries"),
    Expense(amountSpent: "$188", product: "Apple", spendType: "Tech"),
    Expense(amountSpent: "$8", product: "Patreon", spendType: "Membership"),
    Expense(amountSpent: "$19", product: "The Ace", spendType: "Social Outting"),
]
