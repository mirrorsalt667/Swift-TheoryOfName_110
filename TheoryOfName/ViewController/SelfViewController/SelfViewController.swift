//
//  SelfViewController.swift
//  TheoryOfName
//
//  Created by on 2021/12/10.
//

//MARK: 自己的姓名資料

import UIKit

class SelfViewController: UIViewController {
    
    let style = itemStyle()
    //必傳4項資料
//    var firstName = ""
//    var lastName = ""
//    var birthdate = ""
    
    var tailNum = 0
    var arrays = [NameJson]()
    var myName: SelfNameRecord?
    var newOrNotBool = false
    
    // 思想功能
    private var mBrain: String = ""
    // 行動功能
    private var mAction: String = ""
    
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var movingNumLabel: UILabel!
    @IBOutlet weak var movingFive_eleLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameNumLabel: UILabel!
    @IBOutlet weak var secNameLabel: UILabel!
    @IBOutlet weak var secNameNumLabel: UILabel!
    @IBOutlet weak var thirdNameLabel: UILabel!
    @IBOutlet weak var thirdNameNumLabel: UILabel!
    @IBOutlet weak var fourNameLabel: UILabel!
    @IBOutlet weak var fourNameNumLabel: UILabel!
    @IBOutlet weak var parentsNumLabel: UILabel!
    @IBOutlet weak var parentsFive_eleLabel: UILabel!
    @IBOutlet weak var diseaseNumLabel: UILabel!
    @IBOutlet weak var diseaseFive_eleLabel: UILabel!
    @IBOutlet weak var friendsNumLabel: UILabel!
    @IBOutlet weak var friendsFive_eleLabel: UILabel!
    @IBOutlet weak var upBetweenLabel: UILabel!
    @IBOutlet weak var downBetweenLabel: UILabel!
    @IBOutlet weak var underLine: UILabel!
    @IBOutlet weak var totalNumLabel: UILabel!
    @IBOutlet weak var totalFive_eleLabel: UILabel!
    
    @IBOutlet weak var marriageView: UIView!
    @IBOutlet weak var marriageUpLabel: UILabel!
    @IBOutlet weak var marriageBetweenLabel: UILabel!
    @IBOutlet weak var marriageDownLabel: UILabel!
    
    
    @IBOutlet weak var backFontButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var workOnButton: UIButton!
    @IBOutlet weak var waterMoveButton: UIButton!
    @IBOutlet weak var personalityButton: UIButton!
    @IBOutlet weak var changeNameButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrays = getData()
        
        DispatchQueue.main.async {
            guard let name = self.myName else { return }
            self.calcuate(nameDetails: name)
            self.outlook()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeAndPosition()
        workOnButton.isHidden = true
        changeNameButton.isHidden = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func waterMovingButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "WaterMovingViewController") as? WaterMovingViewController {
            guard let names = self.myName else { return }
            vc.name = "\(names.lastName)\(names.firstName)"
            vc.birthday = names.birthday
            vc.tailNum = self.tailNum
            self.present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func toBrainTabBarViewAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "BrainTabViewController") as? BrainTabBarViewController {
            self.present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func changeNameAction(_ sender: Any) {
        
    }
    
    // 儲存姓名
    func saveMyName(name: SelfNameRecord) {
        let document = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        let url = document.appendingPathComponent("MyName")
        let encoder = PropertyListEncoder()
        let data = try? encoder.encode(name)
        if let _ = try? data?.write(to: url) {
            print("save success, \(name)")
        }
    }
    
    
    
    
    func calcuate(nameDetails: SelfNameRecord) {
        //先算筆畫 取數字 算五行 生剋平
        let nameArrays = countName(lastName: nameDetails.lastName, firstName: nameDetails.firstName, arrays: arrays)
        
        let firstNum = nameArrays[0].writingNum
        let secNum = nameArrays[1].writingNum
        let thirdNum = nameArrays[2].writingNum
        let fourthNum = nameArrays[3].writingNum
        
        let movingNum = firstNum + fourthNum
        let parentNum = firstNum + secNum
        let diseaseNum = secNum + thirdNum
        let friendsNum = thirdNum + fourthNum
        var totalNum = 0
        
        if firstNum == 1 && fourthNum == 1 {
            totalNum = secNum + thirdNum
        }else if firstNum == 1 && fourthNum != 1{
            totalNum = secNum + thirdNum + fourthNum
        }else if firstNum != 1 && fourthNum == 1{
            totalNum = firstNum + secNum + thirdNum
        }else{
            totalNum = firstNum + secNum + thirdNum + fourthNum
        }
        
        let numArrays: [Int] = [movingNum, parentNum, diseaseNum, friendsNum, totalNum]
        var fiveArrays: [String] = []
        
        for k in 0...4 {
            fiveArrays.append(fiveDoing(putIn: numArrays[k]))
        }
        let upText = whatArrow(first: fiveArrays[1], last: fiveArrays[2])
        let downText = whatArrow(first: fiveArrays[2], last: fiveArrays[3])
        
        
        //匯出資料、儲存
        if newOrNotBool == true {
            self.myName?.num.movingNum = movingNum
            self.myName?.num.parentsNum = parentNum
            self.myName?.num.diseaseNum = diseaseNum
            self.myName?.num.friendsNum = friendsNum
            self.myName?.num.totalNameNum = totalNum
            guard let names = myName else { return }
            saveMyName(name: names)
        }
        
        //取尾數 減掉３
        tailNum = totalNum%10
        tailNum -= 3
        if tailNum < 0 {
            tailNum += 10
        }
        
        
//        firstNameLabel.text = nameArrays[0].word
        showBigOLabel(label: firstNameLabel, show: nameArrays[0].word)
        firstNameNumLabel.text = String(firstNum)
//        secNameLabel.text = nameArrays[1].word
        showBigOLabel(label: secNameLabel, show: nameArrays[1].word)
        secNameNumLabel.text = String(secNum)
//        thirdNameLabel.text = nameArrays[2].word
        showBigOLabel(label: thirdNameLabel, show: nameArrays[2].word)
        thirdNameNumLabel.text = String(thirdNum)
//        fourNameLabel.text = nameArrays[3].word
        showBigOLabel(label: fourNameLabel, show: nameArrays[3].word)
        fourNameNumLabel.text = String(fourthNum)
        movingNumLabel.text = String(movingNum)
        movingFive_eleLabel.text = fiveArrays[0]
        parentsNumLabel.text = String(parentNum)
        parentsFive_eleLabel.text = fiveArrays[1]
        diseaseNumLabel.text = String(diseaseNum)
        diseaseFive_eleLabel.text = fiveArrays[2]
        friendsNumLabel.text = String(friendsNum)
        friendsFive_eleLabel.text = fiveArrays[3]
        totalNumLabel.text = String(totalNum)
        totalFive_eleLabel.text = fiveArrays[4]
        upBetweenLabel.text = upText
        if upText == "▽" || upText == "△" {
            upBetweenLabel.textColor = UIColor.red
            switch upText {
            case "△": mBrain = "\(fiveArrays[2])剋\(fiveArrays[1])"
            case "▽": mBrain = "\(fiveArrays[1])剋\(fiveArrays[2])"
            default: break
            }
        }else if upText == "||" {
            upBetweenLabel.textColor = itemStyle.color.init().wordColor
            mBrain = "\(fiveArrays[0])平宮"
        }else{
            upBetweenLabel.textColor = UIColor.black
            switch upText {
            case "↓": mBrain = "\(fiveArrays[1])生\(fiveArrays[2])"
            case "↑": mBrain = "\(fiveArrays[2])生\(fiveArrays[1])"
            default: break
            }
        }
        downBetweenLabel.text = downText
        if downText == "▽" || downText == "△" {
            downBetweenLabel.textColor = UIColor.red
            switch downText {
            case "△": mAction = "\(fiveArrays[3])剋\(fiveArrays[2])"
            case "▽": mAction = "\(fiveArrays[2])剋\(fiveArrays[3])"
            default: break
            }
        }else if downText == "||" {
            downBetweenLabel.textColor = itemStyle.color.init().wordColor
            mAction = "\(fiveArrays[2])平宮"
        }else{
            downBetweenLabel.textColor = UIColor.black
            switch downText {
            case "↓": mAction = "\(fiveArrays[2])生\(fiveArrays[3])"
            case "↑": mAction = "\(fiveArrays[3])生\(fiveArrays[2])"
            default: break
            }
        }
        guard let names = myName else { return }
        birthdateLabel.text = "出生日期：" + names.birthday
        
        //傳至全域
        gBrainCharacter = mBrain
        gActionCharacter = mAction
        gTotalNameNum = totalNum
    }
    // 無字時出現大Ｏ
    private func showBigOLabel(label: UILabel, show: String) {
        label.text = show
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 60)
        if show == "Ｏ"{
            label.textColor = UIColor.gray
        }else{
            label.textColor = itemStyle.color.init().dark_green
        }
    }
    
    
    
}




//MARK: - outlook & Layout
extension SelfViewController {
    private func sizeAndPosition() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        let margins = birthdateLabel.superview!.layoutMarginsGuide
//        let tenOneHeight = height/4
        let twoOneWidth = width/2
        
        let topButtonHeight: CGFloat = 56
        backFontButton.translatesAutoresizingMaskIntoConstraints = false
        backFontButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        backFontButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        backFontButton.widthAnchor.constraint(equalToConstant: topButtonHeight).isActive = true
        backFontButton.heightAnchor.constraint(equalToConstant: topButtonHeight).isActive = true
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        backButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: topButtonHeight).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: topButtonHeight).isActive = true
        
        birthdateLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdateLabel.topAnchor.constraint(equalTo: backFontButton.bottomAnchor, constant: 15).isActive = true
        birthdateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.topAnchor.constraint(equalTo: birthdateLabel.bottomAnchor, constant: 15).isActive = true
        firstNameNumLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameNumLabel.centerYAnchor.constraint(equalTo: firstNameLabel.centerYAnchor).isActive = true
        firstNameNumLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        firstNameNumLabel.widthAnchor.constraint(equalToConstant: 26).isActive = true
        firstNameLabel.trailingAnchor.constraint(equalTo: firstNameNumLabel.leadingAnchor, constant: -15).isActive = true
        
        secNameLabel.translatesAutoresizingMaskIntoConstraints = false
        secNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 15).isActive = true
        secNameNumLabel.translatesAutoresizingMaskIntoConstraints = false
        secNameNumLabel.centerYAnchor.constraint(equalTo: secNameLabel.centerYAnchor).isActive = true
        secNameNumLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        secNameNumLabel.widthAnchor.constraint(equalToConstant: 26).isActive = true
        secNameLabel.trailingAnchor.constraint(equalTo: secNameNumLabel.leadingAnchor, constant: -15).isActive = true
        
        thirdNameLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdNameLabel.topAnchor.constraint(equalTo: secNameLabel.bottomAnchor, constant: 15).isActive = true
        thirdNameNumLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdNameNumLabel.centerYAnchor.constraint(equalTo: thirdNameLabel.centerYAnchor).isActive = true
        thirdNameNumLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        thirdNameNumLabel.widthAnchor.constraint(equalToConstant: 26).isActive = true
        thirdNameLabel.trailingAnchor.constraint(equalTo: thirdNameNumLabel.leadingAnchor, constant: -15).isActive = true
        
        fourNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fourNameLabel.topAnchor.constraint(equalTo: thirdNameLabel.bottomAnchor, constant: 15).isActive = true
        fourNameNumLabel.translatesAutoresizingMaskIntoConstraints = false
        fourNameNumLabel.centerYAnchor.constraint(equalTo: fourNameLabel.centerYAnchor).isActive = true
        fourNameNumLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        fourNameNumLabel.widthAnchor.constraint(equalToConstant: 26).isActive = true
        fourNameLabel.trailingAnchor.constraint(equalTo: fourNameNumLabel.leadingAnchor, constant: -15).isActive = true
        
        movingFive_eleLabel.translatesAutoresizingMaskIntoConstraints = false
        movingFive_eleLabel.centerYAnchor.constraint(equalTo: secNameLabel.bottomAnchor, constant: 7.5).isActive = true
        movingFive_eleLabel.trailingAnchor.constraint(equalTo: secNameLabel.leadingAnchor, constant: -15).isActive = true
        
        movingNumLabel.translatesAutoresizingMaskIntoConstraints = false
        movingNumLabel.centerYAnchor.constraint(equalTo: movingFive_eleLabel.centerYAnchor).isActive = true
        movingNumLabel.trailingAnchor.constraint(equalTo: movingFive_eleLabel.leadingAnchor).isActive = true
        
        parentsNumLabel.translatesAutoresizingMaskIntoConstraints = false
        parentsNumLabel.centerYAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 7.5).isActive = true
        parentsNumLabel.leadingAnchor.constraint(equalTo: firstNameNumLabel.trailingAnchor, constant: 15).isActive = true
        parentsNumLabel.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        parentsFive_eleLabel.translatesAutoresizingMaskIntoConstraints = false
        parentsFive_eleLabel.centerYAnchor.constraint(equalTo: parentsNumLabel.centerYAnchor).isActive = true
        parentsFive_eleLabel.leadingAnchor.constraint(equalTo: parentsNumLabel.trailingAnchor).isActive = true
        
        diseaseNumLabel.translatesAutoresizingMaskIntoConstraints = false
        diseaseNumLabel.centerYAnchor.constraint(equalTo: secNameLabel.bottomAnchor, constant: 7.5).isActive = true
        diseaseNumLabel.leadingAnchor.constraint(equalTo: secNameNumLabel.trailingAnchor, constant: 15).isActive = true
        diseaseNumLabel.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        diseaseFive_eleLabel.translatesAutoresizingMaskIntoConstraints = false
        diseaseFive_eleLabel.centerYAnchor.constraint(equalTo: diseaseNumLabel.centerYAnchor).isActive = true
        diseaseFive_eleLabel.leadingAnchor.constraint(equalTo: diseaseNumLabel.trailingAnchor).isActive = true
        
        friendsNumLabel.translatesAutoresizingMaskIntoConstraints = false
        friendsNumLabel.centerYAnchor.constraint(equalTo: thirdNameLabel.bottomAnchor, constant: 7.5).isActive = true
        friendsNumLabel.leadingAnchor.constraint(equalTo: thirdNameNumLabel.trailingAnchor, constant: 15).isActive = true
        friendsNumLabel.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        friendsFive_eleLabel.translatesAutoresizingMaskIntoConstraints = false
        friendsFive_eleLabel.centerYAnchor.constraint(equalTo: friendsNumLabel.centerYAnchor).isActive = true
        friendsFive_eleLabel.leadingAnchor.constraint(equalTo: friendsNumLabel.trailingAnchor).isActive = true
        
        upBetweenLabel.translatesAutoresizingMaskIntoConstraints = false
        upBetweenLabel.centerXAnchor.constraint(equalTo: parentsNumLabel.trailingAnchor).isActive = true
        upBetweenLabel.centerYAnchor.constraint(equalTo: secNameNumLabel.centerYAnchor).isActive = true
        
        downBetweenLabel.translatesAutoresizingMaskIntoConstraints = false
        downBetweenLabel.centerXAnchor.constraint(equalTo: parentsNumLabel.trailingAnchor).isActive = true
        downBetweenLabel.centerYAnchor.constraint(equalTo: thirdNameNumLabel.centerYAnchor).isActive = true
        
        underLine.translatesAutoresizingMaskIntoConstraints = false
        underLine.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        underLine.topAnchor.constraint(equalTo: fourNameLabel.bottomAnchor, constant: 20).isActive = true
        
        totalNumLabel.translatesAutoresizingMaskIntoConstraints = false
        totalNumLabel.centerXAnchor.constraint(equalTo: firstNameLabel.centerXAnchor).isActive = true
        totalNumLabel.topAnchor.constraint(equalTo: underLine.bottomAnchor, constant: 15).isActive = true
        totalNumLabel.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        totalFive_eleLabel.translatesAutoresizingMaskIntoConstraints = false
        totalFive_eleLabel.leadingAnchor.constraint(equalTo: totalNumLabel.trailingAnchor).isActive = true
        totalFive_eleLabel.centerYAnchor.constraint(equalTo: totalNumLabel.centerYAnchor).isActive = true
        
        //三個的基準
        let bottomButtonWidth: CGFloat = 100
        workOnButton.translatesAutoresizingMaskIntoConstraints = false
        workOnButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -twoOneWidth/2).isActive = true
        workOnButton.topAnchor.constraint(equalTo: totalNumLabel.bottomAnchor, constant: height/66).isActive = true
        workOnButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        workOnButton.widthAnchor.constraint(equalToConstant: bottomButtonWidth).isActive = true
        
        waterMoveButton.translatesAutoresizingMaskIntoConstraints = false
//        waterMoveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        waterMoveButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        waterMoveButton.centerYAnchor.constraint(equalTo: workOnButton.centerYAnchor).isActive = true
        waterMoveButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        waterMoveButton.widthAnchor.constraint(equalToConstant: bottomButtonWidth).isActive = true
        
        personalityButton.translatesAutoresizingMaskIntoConstraints = false
//        personalityButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: twoOneWidth/2).isActive = true
        personalityButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10).isActive = true
        personalityButton.centerYAnchor.constraint(equalTo: workOnButton.centerYAnchor).isActive = true
        personalityButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        personalityButton.widthAnchor.constraint(equalToConstant: bottomButtonWidth).isActive = true

        changeNameButton.translatesAutoresizingMaskIntoConstraints = false
        changeNameButton.centerXAnchor.constraint(equalTo: workOnButton.centerXAnchor).isActive = true
        changeNameButton.topAnchor.constraint(equalTo: workOnButton.bottomAnchor, constant: height/45).isActive = true
        changeNameButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10).isActive = true
        changeNameButton.widthAnchor.constraint(equalToConstant: bottomButtonWidth).isActive = true
        
        marriageView.translatesAutoresizingMaskIntoConstraints = false
        marriageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        marriageView.heightAnchor.constraint(equalToConstant: 114).isActive = true
        marriageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
        marriageView.bottomAnchor.constraint(equalTo: underLine.topAnchor, constant: -15).isActive = true
        
        marriageUpLabel.translatesAutoresizingMaskIntoConstraints = false
        marriageUpLabel.centerXAnchor.constraint(equalTo: marriageView.centerXAnchor).isActive = true
        marriageUpLabel.topAnchor.constraint(equalTo: marriageView.topAnchor, constant: 7).isActive = true
        
        marriageBetweenLabel.translatesAutoresizingMaskIntoConstraints = false
        marriageBetweenLabel.centerXAnchor.constraint(equalTo: marriageView.centerXAnchor).isActive = true
        marriageBetweenLabel.topAnchor.constraint(equalTo: marriageUpLabel.bottomAnchor, constant: 18).isActive = true
        
        marriageDownLabel.translatesAutoresizingMaskIntoConstraints = false
        marriageDownLabel.centerXAnchor.constraint(equalTo: marriageView.centerXAnchor).isActive = true
        marriageDownLabel.bottomAnchor.constraint(equalTo: marriageView.bottomAnchor, constant: -7).isActive = true
    }
    
    // 元件外觀及顯示文字
    private func outlook() {
        self.view.layer.backgroundColor = itemStyle.color.init().light_brown.cgColor
        style.topButton(backFontButton, title: "首頁")
        style.topButton(backButton, title: "返回")
        birthdateLabel.textColor = UIColor.black
        birthdateLabel.font = UIFont.systemFont(ofSize: 18)
        func nameNumStyle(label: UILabel) {
            label.textColor = itemStyle.color.init().wordColor
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20)
        }
        nameNumStyle(label: firstNameNumLabel)
        nameNumStyle(label: secNameNumLabel)
        nameNumStyle(label: thirdNameNumLabel)
        nameNumStyle(label: fourNameNumLabel)
        
        style.brownButton(workOnButton, title: "發動")
        style.brownButton(waterMoveButton, title: "流年")
        style.brownButton(personalityButton, title: "性格")
        changeNameButton.layer.borderColor = itemStyle.color.init().dark_green.cgColor
        changeNameButton.layer.borderWidth = 2
        changeNameButton.setTitle("改名字", for: .normal)
        changeNameButton.setTitleColor(itemStyle.color.init().dark_green, for: .normal)
        
        marriageUpLabel.textColor = itemStyle.color.init().light_brown
        marriageBetweenLabel.textColor = itemStyle.color.init().light_brown
        marriageDownLabel.textColor = itemStyle.color.init().light_brown
        
        marriageView.layer.backgroundColor = itemStyle.color.init().dark_green.cgColor
        marriageView.layer.shadowRadius = 5
        marriageView.layer.shadowColor = itemStyle.color.init().dove_gray.cgColor
        marriageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        marriageView.layer.shadowOpacity = 0.7
        
        guard let name = myName else { return }
        let marriageArrays = marriageNumCalculate(diseaseNum: name.num.diseaseNum, friendNum: name.num.friendsNum)
        marriageUpLabel.text = marriageArrays[0]
        marriageBetweenLabel.text = marriageArrays[1]
        marriageDownLabel.text = marriageArrays[2]
        if marriageArrays[1] == "▽" || marriageArrays[1] == "△" {
            marriageBetweenLabel.textColor = UIColor.red
        }else if marriageArrays[1] == "||" {
            marriageBetweenLabel.textColor = itemStyle.color.init().light_brown
        }else{
            marriageBetweenLabel.textColor = UIColor.white
        }
    }
}
