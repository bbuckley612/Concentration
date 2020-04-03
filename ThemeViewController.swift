//
//  ThemeViewController.swift
//  Test
//
//  Created by Brian Buckley on 4/2/20.
//  Copyright © 2020 Helping Hand Food Pantry. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var header: UINavigationBar!
    
    var themeColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    
    var emojiChoices = ["👻", "🎃", "🦇", "😱", "😈", "🍭", "🍬", "☠️", "🔮", "⚰️", "🕸", "🕷", "👽"]
    
    @IBAction func changeTheme(_ sender: UIButton) {
        let button = sender as? UIButton

        themeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        emojiChoices = ["😀", "🤓", "😂", "🤪", "😍", "😭", "😡", "🤢", "🥶", "😬", "😴", "🥺", "😎"]
        header.barTintColor = themeColor
    }
    
    override func viewDidLoad() {
        header.barTintColor = themeColor
        print("AHH!")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
