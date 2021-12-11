//
//  typeOfAll.swift
//  TheoryOfName
//
//  Created on 2021/11/21.
//

import Foundation

struct NameJson: Decodable {
    var id: Int
    var word: String
    var base: String
    var other: String
    var total: String
}

struct NameData {
    var word: String
    var writingNum: Int
}

struct TimeAndDegree {
    var yearName: String
    var degree: Int
}


struct NameRecords: Codable {
    var lastName: String
    var firstName: String
    var birthday: String
    var diseaseNum: Int
    var friendsNum: Int
    var totalNameNum: Int
}
struct SelfNameRecord: Codable {
    var lastName: String
    var firstName: String
    var birthday: String
    var num: SelfNameNum
}
struct SelfNameNum: Codable {
    var movingNum: Int
    var parentsNum: Int
    var diseaseNum: Int
    var friendsNum: Int
    var totalNameNum: Int
}
