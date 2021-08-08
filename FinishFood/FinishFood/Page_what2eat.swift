//
//  Page_what2eat.swift
//  FinishFood
//
//  Created by Zhenyu Xu on 8/1/21.
//

import UIKit

class Page_what2eat: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func RandomFrozenFood(_ sender: Any) {
        let frozen_items = UserDefaults.standard.stringArray(forKey: "frozen_items") ?? []
        display.text = frozen_items.randomElement()!
    }
    
    

}
