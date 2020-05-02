//
//  FudaScreenLayout.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/05/01.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import UIKit
import Then

// 札が、superviewのどれくらいを占めたいか。
private let occupyRatio: CGFloat = 2.0 / 3

// 札の各種実測サイズ (単位はmm)
private let fudaHeightMeasured: CGFloat = 73.0
private let fudaWidthMeasured: CGFloat = 53.0
private let greenOffsetMeasured: CGFloat = 2.0
// アスペクト比 (幅/高さ)
private let aspectRatio = fudaWidthMeasured / fudaHeightMeasured

extension FudaViewController {
    internal func layoutFudaScreen() {
        setTatamiBackground()
        setGreenBackView()
        setWhiteBackView()
    }
    
    private func setTatamiBackground() {
        let image = UIImage(named: "tatami_moved.jpg")
        let tatamiView = UIImageView(image: image)
        view.addSubview(tatamiView)
        tatamiView.frame = view.bounds
        self.tatamiView = tatamiView
    }
    
    private func setGreenBackView() {
        guard let tatamiView = self.tatamiView else { return }
        let image = UIImage(named: "washi_darkgreen 001.jpg")
        let greenBackView = UIImageView(image: image)
        let height = fudaHeight()
        self.fudaPower = height / fudaHeightMeasured
        greenBackView.frame.size = CGSize(width: fudaWidthMeasured * fudaPower, height: height)
        greenBackView.center = CGPoint(x: view.center.x, y: view.center.y + topOffset() / 2.0)
        tatamiView.addSubview(greenBackView)
        self.greenBackView = greenBackView
    }
    
    private func setWhiteBackView() {
        guard let greenBackView = self.greenBackView else { return }
        guard let tatamiView = self.tatamiView else { return }
        let superViewHeight = greenBackView.frame.size.height
        let superViewWidth = greenBackView.frame.size.width
        let offset = greenOffsetMeasured * fudaPower
        let whiteBackView = UIView(frame: CGRect(
            x: 0, y: 0,
            width: superViewWidth - 2 * offset,
            height: superViewHeight - 2 * offset)).then {
                $0.backgroundColor = UIColor(hex: "FFF7E5")
                $0.center = greenBackView.center
                tatamiView.addSubview($0)
        }
        self.whiteBackView = whiteBackView
    }
    
    private func fudaHeight() -> CGFloat {
        return [heightBySuperviewWidth(), heightBySuperviewHeight()].min() ?? 300
    }
    
    private func heightBySuperviewHeight() -> CGFloat {
        return (view.frame.size.height - topOffset()) * occupyRatio
    }
    
    private func heightBySuperviewWidth() -> CGFloat {
        return view.frame.size.width / aspectRatio * occupyRatio
    }
    
    private func topOffset() -> CGFloat {
        // ステータスバーの高さを取得する
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        // ナビゲーションバーの高さを取得する
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        return statusBarHeight + navigationBarHeight
    }
}



