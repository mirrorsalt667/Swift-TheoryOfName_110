//
//  WaterMovingViewController.swift
//  TheoryOfName
//
//  Created on 2021/11/27.

//  MARK: 流年

import UIKit

final class WaterMovingViewController: UIViewController {

    private let style = itemStyle()
    
    let path = UIBezierPath()
    let shape = CAShapeLayer()
    var birthday = ""
    var name = ""
    var tailNum = 0
    
    
    @IBOutlet weak var backFontButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBOutlet weak var beginingLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fivethLabel: UILabel!
    @IBOutlet weak var sixthLabel: UILabel!
    @IBOutlet weak var seventhLabel: UILabel!
    @IBOutlet weak var eighthLabel: UILabel!
    @IBOutlet weak var ninethLabel: UILabel!
    @IBOutlet weak var tenthLabel: UILabel!
    
    @IBOutlet weak var bottomTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ageAndPercent = nowAgeAndPercent(birth: birthday)
        let age = ageAndPercent[0]
        print(ageAndPercent)
        codingLayout()
        outlook()
        drawATen()
        position(agePercent: ageAndPercent)
        labelShow(age: age)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //中間的十字
    func drawATen() {
        let width = self.view.frame.size.width
//        let height = self.view.frame.size.height
        let lineLenght = CGFloat(width - 180)
        let heightFromTop = CGFloat(250)
        
        path.move(to: CGPoint(x: width/2, y: heightFromTop))
        path.addLine(to: CGPoint(x: width/2, y: lineLenght + heightFromTop))
        
        shape.lineCap = .round
        shape.path = path.cgPath
        shape.strokeColor = UIColor.brown.cgColor
        shape.lineWidth = 4
        self.view.layer.addSublayer(shape)
        
        path.move(to: CGPoint(x: width/2-lineLenght/2, y: heightFromTop+lineLenght/2))
        path.addLine(to: CGPoint(x: self.view.frame.midX+lineLenght/2, y: heightFromTop+lineLenght/2))
        
        shape.path = path.cgPath
        self.view.layer.addSublayer(shape)
    }
    
    func drawCircle(Degree: CGFloat) {
        let width = self.view.frame.size.width
        let lineLenght = CGFloat(width - 180)
        let heightFromTop = CGFloat(250)
        let aDegree = CGFloat.pi/180

        let degreePlus = Degree + CGFloat(2)
        let circle = UIBezierPath(arcCenter: CGPoint(x: width/2, y: heightFromTop+lineLenght/2), radius: lineLenght/4, startAngle: aDegree*Degree, endAngle: aDegree*degreePlus, clockwise: true)
//        let circle = UIBezierPath(ovalIn: CGRect(x: width/2, y: heightFromTop+lineLenght/2, width: lineLenght, height: lineLenght))
        
        
        let circelLayer = CAShapeLayer()
        circelLayer.path = circle.cgPath
        circelLayer.lineWidth = lineLenght/2
        circelLayer.fillColor = UIColor.blue.cgColor
        circelLayer.strokeColor = UIColor.orange.cgColor
//        circelLayer.lineCap = .round
        
        
        self.view.layer.addSublayer(circelLayer)
    }
    
    func position(agePercent: [Int]) {
        
        var nowDegree:CGFloat = 0
        
        let width = self.view.frame.size.width
//        let height = self.view.frame.size.height
        let toTheSide = CGFloat(90)
        let lineWidth = CGFloat(width - toTheSide*2)
        let heightFromTop = CGFloat(250)
//        let margins = titleLabel.superview!.layoutMarginsGuide
        let betweenH = CGFloat(30)
//        let betweenV = CGFloat(50)
        
        let oneWordWidth = CGFloat(50)
        let twoWordWidth = CGFloat(70)
        let labelHeight = CGFloat(25)
        
        func setLabel(_ label: UILabel, point: CGPoint) -> CGRect {
            
            var returnRect = CGRect(x: 0, y: 0, width: 0, height: 0)
            let labelWidth = label.frame.width
            let labelHeight = label.frame.height
            
            let newX = point.x - labelWidth/2
            let newY = point.y - labelHeight/2
            
            returnRect = CGRect(x: newX, y: newY, width: labelWidth, height: labelHeight)
            
            return returnRect
        }

        let ageTail = agePercent[0]%10
        
        func rangeOfAgeTail(ageTail: Int) -> Int {
            var ageNum = ageTail
            if ageNum > 9 {
                ageNum -= 10
                return ageNum
            }
            return ageNum
        }
        //圓圈的起點０度是在右邊
//        let ageTail = ageTailCalculateReduceThree(age: age)
        print("胎位置的數字\(tailNum)")
        beginingLabel.text = "胎 (\(rangeOfAgeTail(ageTail: tailNum)))"
        beginingLabel.frame.size = CGSize(width: oneWordWidth, height: labelHeight)
        beginingLabel.frame = setLabel(beginingLabel, point: CGPoint(x: width/2, y: heightFromTop+lineWidth+betweenH))
        if ageTail == rangeOfAgeTail(ageTail: tailNum) {
            beginingLabel.textColor = UIColor.orange
            //degree -> 90-120
            let degreeInt = 30 * agePercent[1] / 100
            nowDegree = CGFloat(90) + CGFloat(degreeInt) - CGFloat(15)
        }
        
//        let twoOfBetween = lineWidth/2/3
        secLabel.text = "養 (\(rangeOfAgeTail(ageTail: tailNum+1)))"
        secLabel.frame.size = CGSize(width: oneWordWidth, height: labelHeight)
        secLabel.frame = setLabel(secLabel, point: CGPoint(x: toTheSide+lineWidth/10, y: heightFromTop+lineWidth))
        if ageTail == rangeOfAgeTail(ageTail: tailNum+1) {
            secLabel.textColor = UIColor.orange
            //degree -> 120-150
            let degreeInt = 30 * agePercent[1] / 100
            nowDegree = CGFloat(120) + CGFloat(degreeInt) - CGFloat(15)
        }
        
        thirdLabel.text = "長生 (\(rangeOfAgeTail(ageTail: tailNum+2)))"
        thirdLabel.frame.size = CGSize(width: twoWordWidth, height: labelHeight)
        thirdLabel.frame = setLabel(thirdLabel, point: CGPoint(x: toTheSide-lineWidth/10, y: heightFromTop+lineWidth/4*3))
        if ageTail == rangeOfAgeTail(ageTail: tailNum+2) {
            thirdLabel.textColor = UIColor.orange
            //degree -> 150-180
            let degreeInt = 30 * agePercent[1] / 100
            nowDegree = CGFloat(150) + CGFloat(degreeInt) - CGFloat(15)
        }
        
        fourthLabel.text = "冠帶 (\(rangeOfAgeTail(ageTail: tailNum+3)))"
        fourthLabel.frame.size = CGSize(width: twoWordWidth, height: labelHeight)
        fourthLabel.frame = setLabel(fourthLabel, point: CGPoint(x: toTheSide-betweenH, y: heightFromTop+lineWidth/2))
        if ageTail == rangeOfAgeTail(ageTail: tailNum+3) {
            fourthLabel.textColor = UIColor.orange
            //degree -> 180-225
            let degreeInt = 37 * agePercent[1] / 100
            nowDegree = CGFloat(180) + CGFloat(degreeInt) - CGFloat(15)
        }
        
        fivethLabel.text = "臨冠 (\(rangeOfAgeTail(ageTail: tailNum+4)))"
        fivethLabel.frame.size = CGSize(width: twoWordWidth, height: labelHeight)
        fivethLabel.frame = setLabel(fivethLabel, point: CGPoint(x: toTheSide-betweenH/3, y: heightFromTop+lineWidth/16))
        if ageTail == rangeOfAgeTail(ageTail: tailNum+4) {
            fivethLabel.textColor = UIColor.orange
            //degree -> 225-270
            let degreeInt = 45 * agePercent[1] / 100
            nowDegree = CGFloat(225) + CGFloat(degreeInt) - CGFloat(22.5)
        }

        sixthLabel.text = "帝旺 (\(rangeOfAgeTail(ageTail: tailNum+5)))"
        sixthLabel.frame.size = CGSize(width: twoWordWidth, height: labelHeight)
        sixthLabel.frame = setLabel(sixthLabel, point: CGPoint(x: width/2, y: heightFromTop-betweenH))
        if ageTail == rangeOfAgeTail(ageTail: tailNum+5) {
            sixthLabel.textColor = UIColor.orange
            //degree -> 270-300
            let degreeInt = 38 * agePercent[1] / 100
            nowDegree = CGFloat(270) + CGFloat(degreeInt) - CGFloat(22.5)
        }

        seventhLabel.text = "衰 (\(rangeOfAgeTail(ageTail: tailNum+6)))"
        seventhLabel.frame.size = CGSize(width: oneWordWidth, height: labelHeight)
        seventhLabel.frame = setLabel(seventhLabel, point: CGPoint(x: toTheSide+lineWidth-lineWidth/12, y: heightFromTop))
        if ageTail == rangeOfAgeTail(ageTail: tailNum+6) {
            seventhLabel.textColor = UIColor.orange
            //degree -> 300-330
            let degreeInt = 30 * agePercent[1] / 100
            nowDegree = CGFloat(300) + CGFloat(degreeInt) - CGFloat(15)
        }

        eighthLabel.text = "病 (\(rangeOfAgeTail(ageTail: tailNum+7)))"
        eighthLabel.frame.size = CGSize(width: oneWordWidth, height: labelHeight)
        eighthLabel.frame = setLabel(eighthLabel, point: CGPoint(x: width-toTheSide/3*2, y: heightFromTop+lineWidth/4))
        if ageTail == rangeOfAgeTail(ageTail: tailNum+7) {
            eighthLabel.textColor = UIColor.orange
            //degree -> 330-30
            let degreeInt = 45 * agePercent[1] / 100
            nowDegree = CGFloat(330) + CGFloat(degreeInt) - CGFloat(15)
//            switch degreeInt > 30 {
//            case true:
//                degreeInt -= 30
//                nowDegree = CGFloat(degreeInt)
//            default:
//                nowDegree = CGFloat(330) + CGFloat(degreeInt)
//            }
        }

        ninethLabel.text = "死 (\(rangeOfAgeTail(ageTail: tailNum+8)))"
        ninethLabel.frame.size = CGSize(width: oneWordWidth, height: labelHeight)
        ninethLabel.frame = setLabel(ninethLabel, point: CGPoint(x: width-toTheSide/3*2, y: heightFromTop+lineWidth/4*3))
        if ageTail == rangeOfAgeTail(ageTail: tailNum+8) {
            ninethLabel.textColor = UIColor.orange
            //degree -> 30-60
            let degreeInt = 45 * agePercent[1] / 100
            nowDegree = CGFloat(30) + CGFloat(degreeInt) - CGFloat(30)
        }

        tenthLabel.font = UIFont.systemFont(ofSize: 18)
        tenthLabel.text = "絕 (\(rangeOfAgeTail(ageTail: tailNum+9)))"
        tenthLabel.frame.size = CGSize(width: oneWordWidth, height: labelHeight)
        tenthLabel.frame = setLabel(tenthLabel, point: CGPoint(x: toTheSide+lineWidth-lineWidth/12, y: heightFromTop+lineWidth))
        if ageTail == rangeOfAgeTail(ageTail: tailNum+9) {
            tenthLabel.textColor = UIColor.orange
            //degree -> 60-90
            let degreeInt = 30 * agePercent[1] / 100
            nowDegree = CGFloat(60) + CGFloat(degreeInt) - CGFloat(15)
        }
        
        
        drawCircle(Degree: nowDegree)
        
        
    }
    
    private func codingLayout() {
//        let width = self.view.frame.size.width
//        let height = self.view.frame.size.height
        let margins = titleLabel.superview!.layoutMarginsGuide
        
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
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: backFontButton.bottomAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        birthdayLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.centerYAnchor.constraint(equalTo: birthdayLabel.centerYAnchor).isActive = true
        ageLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        bottomTextView.translatesAutoresizingMaskIntoConstraints = false
        bottomTextView.topAnchor.constraint(equalTo: beginingLabel.bottomAnchor, constant: 30).isActive = true
        bottomTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        bottomTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        bottomTextView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -30).isActive = true
        bottomTextView.isHidden = true
    }
    
    private func outlook() {
        style.topButton(backFontButton, title: "首頁")
        style.topButton(backButton, title: "返回")
    }
    
    func labelShow(age: Int) {
        
        self.view.backgroundColor = itemStyle.color.init().light_brown
        
        titleLabel.text = "\(name) 流年 資料"
        
        birthdayLabel.text = "生日：\(birthday)"
        ageLabel.text = "虛歲：\(age)"
        
    }
}
