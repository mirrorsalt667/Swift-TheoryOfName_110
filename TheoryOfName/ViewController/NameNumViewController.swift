//
//  NameNumViewController.swift
//  TheoryOfName
//
//  Created on 2021/11/7.
//⎡⎤⎣⎦⎜⎟△▲▽▼↓↑

import UIKit

class NameNumViewController: UIViewController {

    let style = itemStyle()
    //必傳資料
    var firstName = ""
    var lastName = ""
    var birthdate = ""
    var showKind = 0
    
    var tailNum = 0
    var row: Int?
    var nameArrays = [NameRecords]()
    
    var arrays = [NameJson]()
    var diseaseNum: Int = 0
    var friendsNum: Int = 0
    var totalNameNum: Int = 0
    
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
    
    @IBOutlet weak var backFontButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var workOnButton: UIButton!
    @IBOutlet weak var waterMoveButton: UIButton!
    @IBOutlet weak var personalityButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var segueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sizeAndPosition()
        arrays = getData()
        
        DispatchQueue.main.async {
            self.calcuate()
            self.outlook()
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func waterMovingButton(_ sender: Any) {
        
        performSegue(withIdentifier: "ToWaterMovingSegue", sender: nil)
    }
    @IBAction func saveButton(_ sender: Any) {
        if showKind == 0 {
            var nameListArrays = [NameRecords]()
            let saveYet = NameRecords(lastName: self.lastName, firstName: self.firstName, birthday: self.birthdate, diseaseNum: self.diseaseNum, friendsNum: self.friendsNum, totalNameNum: self.totalNameNum)
            let property = PropertyListEncoder()
            let property_decoder = PropertyListDecoder()
            let documentDirectury = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
            let url = documentDirectury.appendingPathComponent("nameRecord")
            //check old data first
            if let data = try? Data(contentsOf: url),
               let receive = try? property_decoder.decode([NameRecords].self, from: data) {
                nameListArrays = receive
            }
            nameListArrays.append(saveYet)
            if let data = try? property.encode(nameListArrays) {
                let url = documentDirectury.appendingPathComponent("nameRecord")
                try? data.write(to: url)
            }
        }else if showKind == 1 {
            //確定刪除？
            let alert = UIAlertController(title: "確定刪除？", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "確定", style: .default, handler: nil)
            let alertCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(alertCancel)
            alert.addAction(alertAction)
            self.present(alert, animated: true) {
                self.deleteName()
                self.performSegue(withIdentifier: "UnwindToNameList", sender: nil)
//
            }
            
//            if let controller = self.navigationController?.popViewController(animated: true) as? NameListViewController {
//                controller.nameListArrays = self.nameArrays
//                controller.nameListTableView.reloadData()
//                print("worked")
//            }
        }
    }
    
    
   
    
    func calcuate() {
        //先算筆畫 取數字 算五行 生剋平
        let nameArrays = countName(lastName: lastName, firstName: firstName, arrays: arrays)
        
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
        
        
        //匯出數字
        //疾厄宮
        self.diseaseNum = diseaseNum
        //奴僕宮
        self.friendsNum = friendsNum
        //總格
        self.totalNameNum = totalNum
        
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
        }else if upText == "||" {
            upBetweenLabel.textColor = itemStyle.color.init().wordColor
        }else{
            upBetweenLabel.textColor = UIColor.black
        }
        downBetweenLabel.text = downText
        if downText == "▽" || downText == "△" {
            downBetweenLabel.textColor = UIColor.red
        }else if downText == "||" {
            downBetweenLabel.textColor = itemStyle.color.init().wordColor
        }else{
            downBetweenLabel.textColor = UIColor.black
        }
        birthdateLabel.text = "出生日期：" + birthdate
    }
    func showBigOLabel(label: UILabel, show: String) {
        label.text = show
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 60)
        if show == "Ｏ"{
            label.textColor = UIColor.gray
        }else{
            label.textColor = itemStyle.color.init().dark_green
        }
    }
    
    func deleteName() {
        if let indexPath = row {
            nameArrays.remove(at: indexPath)
            //save
            let property = PropertyListEncoder()
            let documentDirectury = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
            if let data = try? property.encode(nameArrays) {
                let url = documentDirectury.appendingPathComponent("nameRecord")
                try? data.write(to: url)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ToWaterMovingSegue":
            if let controller = segue.destination as? WaterMovingViewController {
                
                controller.name = "\(self.lastName)\(self.firstName)"
                controller.birthday = self.birthdate
                controller.tailNum = self.tailNum
                print("傳送的資料\(controller.name), \(controller.birthday), \(controller.tailNum)")
                
            }
        default: break
            
        }
    }
    
    
    
}






//MARK: -outlook
extension NameNumViewController {
    func sizeAndPosition() {
        let width = self.view.frame.width
        //        let height = self.view.frame.height
        let margins = birthdateLabel.superview!.layoutMarginsGuide
        //        let tenOneHeight = height/4
        let twoOneWidth = width/2
        
        backFontButton.translatesAutoresizingMaskIntoConstraints = false
        backFontButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
        backFontButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        backFontButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        backFontButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
        backButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
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
        
        workOnButton.translatesAutoresizingMaskIntoConstraints = false
        workOnButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -twoOneWidth/2).isActive = true
        workOnButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -15).isActive = true
        workOnButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        workOnButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        waterMoveButton.translatesAutoresizingMaskIntoConstraints = false
        waterMoveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        waterMoveButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -15).isActive = true
        waterMoveButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        waterMoveButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        personalityButton.translatesAutoresizingMaskIntoConstraints = false
        personalityButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: twoOneWidth/2).isActive = true
        personalityButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -15).isActive = true
        personalityButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        personalityButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: waterMoveButton.centerXAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: waterMoveButton.topAnchor, constant: -15).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 85).isActive = true
    }
    func outlook() {
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
        saveButton.layer.borderColor = itemStyle.color.init().dark_green.cgColor
        saveButton.layer.borderWidth = 2
        if showKind == 0 {
            saveButton.setTitle("儲存", for: .normal)
        }else if showKind == 1 {
            saveButton.setTitle("刪除", for: .normal)
        }
        saveButton.setTitleColor(itemStyle.color.init().dark_green, for: .normal)
        segueButton.isHidden = true
    }
}
