//
//  PageTitleView.swift

//  Created  on 2016/11/6.
//  CopyrightAll rights reserved.
//

import UIKit

protocol  PageTitleViewDelegate: class {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int)
}

private let kNormalColor: UIColor = AppColor.SegmentBar.unSelectedTitle
private let kSelectColor: UIColor = AppColor.SegmentBar.selectedTitle
private let kNormalFont: UIFont = UIFont.poppins(font: .regular, size: .pt14)
private let kSelectFont: UIFont = UIFont.poppins(font: .semiBold, size: .pt14)

private let kScrollLineH: CGFloat = 4
private let lineH: CGFloat = 0.5
class PageTitleView: UIView {
    weak var delegate: PageTitleViewDelegate?
   // fileprivate var currentLabelIndex :Int = 0
     var currentLabelIndex: Int = 1

    fileprivate var titles: [String]
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView ()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    /*fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = App_Color
        return scrollLine
    }()
    */
     lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.white
        return scrollLine
    }()
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
          super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView {
    fileprivate func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLabels()
        setupBottomAndLine()
    }
    fileprivate func setupTitleLabels() {
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title.localized()
            label.tag = index
            label.font = kNormalFont
              label.textColor = kNormalColor
            label.textAlignment = .center
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    fileprivate func setupBottomAndLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.white
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        guard let firstLabel = titleLabels.first else { return }
          firstLabel.textColor = kSelectColor
          firstLabel.font = kSelectFont
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x+firstLabel.frame.width*0.1, y: frame.height-kScrollLineH, width: firstLabel.frame.width*0.8, height: kScrollLineH)
    }
}

// MARK: - Add gesture
extension PageTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
        guard let currentLabel = tapGes.view as? UILabel else { return }
        if currentLabel.tag == currentLabelIndex { return }
        let oldLabel = titleLabels[currentLabelIndex]
        currentLabel.textColor = kSelectColor
        oldLabel.textColor = kNormalColor
        currentLabel.font = kSelectFont
        oldLabel.font = kNormalFont
        currentLabelIndex = currentLabel.tag
//        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        let scrollLinePosition = currentLabel.frame.origin.x + currentLabel.frame.width * 0.1
        scrollLine.frame.size.width = currentLabel.frame.width * 0.8
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollLine.frame.origin.x = scrollLinePosition//X
        })
        delegate?.pageTitleView(self, selectedIndex: currentLabelIndex)
    }
}

extension PageTitleView {
    func setTitleWithProgress(_ progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + sourceLabel.frame.width*0.1 + moveX
        sourceLabel.textColor = kNormalColor
        targetLabel.textColor = kSelectColor
        sourceLabel.font = kNormalFont
        targetLabel.font = kSelectFont
        currentLabelIndex = targetIndex
    }
}
