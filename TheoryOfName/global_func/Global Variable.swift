//
//  Global Variable.swift
//  TheoryOfName
//
//  Created by on 2022/6/21.
//

import Foundation


var gBrainCharacter: String = "" {
    didSet {
        print("思想功能資料初始：", gBrainCharacter)
    }
}
var gActionCharacter: String = ""{
    didSet {
        print("行動功能資料初始：", gActionCharacter)
    }
}
var gTotalNameNum: Int = 0 {
    didSet {
        print("姓名總筆畫初始：", gTotalNameNum)
    }
}
