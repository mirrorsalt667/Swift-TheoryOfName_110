//
//  ActionPartViewController.swift
//  TheoryOfName
//
//  Created by 黃肇祺 on 2022/6/25.
//

import UIKit

class ActionPartViewController: UIViewController {

    //MARK: init
    private let tStyle = itemStyle()
    
    
    private var mAge: Int = 0
    private var mActionTitle: String = ""
    private var mActionContent: CharactersContent?
    
    
    //MARK: Outlet Component
    @IBOutlet weak var actScrollView: UIScrollView!
    @IBOutlet weak var actStackView: UIStackView!
    
    @IBOutlet weak var actionTitleLabel: UILabel!
    @IBOutlet weak var actSubtitleLabel: UILabel!
    
    @IBOutlet weak var characterTitleLabel: UILabel!
    @IBOutlet weak var activenessTitleLabel: UILabel!
    @IBOutlet weak var handleAffairsTitleLabel: UILabel!
    @IBOutlet weak var attitudeTitleLabel: UILabel!
    @IBOutlet weak var goodPointTitleLabel: UILabel!
    @IBOutlet weak var weekPointTitleLabel: UILabel!
    @IBOutlet weak var bornLuckyTitleLabel: UILabel!
    @IBOutlet weak var careerTitleLabel: UILabel!
    @IBOutlet weak var lifeOutlookTitleLabel: UILabel!

    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var activenessLabel: UILabel!
    @IBOutlet weak var handleAffairsLabel: UILabel!
    @IBOutlet weak var attitudeLabel: UILabel!
    @IBOutlet weak var goodPointLabel: UILabel!
    @IBOutlet weak var weekPointLabel: UILabel!
    @IBOutlet weak var bornLuckyLabel: UILabel!
    @IBOutlet weak var careerLabel: UILabel!
    @IBOutlet weak var lifeOutlookLabel: UILabel!
    
    
    
    //MARK: View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mActionTitle = gActionCharacter
        mAge = gAgeNum
        
        //取得資料
        mActionContent = getCharacterData(title: gActionCharacter)
        
        setLabelWords()
        setScrollViewFrame(scroll: actScrollView, stack: actStackView)
    }
    
    
    
    //MARK: Action Connect
    @IBAction func closeBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: Other Function
    //設置滑動範圍
    private func setScrollViewFrame(scroll: UIScrollView, stack: UIStackView) {
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        scroll.contentLayoutGuide.owningView?.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentLayoutGuide.heightAnchor.constraint(equalTo: stack.heightAnchor).isActive = true
    }
    
    //顯示Label內容
    private func setLabelWords() {
        actionTitleLabel.text = mActionTitle
        if mAge == 35 {
            //剛好
            actSubtitleLabel.text = "思想功能會在35歲前後慢慢轉變為行動功能。"
        }else if mAge > 35 {
            actSubtitleLabel.text = "思想功能會在35-\(mAge)歲間慢慢轉變為行動功能。"
        }else{
            actSubtitleLabel.text = "思想功能會在\(mAge)-35歲間慢慢轉變為行動功能。"
        }
        if mActionTitle.contains(where: { word in
            word == "平"
        })  {

        }else{
            if let content = mActionContent {
                characterLabel.text = content.character
                activenessLabel.text = content.activeness
                handleAffairsLabel.text = content.handleAffairs
                attitudeLabel.text = content.attitude
                goodPointLabel.text = content.goodPoint
                weekPointLabel.text = content.weekPoint
                bornLuckyLabel.text = content.bornLucky
                careerLabel.text = content.career
                lifeOutlookLabel.text = content.lifeOutlook
            }
        }
    }
    
    //取得個性資料
    private func getCharacterData(title: String) -> CharactersContent? {
        print("準備取得資料")
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
                print("取得資料")
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
