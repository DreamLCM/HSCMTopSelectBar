//
//  HSCMTopSelectBarView.swift
//  HSCMTopSelectBar
//
//  Created by Cimons on 2020/5/18.
//  Copyright © 2020 Cimons. All rights reserved.
//

//
//  HSCMTopSelectBarView.swift
//  HSCMTopSelectBar
//
//  Created by Cimons on 2020/5/18.
//  Copyright © 2020 Cimons. All rights reserved.
//

import UIKit

/// 数据源代理
public protocol HSCMTopSelectBarViewDataSource : NSObjectProtocol {
    func topSelectBarViewArrayTitle() -> [String]
}

/// 点击代理
@objc public protocol HSCMTopSelectBarViewDelegate : AnyObject {
     
    func topDidSelectBarView(didSelectItemAt index: Int)
    @objc optional func topShouldSelectBarView(didSelectItemAt index: Int) -> Bool
}




open class HSCMTopSelectBar: UIView {

    /// collectionView
    private lazy var collectionViewSelectContent: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionViewTemp = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60), collectionViewLayout: collectionViewLayout)
        collectionViewTemp.backgroundColor = .clear
       
        let url = Bundle(for: type(of: self)).url(forResource: "HSCMTopSelectBar", withExtension: "bundle")
        collectionViewTemp.register(UINib(nibName: "CMTopSelectBarCell", bundle:
        Bundle(url: url!)), forCellWithReuseIdentifier: "CMTopSelectBarCell")
        
        collectionViewTemp.isScrollEnabled = false
        collectionViewTemp.delegate = self
        collectionViewTemp.dataSource = self
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        return collectionViewTemp
    }()
    
    /// 当前选择的item
    public var currentSelectItem = 0 {
        didSet {
            collectionViewSelectContent.reloadData()
        }
    }
    /// 选择的颜色
    public var selectColor = UIColor(red: 84/255.0, green: 93/255.0, blue: 255/255.0, alpha: 1.0)
    /// 未选的颜色
    public var noSelectColor = UIColor(red: 168/255.0, green: 171/255.0, blue: 180/255.0, alpha: 1.0)
    /// 分割线
    private let viewDividingLine = UIView()
    /// 分割线颜色
    private let colorDividingLine = UIColor(red: 229/255.0, green: 229/255.0, blue: 229/225.0, alpha: 1.0)
    /// 放大倍数
    private let transformNum: CGFloat = 1.4
    /// 标题标签，有多少个就传多少个
    public var arraySelectTitle = [String]() {
        didSet {
            collectionViewSelectContent.reloadData()
        }
    }
    
    weak open var delegate: HSCMTopSelectBarViewDelegate?
    weak open var dataSource: HSCMTopSelectBarViewDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        viewDividingLine.backgroundColor = colorDividingLine
        addSubview(viewDividingLine)
        addSubview(collectionViewSelectContent)
    
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension HSCMTopSelectBar: UICollectionViewDataSource,
                            UICollectionViewDelegate,
                            UICollectionViewDelegateFlowLayout {
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(UIScreen.main.bounds.width)/arraySelectTitle.count, height: 60)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataSource = dataSource {
            arraySelectTitle = dataSource.topSelectBarViewArrayTitle()
            return arraySelectTitle.count
        } else {
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard let cmTopSelectBarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CMTopSelectBarCell", for: indexPath) as? CMTopSelectBarCell else {
            return UICollectionViewCell()
        }
        cmTopSelectBarCell.labelTitle.text = arraySelectTitle[indexPath.item]

        if indexPath.item == currentSelectItem {
            configCell(cmTopSelectBarCell, transformNum: transformNum, colorStroke: selectColor)
        } else {
            configCell(cmTopSelectBarCell, transformNum: 1, colorStroke: noSelectColor)
        }
        return cmTopSelectBarCell
        
    }
    
    ///     配置不同样式的cell
    func configCell(_ cell: CMTopSelectBarCell, transformNum: CGFloat, colorStroke: UIColor) {
        cell.labelTitle.transform = CGAffineTransform(scaleX: transformNum, y: transformNum)
        cell.labelTitle.textColor = colorStroke
        cell.viewTopBarSelectMark.colorStroke = colorStroke
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            
        collectionView.visibleCells.forEach { (cell) in
            let wCell = cell.frame.size.width
            viewDividingLine.frame = CGRect(x: wCell/2, y: 34, width: wCell*CGFloat((arraySelectTitle.count-1)), height: 0.5)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let delegate = delegate {
            return delegate.topShouldSelectBarView?(didSelectItemAt: indexPath.item) ?? true
        } else {
            return true
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.topDidSelectBarView(didSelectItemAt: indexPath.item)
        }
        currentSelectItem = indexPath.item
        collectionView.reloadData()
    }
}
