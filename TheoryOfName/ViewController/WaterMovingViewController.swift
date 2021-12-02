//
//  WaterMovingViewController.swift
//  TheoryOfName
//
//  Created on 2021/11/27.
//

import UIKit

class WaterMovingViewController: UIViewController {

    let path = UIBezierPath()
    let shape = CAShapeLayer()
    var birthday = ""
    var age = ""
    
    
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
        
        drawATen()
        position()
        codingLayout()
        labelShow()
        
    }
    
    func drawATen() {
        let width = self.view.frame.size.width
//        let height = self.view.frame.size.height
        let lineWidth = CGFloat(width - 180)
        let heightFromTop = CGFloat(250)
        
        path.move(to: CGPoint(x: width/2, y: heightFromTop))
        path.addLine(to: CGPoint(x: width/2, y: lineWidth + heightFromTop))
        
        shape.lineCap = .round
        shape.path = path.cgPath
        shape.strokeColor = UIColor.brown.cgColor
        shape.lineWidth = 4
        self.view.layer.addSublayer(shape)
        
        path.move(to: CGPoint(x: width/2-lineWidth/2, y: heightFromTop+lineWidth/2))
        path.addLine(to: CGPoint(x: self.view.frame.midX+lineWidth/2, y: heightFromTop+lineWidth/2))
        
        shape.path = path.cgPath
        self.view.layer.addSublayer(shape)
        
        
        
        
        let aDegree = CGFloat.pi/180
        let circlePath = UIBezierPath(ovalIn: CGRect(x: width/2, y: heightFromTop+lineWidth/2, width: lineWidth, height: lineWidth))
        let circle = UIBezierPath(arcCenter: CGPoint(x: width/2, y: heightFromTop+lineWidth/2), radius: lineWidth/2, startAngle: 0, endAngle: aDegree*(90+360*0.5), clockwise: true)
        
        
        let circelLayer = CAShapeLayer()
        circelLayer.path = circle.cgPath
        circelLayer.lineWidth = 3
        circelLayer.fillColor = UIColor.clear.cgColor
        circelLayer.strokeColor = UIColor.darkGray.cgColor
        
        self.view.layer.addSublayer(circelLayer)
    }
    
    func position() {
        let width = self.view.frame.size.width
//        let height = self.view.frame.size.height
        let toTheSide = CGFloat(90)
        let lineWidth = CGFloat(width - toTheSide * 2)
        let heightFromTop = CGFloat(250)
//        let margins = titleLabel.superview!.layoutMarginsGuide
        let betweenH = CGFloat(30)
//        let betweenV = CGFloat(50)
        
        
        func setLabel(_ label: UILabel, point: CGPoint) -> CGRect {
            
            var returnRect = CGRect(x: 0, y: 0, width: 0, height: 0)
            let labelWidth = label.frame.width
            let labelHeight = label.frame.height
            
            let newX = point.x - labelWidth/2
            let newY = point.y - labelHeight/2
            
            returnRect = CGRect(x: newX, y: newY, width: labelWidth, height: labelHeight)
            
            return returnRect
        }
        let ageTail = 0
        func ageTailCalculate(age: Int) -> Int{
             return age%10
        }
        beginingLabel.text = "胎 \(ageTailCalculate(age: ageTail))歲"
        beginingLabel.frame.size = CGSize(width: 75, height: 25)
        beginingLabel.frame = setLabel(beginingLabel, point: CGPoint(x: width/2, y: heightFromTop+lineWidth+betweenH))
        
        let twoOfBetween = lineWidth/2/3
        secLabel.text = "養 \(ageTailCalculate(age: ageTail+1))歲"
        secLabel.frame.size = CGSize(width: 75, height: 25)
        secLabel.frame = setLabel(secLabel, point: CGPoint(x: toTheSide + 10, y: heightFromTop+lineWidth-twoOfBetween))
        
        thirdLabel.text = "長生 \(ageTailCalculate(age: ageTail+2))歲"
        thirdLabel.frame.size = CGSize(width: 90, height: 25)
        thirdLabel.frame = setLabel(thirdLabel, point: CGPoint(x: toTheSide, y: heightFromTop+lineWidth-2*twoOfBetween))
        
        fourthLabel.text = "冠帶 \(ageTailCalculate(age: ageTail+3))歲"
        fourthLabel.frame.size = CGSize(width: 90, height: 25)
        fourthLabel.frame = setLabel(fourthLabel, point: CGPoint(x: toTheSide-35, y: heightFromTop+lineWidth/2))
        
        fivethLabel.text = "臨冠 \(ageTailCalculate(age: ageTail+4))歲"
        fivethLabel.frame.size = CGSize(width: 90, height: 25)
        fivethLabel.frame = setLabel(fivethLabel, point: CGPoint(x: toTheSide, y: heightFromTop+lineWidth/4))

        sixthLabel.text = "帝旺 \(ageTailCalculate(age: ageTail+5))歲"
        sixthLabel.frame.size = CGSize(width: 90, height: 25)
        sixthLabel.frame = setLabel(sixthLabel, point: CGPoint(x: width/2, y: heightFromTop-20))

        seventhLabel.text = "衰 \(ageTailCalculate(age: ageTail+6))歲"
        seventhLabel.frame.size = CGSize(width: 75, height: 25)
        seventhLabel.frame = setLabel(seventhLabel, point: CGPoint(x: width-toTheSide, y: heightFromTop+lineWidth/6))

        eighthLabel.text = "病 \(ageTailCalculate(age: ageTail+7))歲"
        eighthLabel.frame.size = CGSize(width: 75, height: 25)
        eighthLabel.frame = setLabel(eighthLabel, point: CGPoint(x: width-toTheSide/3*2, y: heightFromTop+lineWidth/3))

        ninethLabel.text = "死 \(ageTailCalculate(age: ageTail+8))歲"
        ninethLabel.frame.size = CGSize(width: 75, height: 25)
        ninethLabel.frame = setLabel(ninethLabel, point: CGPoint(x: width-toTheSide/3*2, y: heightFromTop+lineWidth/3*2))

        tenthLabel.text = "絕 \(ageTailCalculate(age: ageTail+9))歲"
        tenthLabel.frame.size = CGSize(width: 75, height: 25)
        tenthLabel.frame = setLabel(tenthLabel, point: CGPoint(x: width-toTheSide, y: heightFromTop+lineWidth/6*5))
        
    }
    
    func codingLayout() {
//        let width = self.view.frame.size.width
//        let height = self.view.frame.size.height
        let margins = titleLabel.superview!.layoutMarginsGuide
        
        backFontButton.translatesAutoresizingMaskIntoConstraints = false
        backFontButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        backFontButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        backButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
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
    }
    
    func labelShow() {
        
    }
}
