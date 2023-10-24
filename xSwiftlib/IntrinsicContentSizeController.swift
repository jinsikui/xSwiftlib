//
//  IntrinsicContentSizeController.swift
//  xSwiftlib
//
//  Created by pwrd on 2023/9/30.
//

import SnapKit


class IntrinsicContentSizeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.viewBox)
        
        self.viewBox.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        WMTask.asyncMain(after: 10) {
            // 实测，设置这里后，会依次触发`IntrinsicContentSizeController.viewDidLayoutSubviews()`和`ViewBox.layoutSubviews()`
            // 并且布局尺寸会立刻改变，无需手动触发layoutSubviews()
            self.viewBox.view1.customSize = CGSizeMake(100, 200)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    lazy var viewBox: ViewBox = {
        let view = ViewBox()
        return view
    }()
}

class ViewBox: UIView {
    
    init() {
        super.init(frame: .zero)
        addSubview(self.view1)
        addSubview(self.view2)
        addSubview(self.view3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.view1.snp.remakeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(100)
        }
        self.view2.snp.remakeConstraints { make in
            make.left.equalTo(self.view1)
            make.top.equalTo(self.view1.snp.bottom)
            make.size.equalTo(CGSizeMake(50, 50))
        }
        self.view3.snp.remakeConstraints { make in
            make.left.equalTo(self.view1.snp.right)
            make.bottom.equalTo(self.view1.snp.bottom)
            make.size.equalTo(CGSizeMake(50, 50))
        }
    }
    
    lazy var view1: SizewiseView = {
        let view = SizewiseView()
        view.backgroundColor = .purple
        return view
    }()
    
    lazy var view2: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var view3: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
}

class SizewiseView: UIView {
    
    var customSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    init() {
        self.customSize = CGSizeMake(200, 150)
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return self.customSize
        }
    }
    
}
