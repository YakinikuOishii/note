//
//  CarouselView.swift
//  note
//
//  Created by 笠原未来 on 2018/10/04.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit

class CarouselView: UICollectionView {
    
    let cellIdentifier = "carousel"
    let pageCount = 4
    let isInfinity = true
    
    var cellItemsWidth: CGFloat = 0.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 画面内に表示されているセルを取得
        let cells = self.visibleCells
        for cell in cells {
            // ここでセルのScaleを変更する
            transformScale(cell: cell)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.register(CarouselCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    convenience init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: frame.height / 2)
        layout.scrollDirection = .horizontal

        self.init(frame: frame, collectionViewLayout: layout)
        // 水平方向のスクロールバーを非表示にする
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.white
    }
    
    func transformScale(cell: UICollectionViewCell) {
        // 計算してスケールを変更する
        let cellCenter:CGPoint = self.convert(cell.center, to: nil) // セルの中心
        let screenCenterX:CGFloat = UIScreen.main.bounds.width / 2
        let cellCenterDisX:CGFloat = abs(screenCenterX - cellCenter.x) //中心までの距離
        let reductionRatio:CGFloat = -0.0005 // 縮小率
        let maxScale:CGFloat = 1 // 最大値
        let newScale = reductionRatio * cellCenterDisX + maxScale // スケール
        cell.transform = CGAffineTransform(scaleX:newScale, y:newScale)
    }
    
    // 初期位置を真ん中にする
    func scrollToFirstItem() {
        self.layoutIfNeeded()
//        if isInfinity {
            self.scrollToItem(at:IndexPath(row: 0, section: 0) , at: .centeredHorizontally, animated: false)
//        }
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension CarouselView: UICollectionViewDelegate {
    // セクションごとのセル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return isInfinity ? pageCount * 3 : pageCount
        return pageCount
    }
}

extension CarouselView: UICollectionViewDataSource {
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.contentView.backgroundColor = UIColor.green
        return cell
    }
}

extension CarouselView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//         画面内に表示されているセルを取得
//        let cells = self.visibleCells
//        for cell in cells {
//            // ここでセルのScaleを変更する
//            transformScale(cell: cell)
//        }
    }
    
}
