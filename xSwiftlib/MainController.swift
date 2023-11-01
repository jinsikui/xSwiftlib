

import UIKit
import xUtil
import xUI
import SnapKit
import RxSwift
import SwiftyJSON
import xAPI
import xTracking
import ReactiveSwift
import ReactiveCocoa
import ReactiveObjC
import QMUIKit
import Masonry
import JXCategoryView
import YYKit
import WCDBSwift


@objc enum TestEvent: Int {
    case notNeedShow, show, close
}

class BaseModel: NSObject {
    
    var name:String
    
    init(_ name: String) {
        self.name = name
        super.init()
        self.setup()
    }
    
    func setup() {
        print("BaseModel.setup()")
    }
}

class TestModel: BaseModel {
    
    init() {
        super.init("JSK")
    }
    
    override func setup() {
        super.setup()
        print("TestModel.setup()")
    }
}

class SubModel: NSObject {
    var width:MutableProperty<CGFloat> = .init(0)
}

class MainController: QMUICommonViewController, JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, YYTextParser {

    private var scroll: UIScrollView!
    private var curY: CGFloat = 30
    private var hotSignal: Signal<String, AppError>?
    private var englishLabel: YYLabel?
    var subModel: SubModel = .init()
    var width: MutableProperty<CGFloat> = .init(0)
    let (pipeSignal, pipeSender) = Signal<String, Never>.pipe()
    
    @objc dynamic var prop1: CGFloat = 300
    @objc dynamic var prop2: CGSize = CGSize.init(width: 100, height: 200)
    
    
    lazy var totalHeight1: MutableProperty<CGFloat> = {
        let prop = MutableProperty<CGFloat>.init(0)
        prop <~ SignalProducer.combineLatest(self.reactive.producer(for: \.prop1), self.reactive.producer(for: \.prop2)).map({ (prop1, prop2) in
            print("totalHeight1 calculate by: prop1:\(prop1) prop2:\(prop2)")
            return prop1 + prop2.height
        })
        return prop
    }()
    lazy var totalHeight2: MutableProperty<CGFloat> = {
        let prop = MutableProperty<CGFloat>.init(0)
        prop <~ Signal.combineLatest(self.reactive.signal(for: \.prop1), self.reactive.signal(for: \.prop2)).map({ (prop1, prop2) in
            print("totalHeight2 calculate by: prop1:\(prop1) prop2:\(prop2)")
            return prop1 + prop2.height
        })
        return prop
    }()
    /// 3应该和2一致，因为2 <~尾部的Signal会转成SignalProducer再传给<~的处理程序，就和3完全一致了
    /// 对于2和1比较，虽然2传给combineLatest的signal也会转成producer，但它和1传给combineLatest的producer是完全不同的producer，行为不一样
    lazy var totalHeight3: MutableProperty<CGFloat> = {
        let prop = MutableProperty<CGFloat>.init(0)
        prop <~ SignalProducer.combineLatest(self.reactive.signal(for: \.prop1), self.reactive.signal(for: \.prop2)).map({ (prop1, prop2) in
            print("totalHeight3 calculate by: prop1:\(prop1) prop2:\(prop2)")
            return prop1 + prop2.height
        })
        return prop
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "xSwiftlib"
        self.view.backgroundColor = xColor.fromRGB(0xFFFFFF)
        scroll = UIScrollView()
        if #available(iOS 11.0, *) {
            scroll.contentInsetAdjustmentBehavior = .never
        }
        if #available(iOS 13.0, *) {
            scroll.automaticallyAdjustsScrollIndicatorInsets = false
        }
        self.view.addSubview(scroll)
        scroll.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        self.addButton(text: "Push Main", action: #selector(actionPushMain))
        self.addButton(text: "Promise to Observable", action: #selector(actionPromiseToObservable))
        self.addButton(text: "RAC Property", action: #selector(actionRACProperty))
        self.addButton(text: "hot signal", action: #selector(actionSignal))
        self.addButton(text: "RAC KVO", action: #selector(actionRACKvo))
        self.addButton(text: "RAC Binding1", action: #selector(actionRACBinding1))
        self.addButton(text: "RAC Binding2", action: #selector(actionRACBinding2))
        self.addButton(text: "RAC Binding3", action: #selector(actionRACBinding3))
        self.addButton(text: "RAC hotSignal", action: #selector(actionHotSignal))
        self.addButton(text: "RAC flatMap", action: #selector(actionFlatMap))
        self.addButton(text: "Cha\u{20}rac\u{a0}ter", action: #selector(actionCharacter))
        self.addButton(text: "JXCategoryView", action: #selector(actionJXCategoryView))
        self.addButton(text: "CAGradientLayer", action: #selector(actionCAGradientLayer))
        self.addButton(text: "YYLabel", action: #selector(actionYYLabel))
        self.addButton(text: "image in text", action: #selector(actionImageInText))
        self.addButton(text: "吸顶效果", action: #selector(actionTabScroll))
        self.addButton(text: "offset reset issue", action: #selector(actionOffsetResetIssue))
        self.addButton(text: "RAC Prop Thread", action: #selector(actionRACPropThread))
        self.addButton(text: "Override Test", action: #selector(actionOverrideTest))
        self.addButton(text: "RAC startWithoutSubscribe", action: #selector(actionStartWithoutSubscribe))
        self.addButton(text: "Pipe()", action: #selector(actionPipe))
        self.addButton(text: "Operator", action: #selector(actionOperator))
        self.addButton(text: "pan gesture", action: #selector(actionPanGesture))
        self.addButton(text: "Objc Signal Test", action: #selector(actionObjcSignalTest))
        self.addButton(text: "UnsafePointer", action: #selector(actionUnsafePointer))
        self.addButton(text: "WCDB", action: #selector(actionWCDB))
        self.addButton(text: "Codable Study", action: #selector(actionCodableStudy))
        self.addButton(text: "xCollectionView", action: #selector(actionxCollectionView))
        self.addButton(text: "intrinsicContentSize", action: #selector(actionIntrinsicContentSize))
        self.addButton(text: "intrinsicTableViewCell", action: #selector(actionIntrinsicTableViewCell))
        self.addButton(text: "isAutoHeight", action: #selector(actionIsAutoHeight))
        self.addButton(text: "PropertyWrapper", action: #selector(actionPropertyWrapper))
        self.addButton(text: "swift string", action: #selector(actionSwiftString))
        self.addButton(text: "算法题", action: #selector(actionAlgorithms))
        
        
        self.scroll.contentSize = CGSize.init(width: 0, height: self.curY + 50)
    }

    func addButton(text: String, action: Selector) {
        let btn = xViewFactory.button(withTitle: text, font: xFont.regularPF(withSize: 12), titleColor: xColor.black, bgColor: xColor.clear, borderColor: xColor.black, borderWidth: 0.5)
        btn.addTarget(self, action: action, for: .touchUpInside)
        btn.frame = CGRect.init(x: 0.5 * (xDevice.screenWidth() - 200), y: self.curY, width: 200, height: 40)
        btn.tk_exposeContext = TKExposeContext.init(trackingId: "btn-1", userData: nil)
        scroll.addSubview(btn)
        self.curY += 50
    }
    
    //MARK: -
    
    override func shouldCustomizeNavigationBarTransitionIfHideable() -> Bool {
        return true
    }
    
    override func preferredNavigationBarHidden() -> Bool {
        return false
    }
    
    //MARK: - UINavigationControllerBackButtonHandlerProtocol
    
    override func shouldPopViewController(byBackButtonOrPopGesture byPopGesture: Bool) -> Bool {
        return true
    }
    
    override func forceEnableInteractivePopGestureRecognizer() -> Bool {
        return true
    }
    
    //MARK: -
    
    @objc func actionAlgorithms() {
        let ret = Algorithms.firstMissingPositive([3,4,-1,1])
        print("\(ret)")
    }
    
    
    @LazyOptional var expensiveObj: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        print("expensiveObj is creating ...")
        return view
    }()
    
    @objc func actionSwiftString() {
        let str = "From the beginning of the world"
        // contains substring?
        var find = str.contains("the") // true
        print("\(find)")
        // index of substring
        var intIndex = -1
        if let range = str.range(of: "the") {
            intIndex = str.distance(from: str.startIndex, to: range.lowerBound) // 5, it's the first position of "the"
            print("\(intIndex)")
        }
        // contains substring from index?
        let range = str.range(of: "the", range: (str.index(str.startIndex, offsetBy: 6)..<str.endIndex))
        find = range != nil // true, will find the second "the"
        print("\(find)")
        if let range {
            intIndex = str.distance(from: str.startIndex, to: range.lowerBound) // 22, it's the second position of "the"
            print("\(intIndex)")
        }
        // join strings together
        let strArr = ["I", "love", "you"]
        let joindStr = strArr.joined(separator: "  ") // two spaces -> "I  love  you"
        // split string to strings
        let newArr = joindStr.components(separatedBy: " ") // one space -> ["I", "", "love", "", "you"]
        print("\(newArr)")
        
        // substring by range
        var substr = str[str.startIndex..<str.index(str.startIndex, offsetBy: 4)] // From
        substr = str.prefix(4) // From, same to above
        print("\(substr)")
        
        // Character
        let firstChar = str[str.startIndex] // 'F'
        let firstChar2 = str.first // 'F'
        let equal = firstChar == firstChar2 // true
        print("\(equal)")
        let isStr = firstChar is String // false
        let isCharacter = firstChar is Character // true
        print("isStr: \(isStr) isCharacter: \(isCharacter)")
        
    }
    
    @objc func actionPropertyWrapper() {
        /**
         first call this function:
         self.$expensiveObj is nil?: true
         self._expensiveObj.value is nil?: true
         self._expensiveObj.value == self.$expensiveObj?: true
         expensiveObj is creating ...
         self.$expensiveObj is nil?: false
         self._expensiveObj.value == self.$expensiveObj?: true
         */
        print("self.$expensiveObj is nil?: \(self.$expensiveObj == nil)") // true
        print("self._expensiveObj.value is nil?: \(self._expensiveObj.value == nil)") // true
        print("self._expensiveObj.value == self.$expensiveObj?: \(self._expensiveObj.value == self.$expensiveObj)") // nil == nil true
        let _ = self.expensiveObj // expensiveObj is creating ...
        print("self.$expensiveObj is nil?: \(self.$expensiveObj == nil)") // false
        print("self._expensiveObj.value == self.$expensiveObj?: \(self._expensiveObj.value == self.$expensiveObj)") // true
        
    }
    
    @objc func actionIntrinsicTableViewCell() {
        self.navigationController?.pushViewController(IntrinsicTableViewCellController(), animated: true)
    }
    
    @objc func actionIntrinsicContentSize() {
        self.navigationController?.pushViewController(IntrinsicContentSizeController(), animated: true)
    }
    
    @objc func actionIsAutoHeight() {
        self.navigationController?.pushViewController(IsAutoHeightController(), animated: true)
    }
    
    @objc func actionxCollectionView() {
        let box = UIView()
        box.layer.borderColor = UIColor.purple.cgColor
        box.layer.borderWidth = 1
        box.frame = CGRect(x: 100, y: 100, width: 200, height: 74)
        let cv = self.scoresView
        self.view.addSubview(box)
        self.view.addSubview(cv)
        cv.dataList = [NSNumber(23), NSNumber(89), NSNumber(45)]
        cv.reloadData()
        cv.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(box)
        }
    }
    
    lazy var scoresView:xCollectionView = {
        let cv = xCollectionView.init(cellClass: UICollectionViewCell.self)
        cv.backgroundColor = UIColor.systemPurple
        cv.scrollDirection = .vertical
        cv.interitemSpace = 0
        cv.lineSpace = 0
        cv.buildCellCallback = { [weak self] cell, ctx in
            cell.backgroundColor = UIColor.white
            cell.contentView.backgroundColor = UIColor.white
            if let label = cell.contentView.viewWithTag(1024) as? UILabel {
                label.text = "\(ctx.data)"
            }
            else {
                let label = UILabel.init()
                label.font = xFont.mediumPF(withSize: 14)
                label.textColor = QBColorHex("#19263A")
                label.textAlignment = .center
                label.text = "\(ctx.data)"
                label.tag = 1024
                cell.contentView.addSubview(label)
                label.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview().offset(-9)
                }
            }
            if let label = cell.contentView.viewWithTag(2048) as? UILabel {
                label.text = ctx.indexPath.item == 0 ? "流畅度" : ctx.indexPath.item == 1 ? "完整度" : "准确度"
            }
            else {
                let label = UILabel.init()
                label.font = xFont.mediumPF(withSize: 10)
                label.textColor = QBColorHex("#7A7E9D")
                label.textAlignment = .center
                label.text = ctx.indexPath.item == 0 ? "流畅度" : ctx.indexPath.item == 1 ? "完整度" : "准确度"
                label.tag = 2048
                cell.contentView.addSubview(label)
                label.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.centerY.equalToSuperview().offset(9)
                }
            }
        }
        cv.itemSizeCallback = { [weak cv] ctx in
            guard let cv else { return .zero }
            return CGSizeMake(cv.bounds.width / 3.0 , 74)
        }
        return cv
    }()
    
    @objc func actionCodableStudy() {
        
        class MyEncoder {
            func encode<T: Encodable>(_ value: T) throws -> String {
                let encoder = MyEncoderImplementation()
                try value.encode(to: encoder)
                return encoder.result
            }
        }

        class MyEncoderImplementation: Encoder {
            var codingPath: [CodingKey] = []
            var userInfo: [CodingUserInfoKey : Any] = [:]
            var result: String = ""

            func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
                return KeyedEncodingContainer(KeyedContainer(encoder: self))
            }

            func unkeyedContainer() -> UnkeyedEncodingContainer {
                return UnkeyedContainer(encoder: self)
            }

            func singleValueContainer() -> SingleValueEncodingContainer {
                return SingleValueContainer(encoder: self)
            }
        }

        struct KeyedContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
            var encoder: MyEncoderImplementation

            var codingPath: [CodingKey] = []

            mutating func encodeNil(forKey key: Key) throws {
                encoder.result += "\(key.stringValue): null,"
            }

            mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
                encoder.result += "\(key.stringValue):"
                let nestedEncoder = MyEncoderImplementation()
                try value.encode(to: nestedEncoder)
                encoder.result += nestedEncoder.result + ","
            }

            mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
                fatalError("Not implemented")
            }

            mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
                fatalError("Not implemented")
            }

            mutating func superEncoder() -> Encoder {
                fatalError("Not implemented")
            }

            mutating func superEncoder(forKey key: Key) -> Encoder {
                fatalError("Not implemented")
            }
        }

        struct UnkeyedContainer: UnkeyedEncodingContainer {
            var encoder: MyEncoderImplementation

            var codingPath: [CodingKey] = []

            var count: Int = 0

            mutating func encodeNil() throws {
                encoder.result += "null,"
                count += 1
            }

            mutating func encode<T>(_ value: T) throws where T : Encodable {
                let nestedEncoder = MyEncoderImplementation()
                try value.encode(to: nestedEncoder)
                encoder.result += nestedEncoder.result + ","
                count += 1
            }

            mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
                fatalError("Not implemented")
            }

            mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
                fatalError("Not implemented")
            }

            mutating func superEncoder() -> Encoder {
                fatalError("Not implemented")
            }
        }

        struct SingleValueContainer: SingleValueEncodingContainer {
            var encoder: MyEncoderImplementation

            var codingPath: [CodingKey] = []

            mutating func encodeNil() throws {
                encoder.result += "null"
            }

            mutating func encode<T>(_ value: T) throws where T : Encodable {
                let nestedEncoder = MyEncoderImplementation()
                try value.encode(to: nestedEncoder)
                encoder.result += nestedEncoder.result
            }
        }

        struct Person: Codable {
            let name: String
            let age: Int
        }
        
        let encoder = MyEncoder()
        let person = Person(name: "John", age: 30)
        let encoded = try! encoder.encode(person)
        print(encoded) // 输出：name:John,age:30,
    }
    
    @objc func actionWCDB() throws {
        DatabaseManager.shared().createTables()
        DatabaseSwift.shared.createTables()
        // 需要测试可空类型，枚举，Date等
        let obj = LearntWordSwift()
        obj.wordId = 100
        obj.word = "batman"
        obj.aid = 20
        obj.updateDate = nil
        obj.addDate = Date()
        obj.abilityOption = .all
        obj.masterOption = .known
        try DatabaseSwift.shared.database.insert(objects: obj, intoTable: "learnt_table_swift")
        let reObj:LearntWordSwift = try DatabaseSwift.shared.database.getObject(on: LearntWordSwift.Properties.all, fromTable: "learnt_table_swift", where: LearntWordSwift.Properties.aid == 20)!
        xToast.show("插入并查询完成，获取到的：aid = \(reObj.aid) wordId = \(reObj.wordId) word = \(reObj.word) addDate = \(String(describing: reObj.addDate)) updateDate = \(String(describing: reObj.updateDate)) abilityOption = \(reObj.abilityOption)")
    }
    
    
    @objc func actionUnsafePointer() {
        enum PetEnum: String {
            case Rabbit = "Rabbit"
            case Dog = "Dog"
            case Fish = "Fish"
        }
        var allKeys: [PetEnum] = []

        var i = 0
        while true {
            guard let key = (withUnsafePointer(to: &i) {
                return $0.withMemoryRebound(to: PetEnum.self, capacity: 1, { return $0.pointee })
            }) else {
                break
            }
            allKeys.append(key)
            i += 1
        }
        print(allKeys) // [.Rabbit, .Dog, .Fish]
    }
    
    @objc func actionObjcSignalTest() {
        let signal1 = RACSignal<NSNumber>.return(NSNumber.init(integerLiteral: TestEvent.close.rawValue))
        signal1.subscribeNext { numEvent in
            print("immediate signal: \(numEvent!.intValue)")
        }
        let eventSignal = self._createEventSignal()
        eventSignal.subscribeNext { numEvent in
            print("event signal: \(numEvent!.intValue)")
        }
    }
    
    var eventSignal:RACSubject<NSNumber>?
    func _createEventSignal() -> RACSignal<NSNumber> {
        self.eventSignal = RACSubject<NSNumber>.init()
        xTask.asyncMain {
            self.eventSignal?.sendNext(NSNumber.init(integerLiteral: TestEvent.show.rawValue))
        }
        xTask.asyncMain(after: 4) {
            self.eventSignal?.sendNext(NSNumber.init(integerLiteral: TestEvent.close.rawValue))
        }
        return self.eventSignal!
    }
    
    @objc func actionPanGesture() {
        let view = PanGestureView.init(model: PanGestureViewModel())
        self.view.addSubview(view)
        view.mas_remakeConstraints { make in
            make?.edges.mas_equalTo()(0)
        }
        QMUITips.show(withText: "添加panGesture成功")
    }
    
    @objc func actionPushMain() {
        self.navigationController?.pushViewController(MainController(), animated: true)
    }
    
    @objc func actionOperator() {
        // producerA，producerB，producerCMaker is independent to each other
        let producerA = SignalProducer<String, Error>.init { observer, lifetime in
            WMTask.asyncGlobal(after: 3) {
                observer.send(error: AppError.generalError as! Error)
            }
        }
        let producerB = SignalProducer<Int, Error>.init { observer, lifetime in
            observer.send(value: 1)
            observer.sendCompleted()
        }

        let producerCMaker: (String, Int) -> SignalProducer<String, Error> = { valueA, valueB in
            return SignalProducer<String, Error>.init { observer, lifetime in
                WMTask.asyncGlobal(after: 3) {
                    observer.send(value: "valueC(A:\(valueA) B:\(valueB))")
                    observer.sendCompleted()
                }
            }
        }
        // compose producerA，producerB，producerCMaker together
        let producerARecover = producerA.flatMapError { _ in
            return SignalProducer<String, Error>.init(value: "recover")
        }

        let finalProducer = SignalProducer.combineLatest(producerARecover, producerB).flatMap(.merge) { (valueA, valueB) in
            return producerCMaker(valueA, valueB)
        }
        finalProducer.startWithResult { result in
            switch result {
            case let .success(value):
                print(value)
            case let .failure(error):
                print("error:\(error)")
            }
        }
    }
    
    @objc func actionPipe() {
        pipeSignal.observeValues { value in
            print("pipeSignal got value: \(value)")
        }
        pipeSender.send(value: "hellow")
    }
    
    @objc func actionStartWithoutSubscribe() {
        let producer = SignalProducer<String, Never>.init { observer, lifetime in
            WMTask.asyncGlobal(after: 3) {
                if lifetime.hasEnded {
                    return
                }
                print("execute signalProducer ...")
                observer.send(value: "test")
                observer.sendCompleted()
            }
        }
        producer.start()
    }
    
    @objc func actionOverrideTest() {
        let model = TestModel()
    }
    
    @objc func actionRACPropThread() {
        /**
         subModel.width changed to: 0.0 in thread:<_NSMainThread: 0x6000016b4540>{number = 1, name = main}
         self.width changed to: 0.0 in thread:<_NSMainThread: 0x6000016b4540>{number = 1, name = main}
         setup observation completed
         before set self.width = 100, thread:<NSThread: 0x600001630400>{number = 8, name = (null)}
         subModel.width changed to: 100.0 in thread:<NSThread: 0x600001630400>{number = 8, name = (null)}
         self.width changed to: 100.0 in thread:<NSThread: 0x600001630400>{number = 8, name = (null)}
         after set self.width = 100, subModel.width = ReactiveSwift.MutableProperty<CoreGraphics.CGFloat>, thread:<NSThread: 0x600001630400>{number = 8, name = (null)}
         */

        self.subModel.width <~ self.width

        self.subModel.width.producer.startWithValues { width in
            print("subModel.width changed to: \(width) in thread:\(Thread.current)")
        }
        self.width.producer.startWithValues { width in
            print("self.width changed to: \(width) in thread:\(Thread.current)")
        }
        print("setup observation completed")
        WMTask.asyncGlobal(after: 3, task: {
            print("before set self.width = 100, thread:\(Thread.current)")
            self.width.value = 100
            print("after set self.width = 100, subModel.width = \(self.subModel.width.value), thread:\(Thread.current)")
        })
    }
    
    @objc func actionOffsetResetIssue() {
        self.navigationController?.pushViewController(ScrollViewTestController.init(), animated: true)
    }
    
    @objc func actionTabScroll() {
        self.navigationController?.pushViewController(TabScrollController.init(), animated: true)
    }
    
    @objc func actionYYLabel() {
        let englishLabel = YYLabel(frame: .zero)
        englishLabel.textParser = self
        let attr = NSMutableAttributedString.init(string: "Life is short, love your girls.")
        attr.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange.init(location: 0, length: attr.string.count))
        attr.addAttribute(.font, value: xFont.regular(withSize: 15), range: NSRange.init(location: 0, length: attr.string.count))
        englishLabel.attributedText = attr
        self.view.addSubview(englishLabel)
        englishLabel.snp.makeConstraints { make in
            make.left.equalTo(100)
            make.top.equalTo(100)
        }
    }
    
    @objc func actionImageInText() {
        let imgAttach = NSTextAttachment()
        imgAttach.image = UIImage.init(named: "tips_zhenti")
        imgAttach.bounds = CGRect.init(x: 0, y: 0, width: 32, height: 16)
        let imgAttr = NSAttributedString.init(attachment:imgAttach)
        let label = UILabel.init()
        label.attributedText = imgAttr
        self.view.addSubview(label)
        label.mas_remakeConstraints { make in
            make?.left.mas_equalTo()(100)
            make?.top.mas_equalTo()(200)
        }
    }
    
    @objc func actionHotSignal() {
        self.hotSignal = Signal<String, AppError>.init { observer, lifetime in
            WMTask.asyncGlobal(after: 3) {
//                observer.send(error: AppError.generalError)
                observer.send(value: "test")
            }
        }.take(last: 3)
        WMTask.asyncMain(after: 5) {
            self.hotSignal?.observeResult({ result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    print(value)
                }
            })
        }
    }
    
    @objc func actionFlatMap() {
        // 未完待续
        // composite task: success when:
        // task A success/fail
        // task B success
        // then task C
        let signalA = Signal<String, AppError>.init { observer, lifetime in
            WMTask.asyncGlobal(after: 3) {
                observer.send(value: "A-value1")
                WMTask.asyncGlobal(after: 3) {
                    observer.send(value: "A-value2")
                    WMTask.asyncGlobal(after: 3) {
                        observer.send(error: .generalError)
                    }
                }
            }
        }
        let signalB = Signal<String, AppError>.init { observer, lifetime in
            WMTask.asyncGlobal(after: 2) {
                observer.send(value: "B-value1")
                observer.sendCompleted()
            }
        }
        
    }
    
    @objc func actionCAGradientLayer() {
        let layer = CAGradientLayer()
        layer.locations = [0, 0.1, 1]
        layer.colors = [UIColor.init(white: 0, alpha: 0).cgColor,
                        UIColor.init(white: 0, alpha: 1).cgColor,
                        UIColor.init(white: 0, alpha: 1).cgColor]
        layer.frame = CGRect(x:0, y:self.view.bounds.size.height - 500, width:self.view.bounds.size.width, height:500)
        self.view.layer.addSublayer(layer)
    }
    
    /**
     totalHeight1 calculate by: prop1:300.0 prop2:(100.0, 200.0)
     totalHeight1.producer.startWithValues get: 500.0
     totalHeight1 calculate by: prop1:400.0 prop2:(100.0, 200.0)
     totalHeight1.producer.startWithValues get: 600.0
     totalHeight1 calculate by: prop1:400.0 prop2:(100.0, 300.0)
     totalHeight1.producer.startWithValues get: 700.0
     */
    @objc func actionRACBinding1() {
        self.totalHeight1.producer.startWithValues { height in
            print("totalHeight1.producer.startWithValues get: \(height)")
        }
        xTask.asyncMain(after: 5) {
            self.prop1 = 400
            xTask.asyncMain(after: 5) {
                self.prop2 = CGSize.init(width: 100, height: 300)
            }
        }
    }
    /**
     totalHeight2.producer.startWithValues get: 0.0
     totalHeight2 calculate by: prop1:400.0 prop2:(100.0, 300.0)
     totalHeight2.producer.startWithValues get: 700.0
     */
    @objc func actionRACBinding2() {
        self.totalHeight2.producer.startWithValues { height in
            print("totalHeight2.producer.startWithValues get: \(height)")
        }
        xTask.asyncMain(after: 5) {
            self.prop1 = 400
            xTask.asyncMain(after: 5) {
                self.prop2 = CGSize.init(width: 100, height: 300)
            }
        }
    }
    
    /**
     totalHeight3.producer.startWithValues get: 0.0
     totalHeight3 calculate by: prop1:400.0 prop2:(100.0, 300.0)
     totalHeight3.producer.startWithValues get: 700.0
     */
    @objc func actionRACBinding3() {
        self.totalHeight3.producer.startWithValues { height in
            print("totalHeight3.producer.startWithValues get: \(height)")
        }
        xTask.asyncMain(after: 5) {
            self.prop1 = 400
            xTask.asyncMain(after: 5) {
                self.prop2 = CGSize.init(width: 100, height: 300)
            }
        }
    }
    
    /// tab header
    private lazy var tabHeaderView:JXCategoryTitleView = {
        let headerView = JXCategoryTitleView()
        headerView.delegate = self
        headerView.backgroundColor = UIColor.clear
        headerView.titles = ["词组", "词根", "派生词", "助记", "柯林斯"]
        headerView.listContainer = self.tabView
        headerView.titleFont = AppFont.regular(10)
        headerView.titleColor = UIColor.qmui_color(withHexString: "#7A7E9D")
        headerView.titleSelectedFont = AppFont.medium(10)
        headerView.titleSelectedColor = UIColor.qmui_color(withHexString: "#19263A")
        headerView.cellSpacing = 12
        headerView.cellWidthIncrement = 16
        headerView.contentEdgeInsetLeft = 0
        headerView.contentEdgeInsetRight = 0
        let selectedView = JXCategoryIndicatorBackgroundView()
        selectedView.indicatorHeight = 20
        selectedView.indicatorWidthIncrement = 0
        selectedView.indicatorColor = UIColor.blue
        headerView.indicators = [selectedView]
        return headerView
    }()
    /// tab内容
    private lazy var tabView:JXCategoryListContainerView = {
        let tabView = JXCategoryListContainerView.init(type: JXCategoryListContainerType.collectionView, delegate: self)!
        tabView.scrollView.backgroundColor = UIColor.red
        tabView.backgroundColor = UIColor.red
        tabView.listCellBackgroundColor = UIColor.red
        tabView.scrollView.isPagingEnabled = true
        return tabView
    }()
    
    @objc func actionJXCategoryView(){
        self.view.addSubview(self.tabHeaderView)
        self.view.addSubview(self.tabView)
        self.tabView.snp.remakeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(200)
        }
        self.tabHeaderView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.bottom.equalTo(self.tabView.snp.top)
            make.width.equalTo(36 * 3 + 46 * 2 + 12 * 4)
            make.height.equalTo(20)
        }
    }
    
    let specialCharacters:[Character] = ["\u{200b}","\u{2018}","\u{2019}","\u{20}","\u{21}","\u{25}","\u{26}","\u{2026}","\u{27}","\u{28}","\u{29}","\u{2c}","\u{2d}","\u{2e}","\u{2f}","\u{3d}","\u{3f}","\u{5f}","\u{2160}","\u{2161}","\u{a0}","\u{20ac}","\u{b0}"]
    
    @objc func actionCharacter(){
        let str:String = "Cha\u{20}rac\u{a0}\u{25}ter"
        print(str)
        var newStr:String = ""
        for c in str {
            if !specialCharacters.contains(c) {
                newStr.append(c)
            }
        }
        print(newStr)
    }
    
    // 每秒发送一个text的子串
    func textSignalGenerator(text: String) -> Signal<String, Never> {
        return Signal<String, Never> { (observer, _) in
            let now = DispatchTime.now()
            for index in 0..<text.count {
                DispatchQueue.main.asyncAfter(deadline: now + 1.0 * Double(index)) {
                    let indexStartOfText = text.index(text.startIndex, offsetBy: 0)
                    let indexEndOfText = text.index(text.startIndex, offsetBy: index)
                    let substring = text[indexStartOfText...indexEndOfText]
                    let value = String(substring)
                    observer.send(value: value)
                }
            }
        }
    }
    
    // the property to kvo must marked as @objc dynamic, and must not swift-only type like enum
    @objc dynamic var name:String = "batman"
    @objc dynamic var nameArr:[String] = ["A","B","C"]
    @objc func actionRACKvo(){
        /**
         kvo received name: batman
         kvo received name: spiderman
         kvo received name: superman
         */
        // producer emit the initial value "batman", signal not.
        self.reactive.producer(for: \.name).startWithValues { name in
            print("kvo received name: \(name)")
        }
        xTask.asyncGlobal(after: 2) {
            self.name = "spiderman"
            xTask.asyncGlobal(after: 2) {
                self.name = "superman"
            }
        }
        
        self.reactive.producer(for: \.nameArr).startWithValues { arr in
            print("kvo received nameArr: \(arr)")
        }
        xTask.asyncGlobal(after: 1) {
            self.nameArr = self.nameArr.sorted(by: {$0 > $1})
        }
    }
    
    @objc func actionSignal(){
        /**
         observe 1 received: b
         observe 1 received: ba
         observe 1 received: bat
         observe 1 received: batm
         observe 1 received: batma
         observe 2 received: batma
         observe 1 received: batman
         observe 2 received: batman
         */
        let signal = self.textSignalGenerator(text: "batman");
        signal.observeValues { text in
            print("observe 1 received: \(text)")
        }
        xTask.asyncMain(after: 3) {
            signal.observeValues { text in
                print("observe 2 received: \(text)")
            }
        }
    }
    
    @objc func actionRACProperty(){
        /**
         producer received 3
         producer received 4
         producer received 5
         signal received 5
         */
        let mutableProperty = MutableProperty(1)
        mutableProperty.value = 2
        mutableProperty.value = 3
        mutableProperty.producer.startWithValues{
            print("producer received \($0)")
        }
        mutableProperty.value = 4
        mutableProperty.signal.observeValues {
            print("signal received \($0)")
        }
        mutableProperty.value = 5
    }
    
    @objc func actionPromiseToObservable() {
        xTask.asyncGlobal {
            _ = xAPI.host("https://api.androidhive.info").path("/volley/person_object.json").method(.HTTP_GET).execute().asObservable().subscribe { (ret) in
                // this must be true because asObservable() perform underlying promise method then() and other block on main thread
                print("is main thread? \(Thread.isMainThread)")

                if let dic = ret as? [AnyHashable: Any] {
                    print("API ret as Dictionary (could pass to params of NSDictionary type): \n\(dic)")
                }
                if let ret = ret {
                    let json = JSON.init(ret)
                    print("API ret as SwiftyJSON (for operate in swift): \n\(json)")
                }
            } onError: { (error) in
                print(error)
            }
        }
    }
    
    // MARK: - JXCategoryViewDelegate
    
    // 点击选中或者滚动选中都会调用该方法
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
    }
    
    // MARK: - JXCategoryListContainerViewDelegate
    
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return 5
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        let view = UIView()
        if index % 2 == 0 {
            view.backgroundColor = UIColor.red
        }
        else {
            view.backgroundColor = UIColor.blue
        }
        return view
    }
    
    //MARK: - YYTextParser
    
    func parseText(_ text: NSMutableAttributedString?, selectedRange: NSRangePointer?) -> Bool {
        print("parseText(text:\(text?.string ?? "") selectedRange:nil)")
        guard let text = text, text.string.count > 0 else { return false }
        return true
    }
}

extension UIView: JXCategoryListContentViewDelegate {
    public func listView() -> UIView! {
        return self
    }
}
