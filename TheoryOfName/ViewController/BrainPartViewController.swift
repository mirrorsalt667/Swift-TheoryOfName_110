//
//  BrainPartViewController.swift
//  TheoryOfName
//
//  Created by on 2022/6/18.
//

// MARK: 思想功能頁面

import UIKit

final class BrainPartViewController: UIViewController {
    
    //MARK: init
    private let tStyle = itemStyle()
    
    private var mAge: Int = 0
    private var mBrainTitle: String = ""
    private var mBrainContent: CharactersContent?
//    private var mActionTitle: String = ""
//    private var mActionContent: CharactersContent?
    
    
    //MARK: Outlet Component
    @IBOutlet var backFontButton: UIButton!
    @IBOutlet var backButton: UIButton!
    
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
        mBrainTitle = gBrainCharacter
        mAge = gTotalNameNum
        
        //取得資料
        mBrainContent = getCharacterData(title: gBrainCharacter)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setScrollViewFrame(scroll: bigScrollView, stack: bigStackView)
        setLabelWords()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    //MARK: Action Connect
    @IBAction func closeBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: Other Function
    private func setOutlookStyle() {
        pageTitleLabel.text = mBrainTitle
        tStyle.topButton(backFontButton, title: "首頁")
        tStyle.topButton(backButton, title: "返回")
    }
    
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
        pageTitleLabel.text = mBrainTitle
        if mAge == 35 {
            //剛好
            pageSubtitleLabel.text = "思想功能會在35歲前後慢慢轉變為行動功能。"
        }else if mAge > 35 {
            pageSubtitleLabel.text = "思想功能會在35-\(mAge)歲間慢慢轉變為行動功能。"
        }else{
            pageSubtitleLabel.text = "思想功能會在\(mAge)-35歲間慢慢轉變為行動功能。"
        }
        if mBrainTitle.contains(where: { word in
            word == "平"
        })  {
            if let brainContent = mBrainContent {
                var string = ""
                if brainContent.character != "" {
                    string += brainContent.character + "\n"
                }
                if brainContent.activeness != "" {
                    string += brainContent.activeness + "\n"
                }
                if brainContent.handleAffairs != "" {
                    string += brainContent.handleAffairs + "\n"
                }
                if brainContent.attitude != "" {
                    string += brainContent.attitude + "\n"
                }
                if brainContent.goodPoint != "" {
                    string += brainContent.goodPoint + "\n"
                }
                if brainContent.weekPoint != "" {
                    string += brainContent.weekPoint + "\n"
                }
                if brainContent.bornLucky != "" {
                    string += brainContent.bornLucky + "\n"
                }
                if brainContent.career != "" {
                    string += brainContent.career + "\n"
                }
                if brainContent.lifeOutlook != "" {
                    string += brainContent.lifeOutlook + "\n"
                }
                characterLabel.text = string
                activenessTitleLabel.isHidden = true
                handleAffairsTitleLabel.isHidden = true
                attitudeTitleLabel.isHidden = true
                goodPointTitleLabel.isHidden = true
                weekPointTitleLabel.isHidden = true
                bornLuckyTitleLabel.isHidden = true
                careerTitleLabel.isHidden = true
                lifeOutlookTitleLabel.isHidden = true
                activenessLabel.isHidden = true
                handleAffairsLabel.isHidden = true
                attitudeLabel.isHidden = true
                goodPointLabel.isHidden = true
                weekPointLabel.isHidden = true
                bornLuckyLabel.isHidden = true
                careerLabel.isHidden = true
                lifeOutlookLabel.isHidden = true
            }
        }else{
            if let brainContent = mBrainContent {
                characterLabel.text = brainContent.character
                activenessLabel.text = brainContent.activeness
                handleAffairsLabel.text = brainContent.handleAffairs
                attitudeLabel.text = brainContent.attitude
                goodPointLabel.text = brainContent.goodPoint
                weekPointLabel.text = brainContent.weekPoint
                bornLuckyLabel.text = brainContent.bornLucky
                careerLabel.text = brainContent.career
                lifeOutlookLabel.text = brainContent.lifeOutlook
            }
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
        // 取得url後，解析資料
        if url != nil {
            if let data = try? Data(contentsOf: url!) {
                
                do {
                    let character = try PropertyListDecoder().decode([CharactersContent].self, from: data)
                    let count = character.count
                    for k in 0..<count {
                        if title == character[k].title {
                            return character[k]
                        }
                    }
                } catch {
                    print("解析資料錯誤", error)
                }
                //                let character = try? PropertyListDecoder().decode([CharactersContent].self, from: data)
                //                let count = character.count
                //                for k in 0..<count {
                //                    if title == character[k].title {
                //                        return character[k]
                //                    }
                //                }
            } else {
                return nil
            }
        }
        return nil
    }
}
