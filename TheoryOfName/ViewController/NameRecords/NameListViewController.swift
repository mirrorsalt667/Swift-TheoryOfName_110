//
//  NameListViewController.swift
//  TheoryOfName
//
//  Created by 黃肇祺 on 2021/12/10.
//

import UIKit

class NameListViewController: UIViewController {

    var nameListArrays = [NameRecords]()
    var selectedRow: Int?
    
    @IBOutlet weak var nameListTableView: UITableView!
    
    @IBOutlet weak var backFontButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameListTableView.delegate = self
        nameListTableView.dataSource = self
        
        readData()
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    func readData() {
        let property = PropertyListDecoder()
        let documentDirectury = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
        let url = documentDirectury.appendingPathComponent("nameRecord")
        if let data = try? Data(contentsOf: url),
           let encoderData = try? property.decode([NameRecords].self, from: data) {
            self.nameListArrays = encoderData
            nameListTableView.reloadData()
        }
    }
    
    func codingLayout() {
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        let margins = backFontButton.superview!.layoutMarginsGuide
        
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
        
        nameListTableView.translatesAutoresizingMaskIntoConstraints = false
        nameListTableView.topAnchor.constraint(equalTo: backFontButton.bottomAnchor, constant: 30).isActive = true
        nameListTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        nameListTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        nameListTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -15).isActive = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "NameNumViewController" {
            if let controller = segue.destination as? NameNumViewController {
                guard let num = selectedRow else { return }
                controller.firstName = nameListArrays[num].firstName
                controller.lastName = nameListArrays[num].lastName
                controller.birthdate = nameListArrays[num].birthday
                print("data send")
//            }
        }
    }
    
}


extension NameListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameListArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameListCell", for: indexPath) as! NameListTableViewCell
        let row = indexPath.row
        let name = "\(nameListArrays[row].lastName)\(nameListArrays[row].firstName)"
        cell.nameLabel.text = name
        cell.birthdayLabel.text = nameListArrays[row].birthday
        
        let age = nowAgeAndPercent(birth: nameListArrays[row].birthday)[0]
        cell.ageLabel.text = String(age)
        
        cell.relationLabel.text = ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "NameNumViewController") as? NameNumViewController {
            guard let num = selectedRow else { return }
            vc.firstName = nameListArrays[num].firstName
            vc.lastName = nameListArrays[num].lastName
            vc.birthdate = nameListArrays[num].birthday
            vc.showKind = 1
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
}
