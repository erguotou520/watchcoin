//
//  HuobiResp.swift
//  watchcoin
//
//  Created by 二锅头 on 2021/5/11.
//
// https://app.quicktype.io/

import Foundation

// MARK: - HuobiResp
struct HuobiResp: Codable {
    let ch, status: String
    let ts: Int
    let tick: Tick
}

// MARK: - Tick
struct Tick: Codable {
    let id, ts: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Double
    let ts, tradeID: Int
    let amount, price: Double
    let direction: String

    enum CodingKeys: String, CodingKey {
        case id, ts
        case tradeID = "trade-id"
        case amount, price, direction
    }
}
