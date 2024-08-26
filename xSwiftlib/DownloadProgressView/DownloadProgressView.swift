//
//  DownloadProgressView.swift
//  wedevotebible
//
//  Created by 杜文泽 on 2022/2/9.
//  Copyright © 2022 WD Bible Team. All rights reserved.
//

import Foundation
import UIKit

@objc public enum DownloadState: Int {
    /** 最开始 无状态 */
    case unknow = 0
    /** 下载暂停 */
    case paused
    /** 正在下载 */
    case downloading
    /** 下载成功 */
    case succeed
    /** 队列等待 */
    case pending
    /** 下载失败 */
    case failed
    /** 不可下载 */
    case disabled
    /** 下载过（但未下载完）*/
    case downloaded
}

public class DownloadProgressView: UIView {
    
    lazy var stateImage: UIImageView = {
        return UIImageView.init(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    }()

    lazy var progressView: EVCircularProgressView = {
        var progressView = EVCircularProgressView.init(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        progressView.backgroundColor = .clear
        progressView.progressTintColor = _tintColor
        progressView.progressBgTintColor = UIColor.systemGray
        progressView.progressType = ProgressLayerTypeSquare
        progressView.setProgress(0.01, animated: false)
        progressView.isUserInteractionEnabled = false
        progressView.isHidden = true // 默认不显示
        return progressView
    }()
    
    private var _tintColor: UIColor = UIColor.systemBlue
    public override var tintColor: UIColor? {
        get {
            return _tintColor
        }
        set {
            xTask.executeMain {
                self._setTint(newValue)
            }
        }
    }
    private func _setTint(_ newValue: UIColor?) {
        _tintColor = newValue ?? UIColor.systemBlue
        progressView.progressTintColor = _tintColor
        if let image = stateImage.image {
            stateImage.image = image.tint(color: _tintColor)
        }
    }
    
    private var _downloadState: DownloadState = .unknow
    var downloadState: DownloadState {
        get {
            _downloadState
        }
        set {
            xTask.executeMain {
                self._setDownloadState(newValue)
            }
        }
    }
    private func _setDownloadState(_ newValue: DownloadState) {
        let oldValue = _downloadState
        _downloadState = newValue
        if _downloadState == .unknow {
            stateImage.isHidden = false
            stateImage.image = UIImage.init(named: "ic_download_wait")?.tint(color: _tintColor)
            progressView.isHidden = true
            self.progress = 0.01
        }
        else if _downloadState == .pending ||
                _downloadState == .downloading {
            stateImage.isHidden = true
            progressView.isHidden = false
            self.progressView.progressType = ProgressLayerTypeSquare
            if oldValue == .paused && self.progress == 0.01 {
                self.progress = 0 // start the indeterminate animation
            }
        }
        else if _downloadState == .paused {
            stateImage.isHidden = true
            progressView.isHidden = false
            self.progressView.progressType = ProgressLayerTypePause
            if self.progress == 0 {
                self.progress = 0.01 // stop the indeterminate animation
            }
        }
        else if _downloadState == .succeed {
            stateImage.isHidden = false
            stateImage.image = UIImage.init(named: "ic_downloaded")?.tint(color: _tintColor)
            progressView.isHidden = true
            self.progress = 0.01
        }
        else if _downloadState == .downloaded {
            // 以前下载过但未下载完
            stateImage.isHidden = false
            stateImage.image = UIImage.init(named: "ic_download")?.tint(color: _tintColor)
            progressView.isHidden = true
            self.progress = 0.01
        }
        else {
            // .fail, .disabled
            stateImage.isHidden = false
            stateImage.image = UIImage.init(named: "ic_download_wait")?.tint(color: _tintColor)
            progressView.isHidden = true
            self.progress = 0.01
        }
        stateImage.alpha = _downloadState == .disabled ? 0.3 : 1
    }

    private var _progress: Double = 0.01
    var progress: Double {
        get {
            _progress
        }
        set {
            xTask.executeMain {
                self._setProgress(newValue)
            }
        }
    }
    private func _setProgress(_ newValue:Double) {
        _progress = newValue
        self.progressView.setProgress(Float(newValue), animated: false)
    }

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        self.backgroundColor = .clear

        self.addSubview(self.progressView)
        self.addSubview(self.stateImage)
        
        self.progressView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
        self.stateImage.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
