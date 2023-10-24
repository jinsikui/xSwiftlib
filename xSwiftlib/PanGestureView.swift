//
//  PanGestureView.swift
//  Ai-English
//
//  Created by JSK on 2023/1/30.
//  Copyright © 2023 iOS. All rights reserved.
//

import UIKit

class PanGestureViewModel: NSObject {
    
    /// 本轮单词列表
    var wordList:[String] = []
    /// 在弹窗中标熟的单词列表（等弹窗收起时统一给外界处理）
    var newMasterWordList:[String] = []
    /// 滑动结束弹窗关闭将新标熟的词上报外界
    var commitNewMasteredCallback:(([String]) -> ())?
    
    func commitNewMasteredWords() {
        if let callback = commitNewMasteredCallback {
            callback(newMasterWordList)
        }
    }
}



class PanGestureView: UIView, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private var model: PanGestureViewModel
    
    private var panBeginPoint:CGPoint = .zero
    private var panBeginRight:CGFloat = 0
    private var panLastPoint:CGPoint = .zero
    private var panCurrentPoint:CGPoint = .zero
    private var panLastDate:Date? = nil
    private var panCurrentDate:Date? = nil
    private var wordListViewWidth:CGFloat = 295
    private var wordListViewRight:CGFloat = 0
    private var panGesture:UIPanGestureRecognizer? = nil
    private var isAnimating:Bool = false
    private var tapGesture:UITapGestureRecognizer? = nil
    
    private lazy var wordListView:UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.contentInsetAdjustmentBehavior = .never
        if #available(iOS 13.0, *) {
            tableView.automaticallyAdjustsScrollIndicatorInsets = false
        }
        tableView.register(LearningWordListCell.self, forCellReuseIdentifier: LearningWordListCell.className())
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.estimatedRowHeight = 70
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var headerView:UIView = {
        let view = LearningWordListHeader(self.model)
        return view
    }()
    
    init(model: PanGestureViewModel) {
        self.model = model
        super.init(frame: .zero)
        self.tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(actionSpaceTapped))
        self.tapGesture?.delegate = self
        self.addGestureRecognizer(self.tapGesture!)
        self.addSubview(self.wordListView)
        self.wordListView.reloadData()
        self.backgroundColor = .gray
        self.isHidden = self.wordListViewRight <= 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.wordListView.mas_remakeConstraints { make in
            make?.top.mas_equalTo()(0)
            make?.bottom.mas_equalTo()(0)
            make?.width.mas_equalTo()(wordListViewWidth)
            make?.right.mas_equalTo()(self.mas_left)?.offset()(self.wordListViewRight)
        }
    }
    
    override func didMoveToSuperview() {
        if let superView = self.superview {
            self.panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(actionHandlePanGesture(ges:)))
            self.panGesture?.delegate = self
            superView.addGestureRecognizer(self.panGesture!)
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if let superview = self.superview, newSuperview == nil, let gesture = self.panGesture {
            superview.removeGestureRecognizer(gesture)
        }
    }
    
    @objc func actionSpaceTapped() {
        self.wordListViewRight = 0
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.isHidden = true
        self.model.commitNewMasteredWords()
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGesture {
            if isAnimating {
                return false
            }
            return true
        }
        else if gestureRecognizer == self.tapGesture {
            if gestureRecognizer.location(in: self).x >= self.wordListViewRight {
                return true
            }
            return false
        }
        return true
    }
    
    @objc func actionHandlePanGesture(ges:UIPanGestureRecognizer) {
        if ges.state == .began {
            panBeginPoint = ges.translation(in: nil)
            panBeginRight = self.wordListViewRight
            panLastPoint = panBeginPoint
            panCurrentPoint = panBeginPoint
            panLastDate = Date()
            panCurrentDate = Date()
        }
        else if ges.state == .changed {
            panLastPoint = panCurrentPoint
            panCurrentPoint = ges.translation(in: nil)
            panLastDate = panCurrentDate
            panCurrentDate = Date()
            let deltaX: CGFloat = panLastPoint.x - panBeginPoint.x
            var right = panBeginRight + deltaX
            right = right > wordListViewWidth ? wordListViewWidth : right < 0 ? 0 : right
            self.wordListViewRight = right
            self.setNeedsLayout()
            self.layoutIfNeeded()
            self.isHidden = right <= 0
        }
        else {
            guard let lastDate = panLastDate else { return }
            let panEndPoint = ges.translation(in: nil) // 应该就等于上次.changed时赋值的panCurrentPoint
            let now = Date()
            let deltaX: CGFloat = panEndPoint.x - panLastPoint.x
            let isShow: Bool = deltaX > 0 ? true : deltaX < 0 ? false : self.wordListViewRight > 100 ? true : false
            let targetRight: CGFloat = isShow ? wordListViewWidth : 0
            let targetDistance: CGFloat = abs(targetRight - self.wordListViewRight)
            if targetDistance > 0 {
                let deltaDistance = abs(deltaX)
                let deltaTime = now.timeIntervalSince(lastDate)
                var targetTime:TimeInterval = 0
                if deltaDistance <= 0 {
                    targetTime = 0.5
                }
                else {
                    targetTime = targetDistance * deltaTime / deltaDistance
                }
                targetTime = targetTime > 0.5 ? 0.5 : targetTime < 0.1 ? 0.1 : targetTime
                self.wordListViewRight = targetRight
                self.setNeedsLayout()
                self.isAnimating = true
                UIView.animate(withDuration: targetTime, animations: {
                    self.layoutIfNeeded()
                }, completion: { success in
                    self.isAnimating = false
                    self.isHidden = isShow ? false : true
                    if !isShow {
                        self.model.commitNewMasteredWords()
                    }
                })
            }
            else {
                if !isShow {
                    self.model.commitNewMasteredWords()
                }
            }
            panLastDate = nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LearningWordListCell.className(), for: indexPath)
        (cell as! LearningWordListCell).refresh(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.headerView.setNeedsLayout()
        self.headerView.layoutIfNeeded()
        return self.headerView
    }
}

class LearningWordListHeader: UIView {
        
    private var model: PanGestureViewModel
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.pingFangSCRegular(12)
        label.text = "1秒想起标记熟，标熟后不再学习"
        return label
    }()
    
    init(_ model: PanGestureViewModel) {
        self.model = model
        super.init(frame: .zero)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleLabel)
        self.backgroundColor = UIColor.brown
        self.titleLabel.attributedText = self.makeTitleAttr()
        self.subTitleLabel.textColor = QBColorHex("#7A7E9D")
    }
    
    private func makeTitleAttr() -> NSAttributedString {
        let attr = NSMutableAttributedString.init()
        attr.append(NSAttributedString.init(string: "本组学习", attributes: [NSAttributedString.Key.font : UIFont.pingFangSCRegular(16),
                                                                         NSAttributedString.Key.foregroundColor : QBColorHex("#19263A")!]))
        attr.append(NSAttributedString.init(string: "(\(self.model.wordList.count)词)", attributes: [NSAttributedString.Key.font : UIFont.pingFangSCSemibold(16),
                                                                                                    NSAttributedString.Key.foregroundColor : QBColorHex("#7A7E9D")!]))
        return attr
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.snp.remakeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(xDevice.statusBarHeight() + 14)
        }
        self.subTitleLabel.snp.remakeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.bottom.equalTo(self).offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LearningWordListCell: UITableViewCell {
    
    private lazy var view:UIView = {
        let view = UIView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refresh(index: Int) {
        var height: CGFloat = 50
        if index == 0 {
            self.view.backgroundColor = .purple
            height = 50
        }
        else if index == 1 {
            self.view.backgroundColor = .brown
            height = 80
        }
        else {
            self.view.backgroundColor = .darkGray
            height = 30
        }
        self.view.snp.remakeConstraints { make in
            make.left.right.top.equalTo(0)
            make.height.equalTo(height)
            make.bottom.equalTo(-20)
        }
    }
    
}
