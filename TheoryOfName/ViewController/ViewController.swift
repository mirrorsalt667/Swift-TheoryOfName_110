//
//  ViewController.swift
//  TheoryOfName
//
//  Created on 2021/10/18.
//

import UIKit

class ViewController: UIViewController {
    
    
    var arrays = [NameJson]()
    
    @IBOutlet weak var firstLAbel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
    }
    @IBAction func confirmButton(_ sender: Any) {
        
        if let name = nameTF.text {
            
            let ip = arrays.firstIndex { kiki in
                kiki.word == name
            }
            print(ip)
            print(arrays[Int(ip ?? 0)].word)
        }
        
        
    }
    
    func getData() {
        
        if let data = NSDataAsset(name: "dict_revised_1013")?.data {
            do {
                let decoder = JSONDecoder()
                let koko = try decoder.decode([NameJson].self, from: data)
                arrays = koko
                
//                print(arrays)
                DispatchQueue.main.async {
                    self.firstLAbel.text = String(self.arrays[0].base)
                }
                
            } catch {
                print(error)
                
            }
        }else{
            print("failed")
        }
    }

}

