//
//  IsAutoHeightController.swift
//  xSwiftlib
//
//  Created by pwrd on 2023/9/29.
//

import UIKit
import SnapKit


class IsAutoHeightController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)

        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(AutoHeightCell.self, forCellReuseIdentifier: "AutoHeightCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AutoHeightCell", for: indexPath) as! AutoHeightCell
            /** 下面2句对于低版本iOS需要，否则可能无法自动根据内容撑起cell的高度 */
            cell.frame = CGRectMake(0, 0, tableView.bounds.size.width, 0)
            cell.layoutIfNeeded()
            cell.backgroundColor = .purple
            cell.contentView.backgroundColor = .purple
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AutoHeightCell", for: indexPath) as! AutoHeightCell
            /** 下面2句对于低版本iOS需要，否则可能无法自动根据内容撑起cell的高度 */
            cell.frame = CGRectMake(0, 0, tableView.bounds.size.width, 0)
            cell.layoutIfNeeded()
            cell.backgroundColor = .blue
            cell.contentView.backgroundColor = .blue
            return cell
        }
    }
}

class AutoHeightCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(self.listView)
        self.listView.reloadData()
        
        WMTask.asyncMain(after: 2) {
            self.listView.dataList = [NSNumber(40), NSNumber(20), NSNumber(50), NSNumber(40), NSNumber(50), NSNumber(60), NSNumber(60)]
            self.listView.reloadData()
            if let tableView = self.superview as? UITableView {
                if let indexPath = tableView.indexPath(for: self) {
                    tableView.reloadRow(at: indexPath, with: .none)
                }
                // 下面两句仅更新高度，无需reload cell，但是实测会有布局错误: 第二个cell没有正确更新高度
//                tableView.beginUpdates()
//                tableView.endUpdates()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.listView.snp.remakeConstraints { make in
            make.edges.equalTo(self.contentView)
        }
    }
    
    lazy var listView:xCollectionView = {
        let cv = xCollectionView.init(cellClasses: [UICollectionViewCell.self], isLeftAlign: true)
        cv.isAutoHeight = true
        cv.interitemSpace = 10
        cv.lineSpace = 8
        cv.dataList = [NSNumber(10), NSNumber(20), NSNumber(30), NSNumber(40), NSNumber(50), NSNumber(40), NSNumber(30)]
        cv.buildCellCallback = { [weak self] cell, ctx in
            cell.backgroundColor = .white
            cell.contentView.backgroundColor = .white
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            if let label = cell.contentView.viewWithTag(1024) as? UILabel {
                label.text = "\(ctx.data)"
            }
            else {
                let label = UILabel.init()
                label.text = "\(ctx.data)"
                label.tag = 1024
                cell.contentView.addSubview(label)
                label.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }
            }
        }
        cv.itemSizeCallback = { ctx in
            let width = CGFloat((ctx.data as! NSNumber).intValue * 5)
            let height:CGFloat = 30
            return CGSizeMake(width, height)
        }
        return cv
    }()
}
