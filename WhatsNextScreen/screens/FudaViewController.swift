//
//  FudaViewController.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/05/01.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import UIKit

class FudaViewController: UIViewController {
    var shimoString = "下の句がここに入る"
    var titleString = "タイトル未定"
    var fudaPower: CGFloat = 0.0  // 実測サイズ(mm)の何倍で画面表示するか
    var tatamiView: UIImageView!
    var greenBackView: UIImageView!
    var whiteBackView: UIView!
    var labels15 = [UILabel]()

    init(shimoString: String, title titleString: String) {
        self.shimoString = shimoString
        self.titleString = titleString

        // クラスの持つ指定イニシャライザを呼び出す
        super.init(nibName: nil, bundle: nil)
    }
    
    // 新しく init を定義した場合に必須
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = titleString
        layoutFudaScreen()
    }
    
}
