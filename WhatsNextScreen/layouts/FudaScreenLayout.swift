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
// 文字のフォント
private let fudaFont = UIFont(name: "HiraMinProN-W6", size: 5)
private let fudaFontSizeBase: CGFloat = 11

extension FudaViewController {
    internal func layoutFudaScreen() {
        setTatamiBackground()
        setFudaView()
        setWhiteBackView()
        setLabels15()
    }
    
    private func setTatamiBackground() {
        let image = UIImage(named: "tatami_moved.jpg")
        let tatamiView = UIImageView(image: image)
        view.addSubview(tatamiView)
        tatamiView.frame = view.bounds
        self.tatamiView = tatamiView
    }
    
    private func setFudaView() {
        guard let tatamiView = self.tatamiView else { return }
        let image = UIImage(named: "washi_darkgreen 001.jpg")
        let greenBackView = UIImageView(image: image)
        let height = fudaHeight()
        self.fudaPower = height / fudaHeightMeasured
        greenBackView.frame.size = CGSize(width: fudaWidthMeasured * fudaPower, height: height)
        greenBackView.center = CGPoint(x: view.center.x, y: view.center.y + topOffset() / 2.0)
        tatamiView.addSubview(greenBackView)
        self.fudaView = greenBackView
    }
    
    private func setWhiteBackView() {
        guard let greenBackView = self.fudaView else { return }
        let superViewHeight = greenBackView.frame.height
        let superViewWidth = greenBackView.frame.width
        let offset = greenOffsetMeasured * fudaPower
        let whiteBackView = UIView(frame: CGRect(
            x: offset, y: offset,
            width: superViewWidth - 2 * offset,
            height: superViewHeight - 2 * offset)).then {
                $0.backgroundColor = UIColor(hex: "FFF7E5")
                greenBackView.addSubview($0)
        }
        self.whiteBackView = whiteBackView
    }
    
    private func setLabels15() {
        let strArray = (shimoString + "  ").splitInto(1)
        for idx in 0..<15 {
            let label = UILabel().then {
                $0.text = strArray[idx]
                $0.font = fudaFont?.withSize(fudaFontSize())
                $0.textAlignment = .center
                $0.frame = CGRect(origin: labelOriginOf(idx),
                                  size: labelSize())
                $0.accessibilityLabel = "fudaChar_\(idx)"
                $0.textColor = .black
                fudaView.addSubview($0)
            }
            self.labels15.append(label)
        }
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
    
    private func fudaFontSize() -> CGFloat {
        return fudaFontSizeBase * fudaPower
    }
    
    private func labelOriginOf(_ index: Int) -> CGPoint{
        return CGPoint(x: labelOriginZero().x + labelSize().width * CGFloat(columnNumberOf(labelIndex: index )),
                       y: labelOriginZero().y + labelSize().height * CGFloat((index % 5)))
    }
    
    private func columnNumberOf(labelIndex: Int) -> Int {
        switch labelIndex {
        case 0..<5:
            return 2
        case 5..<10:
            return 1
        default:
            return 0
        }
    }
    
    private func labelSize() -> CGSize {
        return CGSize(width: whiteBackView.frame.width / 3,
                      height: whiteBackView.frame.height / 5)
    }
    
    private func labelOriginZero() -> CGPoint {
        return CGPoint(x: greenOffsetMeasured * fudaPower,
                       y: greenOffsetMeasured * fudaPower)
    }
}



