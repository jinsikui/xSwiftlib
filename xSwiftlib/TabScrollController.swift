//
//  TabScrollController.swift
//  xSwiftlib
//
//  Created by JSK on 2022/12/8.
//

import UIKit
import JXCategoryView
import ReactiveCocoa
import ReactiveSwift
import SnapKit


@objc class TestTabContentView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TestTabContentViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.red : UIColor.green
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
    private var _contentHeight:CGFloat = 0
    var contentHeight:CGFloat {
        set {
            _contentHeight = newValue
            if self.scrollView.isKind(of: WordDetailScrollView.self) {
                self.layoutTestView()
            }
        }
        get {
            return _contentHeight
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.scrollView)
        if let tableView = self.scrollView as? UITableView {
            tableView.reloadData()
        }
        else if let collectionView = self.scrollView as? UICollectionView {
            collectionView.reloadData()
        }
        else if let _ = self.scrollView as? WordDetailScrollView {
            self.scrollView.addSubview(self.testView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    lazy var scrollView:WordDetailTableView = {
//        let tableView = WordDetailTableView.init(frame: .zero, style: .plain)
//        tableView.separatorStyle = .none
//        tableView.showsVerticalScrollIndicator = true
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TestTabContentViewCell")
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.contentInsetAdjustmentBehavior = .never
//        return tableView
//    }()
    
    lazy var scrollView:WordDetailScrollView = {
        let scrollView = WordDetailScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var testView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.purple
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutScrollView()
        if self.scrollView.isKind(of: WordDetailScrollView.self) {
            self.layoutTestView()
        }
    }
    
    func layoutScrollView() {
        self.scrollView.snp.remakeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    func layoutTestView() {
        self.testView.snp.remakeConstraints { make in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.bounds.width)
            make.height.equalTo(self.contentHeight)
        }
    }
}

class TabScrollController: UIViewController, JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, UIScrollViewDelegate {

    private var scrollContentHeight:MutableProperty<CGFloat> = .init(0)
    private var scrollContentWidth:MutableProperty<CGFloat> = .init(0)
    private var scrollViewHeight:MutableProperty<CGFloat> = .init(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "吸顶效果"
        self.view.backgroundColor = xColor.fromRGB(0xFFFFFF)
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.addSubview(self.meaningView)
        self.view.addSubview(self.scroll)
        self.scroll.addSubview(self.panel)
        self.panel.addSubview(self.exampleView)
        self.panel.addSubview(self.tabHeaderView)
        self.panel.addSubview(self.tabView)
        let navAreaHeight:CGFloat = xDevice.statusBarHeight() + xDevice.navBarHeight()
        let scrollViewHeight:CGFloat = xDevice.screenHeight() - navAreaHeight - 20/*meaningView top*/ - 80/*meaningView height*/ - 60/*bottom margin*/
        print("scrollViewHeight: \(scrollViewHeight)");
        let contentWidth:CGFloat = xDevice.screenWidth() - 40
        let contentHeight:CGFloat = scrollViewHeight + 80/*exampleView height*/ + 50/*外层滚动余量*/
        self.scrollContentWidth.value = contentWidth
        self.scrollContentHeight.value = contentHeight
        self.scrollViewHeight.value = scrollViewHeight
        
        self.meaningView.snp.remakeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(20)
            make.height.equalTo(80)
        }
        self.layoutScroll()
        self.layoutPanel()
        self.exampleView.snp.remakeConstraints { make in
            make.left.top.right.equalTo(0)
            make.height.equalTo(80)
        }
        self.tabHeaderView.snp.remakeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(self.exampleView.snp.bottom)
            make.height.equalTo(20)
        }
        self.tabView.snp.remakeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(self.tabHeaderView.snp.bottom)
        }
        
        self.scrollContentHeight.producer.observe(on: UIScheduler()).startWithValues { _ in
            self.layoutPanel()
        }
        self.scrollViewHeight.producer.observe(on: UIScheduler()).startWithValues { _ in
            self.layoutScroll()
        }
        
        self.phraseView.scrollView.isScrollEnabled = false
        NotificationCenter.default.reactive.notifications(forName: NSNotification.Name.WordDetailShouldScroll).take(during: self.reactive.lifetime).observe(on: UIScheduler()).observeValues { [weak self] _ in
            print("tabscroll: received WordDetailShouldScroll set phraseView.scrollView.isScrollEnabled to false")
            self?.phraseView.scrollView.isScrollEnabled = false
        }
    }
    
    func layoutScroll() {
        self.scroll.snp.remakeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(self.meaningView.snp.bottom)
            make.height.equalTo(self.scrollViewHeight.value)
        }
    }
    
    func layoutPanel() {
        self.panel.snp.remakeConstraints { make in
            make.edges.equalTo(self.scroll)
            make.width.equalTo(self.scrollContentWidth.value)
            make.height.equalTo(self.scrollContentHeight.value)
        }
    }
    
    
    private lazy var meaningView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private lazy var scroll:UIScrollView = {
        let scroll = UIScrollView.init()
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.backgroundColor = UIColor.yellow
        scroll.showsVerticalScrollIndicator = false
        scroll.layer.cornerRadius = 12
        scroll.delegate = self
        return scroll
    }()
    
    private lazy var panel: UIView = {
        let view = UIView.init()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var exampleView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.systemOrange
        return view
    }()

    /// tab header
    private lazy var tabHeaderView:JXCategoryTitleView = {
        let header = JXCategoryTitleView()
        header.delegate = self
        header.backgroundColor = UIColor.clear
        header.titles = ["词组", "词根", "派生词"]
        // 和tabView关联
        header.listContainer = self.tabView
        header.titleFont = xFont.regularPF(withSize: 12)
        header.titleSelectedFont = xFont.mediumPF(withSize: 12)
        header.titleColor = xColor.fromRGB(0x7A7E9D)
        header.titleSelectedColor = xColor.fromRGB(0x19263A)
        header.isSelectedAnimationEnabled = false
        header.cellWidthIncrement = 16
        header.cellSpacing = 12
        header.isAverageCellSpacingEnabled = false
        header.contentEdgeInsetLeft = 0
        header.contentEdgeInsetRight = 0
        let indicator = self.tabIndicator
        indicator.indicatorColor = UIColor.init(white: 0, alpha: 0.2)
        indicator.indicatorHeight = 20
        indicator.indicatorWidthIncrement = 0
        header.indicators = [indicator]
        header.reloadData()
        return header
    }()
    private var tabIndicator:JXCategoryIndicatorBackgroundView = JXCategoryIndicatorBackgroundView()
    /// tab内容
    private lazy var tabView:JXCategoryListContainerView = {
        let tabView = JXCategoryListContainerView.init(type: JXCategoryListContainerType.collectionView, delegate: self)!
        tabView.scrollView.backgroundColor = UIColor.clear
        tabView.backgroundColor = UIColor.clear
        tabView.listCellBackgroundColor = UIColor.clear
        tabView.scrollView.isPagingEnabled = true
        return tabView
    }()
    
    private lazy var phraseView : TestTabContentView = {
        let view = TestTabContentView()
        view.contentHeight = 10000
        view.backgroundColor = UIColor.purple
        return view
    }()
    
    private lazy var etymaView : TestTabContentView = {
        let view = TestTabContentView()
        view.contentHeight = 1000
        view.backgroundColor = UIColor.brown
        return view
    }()
    
    private lazy var derivativeView : TestTabContentView = {
        let view = TestTabContentView()
        view.contentHeight = 1000
        view.backgroundColor = UIColor.purple
        return view
    }()
    
    // MARK: - JXCategoryViewDelegate
    
    // 点击选中或者滚动选中都会调用该方法
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
    }
    
    // MARK: - JXCategoryListContainerViewDelegate
    
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return 3
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        if index == 0 {
            return self.phraseView
        }
        else if index == 1 {
            return self.etymaView
        }
        else {
            return self.derivativeView
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    // 滑动过程中
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("tabscroll: scrollViewDidScroll(滑动过程中): offset.y = \(scrollView.contentOffset.y)")
        let offset = scrollView.contentOffset.y
        if offset >= 80 {
            scrollView.setContentOffset(CGPointMake(0, 80), animated: false)
            print("tabscroll: set phraseView.scrollView.isScrollEnabled to true")
            self.phraseView.scrollView.isScrollEnabled = true
//            xTask.asyncMain(after: 3) {
//                self.phraseView.scrollView.isScrollEnabled = false
//            }
        }
        else {
            self.phraseView.scrollView.isScrollEnabled = false
        }
    }
    
    // 开始滑动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("tabscroll: scrollViewWillBeginDragging(开始滑动): offset.y = \(scrollView.contentOffset.y)")
    }
    
    // 抬起手指
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("tabscroll: scrollViewWillEndDragging(抬起手指1): offset.y = \(scrollView.contentOffset.y) withVelocity = \(velocity) targetContentOffset = \(targetContentOffset.pointee)")
//        scrollView.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
    }
    
    // 抬起手指
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("tabscroll: scrollViewDidEndDragging(抬起手指2): offset.y = \(scrollView.contentOffset.y) willDecelerate = \(decelerate)")
    }
    
    // 抬起手指
    // called on finger up as we are moving
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("tabscroll: scrollViewWillBeginDecelerating(抬起手指3): offset.y = \(scrollView.contentOffset.y)")
    }
    
    
    // 停止滑动（手势）
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("tabscroll: scrollViewDidEndDecelerating(停止滑动手势): offset.y = \(scrollView.contentOffset.y)")
    }
    
    // 停止滑动（代码）
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("tabscroll: scrollViewDidEndScrollingAnimation(抬起手指3): offset.y = \(scrollView.contentOffset.y)")
    }

}
