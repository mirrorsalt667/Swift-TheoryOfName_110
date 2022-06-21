//
//  BrainTabBarViewController.swift
//  TheoryOfName
//
//  Created by 黃肇祺 on 2022/6/20.
//

import UIKit

//protocol BrainTabBarDelegate {
//    func sendToBrain(_ controller: UITabBarController, brain: String, action: String)
//}

class BrainTabBarViewController: UITabBarController {

//    var mDelegate: BrainTabBarDelegate?
    var mBrainTitle: String = ""
    var mActionTitle: String = ""
    
    var controllerTest: UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("有傳過來嗎", mBrainTitle, "and", mActionTitle)
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? BrainPartViewController {
            print("觸發prepare ------------!")
            controller.mBrainTitle = self.mBrainTitle
            controller.mActionTitle = self.mActionTitle
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        print("======= touch bar delegate ======= ")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "BrainPartViewController") as? BrainPartViewController {
            controller.mBrainTitle = self.mBrainTitle
            controller.mActionTitle = self.mActionTitle
        }
    }
}
