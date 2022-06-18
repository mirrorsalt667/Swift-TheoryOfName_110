//
//  BrainPartViewController.swift
//  TheoryOfName
//
//  Created by 黃肇祺 on 2022/6/18.
//

// 思想＆行動功能頁面

import UIKit

class BrainPartViewController: UIViewController {

    //MARK: init
    private let tStyle = itemStyle()
    
    
//    var mIsBrain: Bool = true
    var mBrainTitle: String = ""
    var mAge: Int = 0
    private var mBrainContent: CharactersContent?
    private var mActionTitle: String = ""
    private var mActionContent: CharactersContent?
    
    
    //MARK: Outlet Component
    @IBOutlet weak var bigScrollView: UIScrollView!
    @IBOutlet weak var bigStackView: UIStackView!
    
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pageSubtitleLabel: UILabel!
    
    @IBOutlet weak var characterTitleLabel: UILabel!
    @IBOutlet weak var activenessTitleLabel: UILabel!
    @IBOutlet weak var handleAffairsTitleLabel: UILabel!
    @IBOutlet weak var attitudeTitleLabel: UILabel!
    @IBOutlet weak var goodPointTitleLabel: UILabel!
    @IBOutlet weak var weekPointTitleLabel: UILabel!
    @IBOutlet weak var bornLuckyTitleLabel: UILabel!
    @IBOutlet weak var careerTitleLabel: UILabel!
    @IBOutlet weak var lifeOutlookTitleLabel: UILabel!
//    @IBOutlet weak var postscriptTitleLabel: UILabel!
    
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var activenessLabel: UILabel!
    @IBOutlet weak var handleAffairsLabel: UILabel!
    @IBOutlet weak var attitudeLabel: UILabel!
    @IBOutlet weak var goodPointLabel: UILabel!
    @IBOutlet weak var weekPointLabel: UILabel!
    @IBOutlet weak var bornLuckyLabel: UILabel!
    @IBOutlet weak var careerLabel: UILabel!
    @IBOutlet weak var lifeOutlookLabel: UILabel!
//    @IBOutlet weak var postscriptLabel: UILabel!
    
    
    //MARK: View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setOutlookStyle()
        scrollViewPosition()
        
        //取得資料
        mBrainContent = getCharacterData(title: mBrainTitle)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    
    //MARK: Action Connect
    
    
    
    //MARK: Other Function
    private func setOutlookStyle() {
        pageTitleLabel.text = mBrainTitle
    }
    private func scrollViewPosition() {
        
    }
    //顯示Label內容
    private func setLabelWords(isBrain: Bool) {
        if isBrain {
            pageTitleLabel.text = mBrainTitle
        }else{
            
        }
        
    }
    //切換頁面
    func changePage(isBrain: Bool, title: String) {
        //若是平宮，要隱藏比較多
        if isBrain {
            
        }else{
            
        }
    }
    //取得個性資料
    private func getCharacterData(title: String) -> CharactersContent? {
        var url = URL(string: "")
        if title.contains(where: { word in
            word == "生"
        }) {
            if let insideUrl = Bundle.main.url(forResource: "AssistanceCharacters", withExtension: "plist") {
                url = insideUrl
            }
        }else if title.contains(where: { word in
            word == "剋"
        }) {
            if let insideUrl = Bundle.main.url(forResource: "AgainstCharacters", withExtension: "plist") {
                url = insideUrl
            }
        }else if title.contains(where: { word in
            word == "平"
        }) {
            if let insideUrl = Bundle.main.url(forResource: "EqualCharacters", withExtension: "plist") {
                url = insideUrl
            }
        }
        if url != nil {
            if let data = try? Data(contentsOf: url!),
               let character = try? PropertyListDecoder().decode([CharactersContent].self, from: data) {
                let count = character.count
                for k in 0..<count {
                    if title == character[k].title {
                        return character[k]
                    }
                }
            }
        }
        return nil
    }
}
