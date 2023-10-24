//
//  IntrinsicContentSizeController.swift
//  xSwiftlib
//
//  Created by pwrd on 2023/9/30.
//

import SnapKit


class IntrinsicTableViewCellController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.tableView.reloadData()
        
        self.tableView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(AutoSizeCell.self, forCellReuseIdentifier: "AutoSizeCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    lazy var testCell: AutoSizeCell = {
        let cell = AutoSizeCell(style: .default, reuseIdentifier: "AutoSizeCell")
        WMTask.asyncMain(after: 3) {
            // 高增加一倍，测试tableView是否响应
            cell.sizeWiseView.customSize = CGSizeMake(200, 300)
            
            // A.
            UIView.performWithoutAnimation {
                self.tableView.reloadRow(at: IndexPath(row: 0, section: 0), with: .none)
            }
            // B. 更通用的代码：
//            if let tableView = cell.superview as? UITableView,
//                let path = tableView.indexPath(for: cell) {
//                    UIView.performWithoutAnimation {
//                        tableView.reloadRow(at: path, with: .none)
//                    }
//            }
            
            // C. 对低版本iOS无效
//            cell.invalidateIntrinsicContentSize()
        }
        return cell;
    }()
    
    //MARK: - UITableView delegate & dataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.testCell
        /** 下面2句对于低版本iOS需要，否则可能无法自动根据内容撑起cell的高度 */
        if cell.frame.width != tableView.bounds.width {
            cell.frame = CGRectMake(0, 0, tableView.bounds.width, 0)
            cell.layoutIfNeeded()
        }
        return cell
    }
}

class AutoSizeCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(self.sizeWiseView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sizeWiseView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    lazy var sizeWiseView: SizewiseView = {
        let view = SizewiseView.init()
        view.backgroundColor = .purple
        return view
    }()
}
