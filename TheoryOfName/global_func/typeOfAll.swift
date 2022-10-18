//
//  typeOfAll.swift
//  TheoryOfName
//
//  Created on 2021/11/21.
//

// MARK: Enum 及 解析JSON型別
import Foundation

enum CharacterEnum: String {
    case woodToWood = "木平宮" //1
    case woodToFire = "木生火"//2
    case woodToDust = "木剋土"//3
    case goldToWood = "金剋木"//4
    case waterToWood = "水生土"//5
    case fireToFire = "火平宮"//6
    case fireToDust = "火生土"//7
    case fireToGold = "火剋金"//8
    case waterToFire = "水剋火"//9
    case dustToDust = "土平宮"//10
    case dustToGold = "土生金"//11
    case dustToWater = "土剋水"//12
    case goldToGold = "金平宮"//13
    case goldToWater = "金生水"//14
    case waterToWater = "水平宮"//15
}

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
