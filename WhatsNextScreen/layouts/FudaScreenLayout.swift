//
//  FudaScreenLayout.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/05/01.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import UIKit
import Then

private let occupyRatio: CGFloat = 2.0 / 3
private let aspectRatioSize: CGSize = CGSize(width: 53.0, height: 73.0)
private let aspectRatio = aspectRatioSize.height / aspectRatioSize.width

extension FudaViewController {
    internal func layoutFudaScreen() {
        setTatamiBackground()
        setGreenBackView()
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
        greenBackView.frame.size = CGSize(width: height / aspectRatio, height: height)
        greenBackView.center = CGPoint(x: view.center.x, y: view.center.y + topOffset() / 2.0)
        tatamiView.addSubview(greenBackView)
        self.greenBackView = greenBackView
    }
    
    private func fudaHeight() -> CGFloat {
        return [heightBySuperviewWidth(), heightBySuperviewHeight()].min() ?? 300
    }
    
    private func heightBySuperviewHeight() -> CGFloat {
        return view.frame.size.width * occupyRatio * aspectRatio
    }
    
    private func heightBySuperviewWidth() -> CGFloat {
        return (view.frame.size.height - topOffset()) * occupyRatio
    }
    
    private func topOffset() -> CGFloat {
        // ステータスバーの高さを取得する
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        // ナビゲーションバーの高さを取得する
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        return statusBarHeight + navigationBarHeight
    }
}



