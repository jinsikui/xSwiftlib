//
//  ScrollViewTestController.swift
//  xSwiftlib
//
//  Created by pwrd on 2022/12/15.
//

import UIKit

class ScrollViewTestController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "contentOffset重置问题"
        self.view.backgroundColor = xColor.fromRGB(0xFFFFFF)
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.addSubview(self.box)
        self.box.addSubview(self.scroll)
        self.scroll.addSubview(self.panel)
        self.panel.addSubview(self.view1)
        self.panel.addSubview(self.view2)
        
        self.box.mas_remakeConstraints { make in
            make?.left.mas_equalTo()(20)
            make?.right.mas_equalTo()(-20)
            make?.top.mas_equalTo()(20)
            make?.height.mas_equalTo()(500)
        }
        self.scroll.mas_remakeConstraints { make in
            make?.edges.mas_equalTo()(0)
        }
        self.panel.mas_remakeConstraints { make in
            make?.edges.mas_equalTo()(self.scroll)
            make?.width.mas_equalTo()(xDevice.screenWidth())
            make?.height.mas_equalTo()(700)
        }
        self.view1.mas_remakeConstraints { make in
            make?.left.mas_equalTo()(0)
            make?.top.mas_equalTo()(0)
            make?.right.mas_equalTo()(0)
            make?.height.mas_equalTo()(200)
        }
        self.view2.mas_remakeConstraints { make in
            make?.left.mas_equalTo()(0)
            make?.top.mas_equalTo()(self.view1.mas_bottom)
            make?.right.mas_equalTo()(0)
            make?.height.mas_equalTo()(500)
        }
        
        xTask.asyncMain(after: 5) {
            // 运行之后，看scrollview.contentOffset会重置为0
            self.box.mas_remakeConstraints { make in
                make?.left.mas_equalTo()(20)
                make?.right.mas_equalTo()(-20)
                make?.top.mas_equalTo()(20)
                make?.height.mas_equalTo()(700)
            }
        }
    }
    
    private lazy var box: UIView = {
        let box = UIView.init()
        box.clipsToBounds = true
        return box
    }()

    private lazy var scroll:UIScrollView = {
        let scroll = UIScrollView.init()
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.layer.cornerRadius = 12
        scroll.bounces = false
        return scroll
    }()
    
    private lazy var panel: UIView = {
        let box = UIView.init()
        box.backgroundColor = UIColor.gray
        box.layer.cornerRadius = 12
        box.clipsToBounds = true
        return box
    }()
    
    private lazy var view1: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.orange
        return view
    }()
    
    private lazy var view2: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.brown
        return view
    }()
}
