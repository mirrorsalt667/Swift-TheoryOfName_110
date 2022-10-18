//
//  styleAndColor.swift
//  TheoryOfName
//
//  Created by on 2021/12/6.
//

// MARK: 元件樣式

import Foundation
import UIKit

class itemStyle {
    
    struct color{
        let dove_gray = UIColor(red: 156/255, green: 143/255, blue: 150/255, alpha: 1)
        let dark_green = UIColor(red: 51/255, green: 56/255, blue: 18/255, alpha: 1)
        let light_brown = UIColor(red: 217/255, green: 216/255, blue: 212/255, alpha: 1)
        let mid_brown = UIColor(red: 198/255, green: 196/255, blue: 181/255, alpha: 1)
        let wordColor = UIColor(red: 90/255, green: 105/255, blue: 130/255, alpha: 1)
        let bright_brown = UIColor(red: 0.629, green: 0.450, blue: 0.267, alpha: 1)
    }
    
    func blackLabel(label: UILabel, size: CGFloat) {
        label.font = UIFont.systemFont(ofSize: size)
    }
    func blueWord(label: UILabel, size: CGFloat, alignment: NSTextAlignment) {
        label.textColor = itemStyle.color.init().wordColor
        label.font = UIFont.systemFont(ofSize: size)
        label.textAlignment = alignment
    }
    
    
    
    
    func firstPageButton(_ button: UIButton, setTitle: String) {
        
        button.setTitle(setTitle, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(itemStyle.color.init().dark_green, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.backgroundColor = itemStyle.color.init().dove_gray.cgColor
//        button.layer.borderColor = itemStyle.color.init().mid_brown.cgColor
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 4
        
    }
    func topButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(itemStyle.color.init().wordColor, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.backgroundColor = itemStyle.color.init().mid_brown.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 3
    }
    func confirmButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(itemStyle.color.init().mid_brown, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.backgroundColor = itemStyle.color.init().bright_brown.cgColor
        button.layer.cornerRadius = 3
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = itemStyle.color.init().bright_brown.cgColor
    }
    func keyInNameTF(tf: UITextField) {
        tf.textColor = UIColor.darkGray
        tf.textAlignment = .center
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.layer.cornerRadius = 3.5
        tf.layer.backgroundColor = UIColor.clear.cgColor
        tf.layer.borderWidth = 1.5
        tf.layer.borderColor = itemStyle.color.init().dark_green.cgColor
        tf.borderStyle = .none
        tf.layer.shadowColor = UIColor.gray.cgColor
        tf.layer.shadowRadius = 1
        tf.layer.shadowOffset = CGSize(width: 2, height: 3)
        tf.layer.shadowOpacity = 0.5
    }
    func brownButton(_ button: UIButton, title: String) {
        button.layer.backgroundColor = itemStyle.color.init().bright_brown.cgColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(itemStyle.color.init().dark_green, for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = itemStyle.color.init().dark_green.cgColor
        button.alpha = 0.8
        button.layer.cornerRadius = 8
    }
    
    func labelStyle(label: UILabel, size: CGFloat) {
        label.font = UIFont.systemFont(ofSize: size)
        
    }
    
}
