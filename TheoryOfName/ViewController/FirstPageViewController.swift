//
//  FirstPageViewController.swift
//  TheoryOfName
//
//  Created on 2021/11/7.
//
//  資料儲存，非userdefault 方式

// MARK: 首頁

import UIKit

struct CharactersContent: Decodable {
    let title: String
    let character: String
    let activeness: String
    let handleAffairs: String
    let attitude: String
    let goodPoint: String
    let weekPoint: String
    let bornLucky: String
    let career: String
    let lifeOutlook: String
    let postscript: String
}

final class FirstPageViewController: UIViewController {

    private let style = itemStyle()
    
    private var myName: SelfNameRecord?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selfButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    @IBOutlet weak var backgroundIV: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sizeAndPosition()
        outlookAndShow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readMyName()
    }
    
    
    @IBAction func selfButton(_ sender: Any) {
        if let name = myName {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let selfName = storyboard.instantiateViewController(withIdentifier: "SelfViewController") as? SelfViewController {
//                selfName.firstName = name.firstName
//                selfName.lastName = name.lastName
//                selfName.birthdate = name.birthday
                selfName.myName = self.myName
                selfName.modalPresentationStyle = .fullScreen
                present(selfName, animated: true, completion: nil)
            }
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let keyIn = storyboard.instantiateViewController(withIdentifier: "KeyInNameViewController") as? KeyInNameViewController {
                keyIn.selfKeyInBool = true
                keyIn.modalPresentationStyle = .fullScreen
                self.present(keyIn, animated: true, completion: nil)
            }
        }
    }
    @IBAction func newButton(_ sender: Any) {
        performSegue(withIdentifier: "ToKeyInSegue", sender: nil)
    }
    @IBAction func recordButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nameList = storyboard.instantiateViewController(withIdentifier: "NameListViewController")
        nameList.modalPresentationStyle = .fullScreen
        present(nameList, animated: true, completion: nil)
    }
    @IBAction func aboutButton(_ sender: Any) {
        //預計放設計人資訊或命理老師資訊
    }
    
    
    
    private func sizeAndPosition() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        let margins = titleLabel.superview!.layoutMarginsGuide
        let fourOneHeight = height/2/5/2
        newButton.translatesAutoresizingMaskIntoConstraints = false
        newButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        newButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        newButton.widthAnchor.constraint(equalToConstant: width/5*3).isActive = true

        
        selfButton.translatesAutoresizingMaskIntoConstraints = false
        selfButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        selfButton.bottomAnchor.constraint(equalTo: newButton.topAnchor, constant: -fourOneHeight).isActive = true
        selfButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        selfButton.widthAnchor.constraint(equalToConstant: width/5*3).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: selfButton.topAnchor, constant: -fourOneHeight*3/2).isActive = true
        
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        recordButton.topAnchor.constraint(equalTo: newButton.bottomAnchor, constant: fourOneHeight).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        recordButton.widthAnchor.constraint(equalToConstant: width/5*3).isActive = true

        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        aboutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        aboutButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        backgroundIV.translatesAutoresizingMaskIntoConstraints = false
        backgroundIV.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundIV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backgroundIV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backgroundIV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func outlookAndShow() {
        self.view.layer.backgroundColor = itemStyle.color.init().light_brown.cgColor
        backgroundIV.image = UIImage(named: "background_name.png")
        backgroundIV.contentMode = .scaleAspectFill
        
        titleLabel.textColor = itemStyle.color.init().wordColor
        titleLabel.font = UIFont.systemFont(ofSize: 28)
        titleLabel.text = "姓名學的日常應用"
        style.firstPageButton(selfButton, setTitle: "本 身 資 料")
        style.firstPageButton(newButton, setTitle: "新 資 料")
        style.firstPageButton(recordButton, setTitle: "查 詢 紀 錄")
        aboutButton.setTitle("關於我", for: .normal)
        aboutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        aboutButton.setTitleColor(itemStyle.color.init().mid_brown, for: .normal)
    }
    private func readMyName() {
        let propertyDecoder = PropertyListDecoder()
        let document = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        let url = document.appendingPathComponent("MyName")
        if let data = try? Data(contentsOf: url),
           let receive = try? propertyDecoder.decode(SelfNameRecord.self, from: data) {
            self.myName = receive
        }
    }
    
    @IBAction func unwindToFirstPage(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
}
