//
//  Court.swift
//  prototypeV1
//
//  Created by Shravan Rajput on 12/12/24.
//
import Foundation

struct Court {
    let id: Int
    let name: String
    let sport: Sport
    var isAvailable: Bool = true
}

struct TimeSlot {
    let startTime: Date
    let endTime: Date
    let courtId: Int
    let gameId: Int
}

