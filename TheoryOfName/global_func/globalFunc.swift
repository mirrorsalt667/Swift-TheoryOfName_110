//
//  globalFunc.swift
//  TheoryOfName
//
//  Created on 2021/11/7.
//

import Foundation
import UIKit

class keyboardMove {
    func registerForKeyboardNotifications(controller: UIViewController ,handle: @escaping(Notification) -> Void, hideHandle: @escaping(Notification) -> Void) {
        Foundation.NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { mean in
            handle(mean)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { mean2 in
            hideHandle(mean2)
        }
    }
    func keyboardWasShown(_ aNotification: Notification?, view: UIView) {
        let info = aNotification?.userInfo
        guard let kbSize = (info?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {
            return
        }
        let contentInsets = CGRect(x: 0, y: -kbSize.height + 100, width: view.frame.width, height: view.frame.height)
        view.frame = contentInsets
    }
    func keyboardWillBeHidden(_ aNotification: Notification?, view: UIView) {
        let contentInsets = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.frame = contentInsets
    }
    func resignKeyboardNotifications(controller: UIViewController) {
        NotificationCenter.default.removeObserver(controller, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(controller, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func addTapGesture(controller: UIViewController, view: UIView, selector: Selector?) {
        let tap = UITapGestureRecognizer(target: controller, action: selector)
        view.addGestureRecognizer(tap)
    }
}

func getData() -> [NameJson] {
    
    var arrays = [NameJson]()
    
    if let data = NSDataAsset(name: "dict_revised_1013")?.data {
        do {
            let decoder = JSONDecoder()
            let receiveData = try decoder.decode([NameJson].self, from: data)
            arrays = receiveData
        } catch {
            print(error)
        }
    }else{
        print("failed")
    }
    
    return arrays
}


func countName(lastName: String, firstName: String, arrays: [NameJson]) -> [NameData] {
    
    var nameDataArrays = [NameData]()
    
    func getWritingNum(word: String) -> Int {
        //找到字，找部首，加起來
        var returnNum = 0
        if let ind = arrays.firstIndex(where: { write in
            write.word == word
        }) {
            if arrays[ind].other == "0" {
                if Int(arrays[ind].total) != nil {
                    returnNum = Int(arrays[ind].total)!
                }
            }else{
                let baseWord = arrays[ind].base
                var first_num = 0
                var sec_num = 0
                if let index = arrays.firstIndex(where: { write_sec in
                    write_sec.word == baseWord
                }) {
                    if Int(arrays[ind].other) != nil {
                        first_num = Int(arrays[ind].other)!
                    }
                    if Int(arrays[index].total) != nil {
                        sec_num = Int(arrays[index].total)!
                    }
                    returnNum = first_num + sec_num
                }
            }
        }
        return returnNum
    }
    
    //how many words in it
    //3situations 2, 3, 4 words
    let lastCount = lastName.count
    let firstCount = firstName.count
    let count = lastCount + firstCount
    var firstWord: Character = "初"
    var firstWordNum = 1
    var secondWord: Character = "初"
    var secondWordNum = 1
    var thirdWord: Character = "初"
    var thirdWordNum = 1
    var fourthWord: Character = "初"
    var fourthWordNum = 1
    
    
    switch count {
    case 2:
//        let secIndex = name.index(after: name.startIndex)
        firstWord = "Ｏ"
//        secondWord = lastName.first!
//        thirdWord = firstName.first!
        fourthWord = "Ｏ"
        let sec_str = lastName
        let thi_str = firstName
        secondWordNum = getWritingNum(word: sec_str)
        thirdWordNum = getWritingNum(word: thi_str)
        nameDataArrays = [NameData(word: "Ｏ", writingNum: 1), NameData(word: sec_str, writingNum: secondWordNum), NameData(word: thi_str, writingNum: thirdWordNum), NameData(word: "Ｏ", writingNum: 1)]
    case 3:
        if lastCount == 2 { //複合姓氏
//            let secIndex = name.index(after: name.startIndex)
            firstWord = lastName.first!
            secondWord = lastName.last!
//            thirdWord = firstName.first!
//            fourthWord = "Ｏ"
            let first_str = String(firstWord)
            let sec_str = String(secondWord)
            let thi_str = firstName
            let fou_str = "Ｏ"
            firstWordNum = getWritingNum(word: first_str)
            secondWordNum = getWritingNum(word: sec_str)
            thirdWordNum = getWritingNum(word: thi_str)
//            fourthWordNum = getWritingNum(word: fou_str)
            nameDataArrays = [NameData(word: first_str, writingNum: firstWordNum), NameData(word: sec_str, writingNum: secondWordNum), NameData(word: thi_str, writingNum: thirdWordNum), NameData(word: fou_str, writingNum: fourthWordNum)]
        }else if firstCount == 2 {
//            let secIndex = name.index(after: name.startIndex)
            firstWord = "Ｏ"
//            secondWord = name.first!
            thirdWord = firstName.first!
            fourthWord = firstName.last!
            let sec_str = lastName
            let thi_str = String(thirdWord)
            let fou_str = String(fourthWord)
            secondWordNum = getWritingNum(word: sec_str)
            thirdWordNum = getWritingNum(word: thi_str)
            fourthWordNum = getWritingNum(word: fou_str)
            nameDataArrays = [NameData(word: "Ｏ", writingNum: 1), NameData(word: sec_str, writingNum: secondWordNum), NameData(word: thi_str, writingNum: thirdWordNum), NameData(word: fou_str, writingNum: fourthWordNum)]
        }
    case 4:
//        let secIndex = name.index(after: name.startIndex)
//        let thirdIndex = name.index(after: secIndex)
        firstWord = lastName.first!
        secondWord = lastName.last!
        thirdWord = firstName.first!
        fourthWord = firstName.last!
        let fir_str = String(firstWord)
        let sec_str = String(secondWord)
        let thi_str = String(thirdWord)
        let fou_str = String(fourthWord)
        firstWordNum = getWritingNum(word: fir_str)
        secondWordNum = getWritingNum(word: sec_str)
        thirdWordNum = getWritingNum(word: thi_str)
        fourthWordNum = getWritingNum(word: fou_str)
        nameDataArrays = [NameData(word: fir_str, writingNum: firstWordNum), NameData(word: sec_str, writingNum: secondWordNum), NameData(word: thi_str, writingNum: thirdWordNum), NameData(word: fou_str, writingNum: fourthWordNum)]
    default: break
    }
    
    return nameDataArrays
}

func fiveDoing(putIn: Int) -> String {
    var returnStr = ""
    let num = putIn%10
    switch num {
    case 1, 2: returnStr = "木"
    case 3, 4: returnStr = "火"
    case 5, 6: returnStr = "土"
    case 7, 8: returnStr = "金"
    case 9, 0: returnStr = "水"
    default:break
    }
    return returnStr
}


//⎡⎤⎣⎦⎜⎟△▲▽▼↓↑
func whatArrow(first: String, last: String) -> String {
    var returnStr = ""
    switch first {
    case "木":
        switch last {
        case "木": returnStr = "||"
        case "火": returnStr = "↓"
        case "土": returnStr = "▽"
        case "金": returnStr = "△"
        case "水": returnStr = "↑"
        default: break
        }
    case "火":
        switch last {
        case "木": returnStr = "↑"
        case "火": returnStr = "||"
        case "土": returnStr = "↓"
        case "金": returnStr = "▽"
        case "水": returnStr = "△"
        default: break
        }
    case "土":
        switch last {
        case "木": returnStr = "△"
        case "火": returnStr = "↑"
        case "土": returnStr = "||"
        case "金": returnStr = "↓"
        case "水": returnStr = "▽"
        default: break
        }
    case "金":
        switch last {
        case "木": returnStr = "▽"
        case "火": returnStr = "△"
        case "土": returnStr = "↑"
        case "金": returnStr = "||"
        case "水": returnStr = "↓"
        default: break
        }
    case "水":
        switch last {
        case "木": returnStr = "↓"
        case "火": returnStr = "▽"
        case "土": returnStr = "△"
        case "金": returnStr = "↑"
        case "水": returnStr = "||"
        default: break
        }
    default: break
    }
    
    
    return returnStr
}

// 81 / 12 / 11
func nowAgeAndPercent(birth: String) -> [Int] {        //percent
    let now = Date()
    let birthArrays = birth.components(separatedBy: " / ")
    //orignal
    guard birthArrays.count == 3 else { return [0] }
    if let year_bir = Int(birthArrays[0]), //81
       let month_bir = Int(birthArrays[1]), //12
       let date_bir = Int(birthArrays[2]) { //11
        let oriYear = 1911 + year_bir
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        let year = dateFormatter.string(from: now)
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: now)
        dateFormatter.dateFormat = "dd"
        let date = dateFormatter.string(from: now)
        if let yearInt = Int(year), //2022
           let monthInt = Int(month), //6
           let dateInt = Int(date) { //7
            print("now \(yearInt), bir \(year_bir)")
            var age = yearInt - oriYear + 1 //2022-1992=30
            //出生月份大於六
            if month_bir > 6 {
                let edgeNum = month_bir - 6
                if monthInt > edgeNum {
                    //現在日期 2022-6-7
                    let bigDay = "\(yearInt)-\(monthInt)-\(dateInt)"
                    //邊界日期 2022-6-11
                    let littleDay = "\(yearInt)-\(edgeNum)-\(date_bir)"
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    if let bigDate = dateFormatter.date(from: bigDay),
                       let littleDate = dateFormatter.date(from: littleDay) {
                        let bigNum = Int(bigDate.timeIntervalSince1970)
                        let littleNum = Int(littleDate.timeIntervalSince1970)
                        let gap = bigNum - littleNum
                        let gapDays = gap/60/60/24  //天數
                        let percent = lround(Double(gapDays)/365.0*100.0)
                        
                        return [age, percent]
                    }
                }else if monthInt < edgeNum {
                    age -= 1
                    
                    let bigDay = "\(yearInt)-\(monthInt)-\(dateInt)"
                    let littleDay = "\(yearInt-1)-\(edgeNum)-\(date_bir)"
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    if let bigDate = dateFormatter.date(from: bigDay),
                       let littleDate = dateFormatter.date(from: littleDay) {
                        let bigNum = Int(bigDate.timeIntervalSince1970)
                        let littleNum = Int(littleDate.timeIntervalSince1970)
                        let gap = bigNum - littleNum
                        let gapDays = gap/60/60/24  //天數
                        let percent = lround(Double(gapDays)/365.0*100.0)
                        
                        return [age, percent]
                    }
                }else{
                    //現在時間等於邊界月份時
                    if dateInt >= date_bir { //7, 11
                        let bigDay = "\(yearInt)-\(monthInt)-\(dateInt)"
                        let littleDay = "\(yearInt)-\(edgeNum)-\(date_bir)"
                        dateFormatter.dateFormat = "YYYY-MM-dd"
                        if let bigDate = dateFormatter.date(from: bigDay),
                           let littleDate = dateFormatter.date(from: littleDay) {
                            let bigNum = Int(bigDate.timeIntervalSince1970)
                            let littleNum = Int(littleDate.timeIntervalSince1970)
                            let gap = bigNum - littleNum
                            let gapDays = gap/60/60/24  //天數
                            let percent = lround(Double(gapDays)/365.0*100.0)
                            
                            return [age, percent]
                        }
                    }else{
                        //當生日日期比今天日期大的時候，代表歲數還沒加
                        age -= 1
                        let bigDay = "\(yearInt)-\(monthInt)-\(dateInt)"
                        let littleDay = "\(yearInt-1)-\(edgeNum)-\(date_bir)"
                        dateFormatter.dateFormat = "YYYY-MM-dd"
                        if let bigDate = dateFormatter.date(from: bigDay),
                           let littleDate = dateFormatter.date(from: littleDay) {
                            let bigNum = Int(bigDate.timeIntervalSince1970)
                            let littleNum = Int(littleDate.timeIntervalSince1970)
                            let gap = bigNum - littleNum
                            let gapDays = gap/60/60/24  //天數
                            let percent = lround(Double(gapDays)/365.0*100.0)
                            
                            return [age, percent]
                        }
                    }
                }
            }else{
                let edgeNum = month_bir + 6
                if monthInt > edgeNum {
                    age += 1
                    let bigDay = "\(yearInt)-\(monthInt)-\(dateInt)"
                    let littleDay = "\(yearInt)-\(edgeNum)-\(date_bir)"
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    if let bigDate = dateFormatter.date(from: bigDay),
                       let littleDate = dateFormatter.date(from: littleDay) {
                        let bigNum = Int(bigDate.timeIntervalSince1970)
                        let littleNum = Int(littleDate.timeIntervalSince1970)
                        let gap = bigNum - littleNum
                        let gapDays = gap/60/60/24  //天數
                        let percent = lround(Double(gapDays)/365.0*100.0)
                        
                        return [age, percent]
                    }
                }else if monthInt < edgeNum {
                    let bigDay = "\(yearInt)-\(monthInt)-\(dateInt)"
                    let littleDay = "\(yearInt-1)-\(edgeNum)-\(date_bir)"
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    if let bigDate = dateFormatter.date(from: bigDay),
                       let littleDate = dateFormatter.date(from: littleDay) {
                        let bigNum = Int(bigDate.timeIntervalSince1970)
                        let littleNum = Int(littleDate.timeIntervalSince1970)
                        let gap = bigNum - littleNum
                        let gapDays = gap/60/60/24  //天數
                        let percent = lround(Double(gapDays)/365.0*100.0)
                        
                        return [age, percent]
                    }
                }else{
                    if dateInt >= date_bir {
                        age += 1
                        let bigDay = "\(yearInt)-\(monthInt)-\(dateInt)"
                        let littleDay = "\(yearInt)-\(edgeNum)-\(date_bir)"
                        dateFormatter.dateFormat = "YYYY-MM-dd"
                        if let bigDate = dateFormatter.date(from: bigDay),
                           let littleDate = dateFormatter.date(from: littleDay) {
                            let bigNum = Int(bigDate.timeIntervalSince1970)
                            let littleNum = Int(littleDate.timeIntervalSince1970)
                            let gap = bigNum - littleNum
                            let gapDays = gap/60/60/24  //天數
                            let percent = lround(Double(gapDays)/365.0*100.0)
                            
                            return [age, percent]
                        }
                    }else{
                        let bigDay = "\(yearInt)-\(monthInt)-\(dateInt)"
                        let littleDay = "\(yearInt-1)-\(edgeNum)-\(date_bir)"
                        dateFormatter.dateFormat = "YYYY-MM-dd"
                        if let bigDate = dateFormatter.date(from: bigDay),
                           let littleDate = dateFormatter.date(from: littleDay) {
                            let bigNum = Int(bigDate.timeIntervalSince1970)
                            let littleNum = Int(littleDate.timeIntervalSince1970)
                            let gap = bigNum - littleNum
                            let gapDays = gap/60/60/24  //天數
                            let percent = lround(Double(gapDays)/365.0*100.0)
                            
                            return [age, percent]
                        }
                    }
                }
            }
        }
    }
    return [0]
}

func circleWhere(agePercent: [Int], startNum: Int, yearArrays: [String]) -> TimeAndDegree {
    
    if yearArrays.count < 10 {
        return TimeAndDegree(yearName: "", degree: 0)
    }
    let startDegree = 180
    let position = agePercent[0] - startNum
    var newStart = startDegree
    let degreeArray = [30, 45, 60]
    if position == 0 {
        let degree = 45 * agePercent[1] / 100
        let positionDegree = startDegree + degree
        return TimeAndDegree(yearName: yearArrays[0], degree: positionDegree) //冠帶為[0]

    }else if position > 0 {
        
        switch position {
        case 1:
            newStart += degreeArray[1] //45
            let degree = degreeArray[1] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[1], degree: positionDegree)
        case 2:
            newStart += 90
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[2], degree: positionDegree)
        case 3:
            newStart += 120
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[3], degree: positionDegree)
        case 4:
            newStart += 150
            let degree = degreeArray[2] * agePercent[1] / 100
            var positionDegree = newStart + degree
            if positionDegree > 360 {
                positionDegree -= 360
            }
            return TimeAndDegree(yearName: yearArrays[4], degree: positionDegree)
        case 5:
            newStart = newStart + 210 - 360
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[5], degree: positionDegree)
        case 6:
            newStart = newStart + 240 - 360
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[6], degree: positionDegree)
        case 7:
            newStart = newStart + 270 - 360
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[7], degree: positionDegree)
        case 8:
            newStart = newStart + 300 - 360
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[8], degree: positionDegree)
        case 9:
            newStart = newStart + 330 - 360
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[9], degree: positionDegree)
        default: break
        }
    }else if position < 0 {
        let otherPosition = -1 * position
        switch otherPosition {
        case 1:
            newStart -= degreeArray[0] //30
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[9], degree: positionDegree)
        case 2:
            newStart -= 60
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[8], degree: positionDegree)
        case 3:
            newStart -= 90
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[7], degree: positionDegree)
        case 4:
            newStart -= 120
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[6], degree: positionDegree)
        case 5:
            newStart -= 150
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[5], degree: positionDegree)
        case 6:
            newStart -= 210
            let degree = degreeArray[2] * agePercent[1] / 100  //60
            var positionDegree = newStart + degree
            if positionDegree < 0 {
                positionDegree += 360
            }
            return TimeAndDegree(yearName: yearArrays[4], degree: positionDegree)
        case 7:
            newStart = newStart - 240 + 360
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[3], degree: positionDegree)
        case 8:
            newStart = newStart - 270 + 360
            let degree = degreeArray[0] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[2], degree: positionDegree)
        case 9:
            newStart = newStart - 315 + 360
            let degree = degreeArray[1] * agePercent[1] / 100
            let positionDegree = newStart + degree
            return TimeAndDegree(yearName: yearArrays[1], degree: positionDegree)
        default: break
        }
    }
    
    return TimeAndDegree(yearName: "", degree: 0)
}

//婚姻宮計算
func marriageNumCalculate(diseaseNum: Int, friendNum: Int) -> [String] {
    
    var upNum = diseaseNum/10 + diseaseNum%10
    if upNum > 10 {
        upNum -= 10
    }else if upNum == 10 {
        upNum = 1
    }
    var downNum = friendNum/10 + friendNum%10
    if downNum > 10 {
        downNum -= 10
    }else if downNum == 10 {
        downNum = 1
    }
    let up = fiveDoing(putIn: upNum)
    let down = fiveDoing(putIn: downNum)
    let arrow = whatArrow(first: up, last: down)
    
    return ["\(upNum) \(up)", arrow, "\(downNum) \(down)"]
}
