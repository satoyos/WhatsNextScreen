//
//  WahtsNextScreenLayout.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/04/29.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit
import SnapKit
import Then

extension WhatsNextViewController {
    internal func layoutButtons() {
        layoutRefrainButton()
    }
    
    private func layoutRefrainButton() {
        _ = refrainButton.then {
            setCommonLayout(button: $0)
            $0.initWithImage(filename: "refrain.png")
            $0.setTitle("下の句をもう一度読む", for: .normal)
            $0.center.y = view.center.y
        }
    }
    
    private func setCommonLayout(button: WhatsNextButton) {
        _ = button.then {
            $0.frame.size = buttonSize()
            $0.center.x = view.center.x
            $0.setStandardTitleColor()
        }
    }
    
    private func buttonSize() -> CGSize {
        return CGSize(width: viewWidth() * 0.8, height: sizes.whatsNextButtonHeight())
    }
    
    private func viewWidth() -> CGFloat {
        return view.frame.size.width
    }
    
    private func retinaSclae() -> CGFloat {
        return UIScreen.main.scale
    }

}

