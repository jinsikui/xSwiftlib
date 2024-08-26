//
//  Algorithms.swift
//  xSwiftlib
//
//  Created by Sikui Jin on 2023/11/1.
//

import Foundation


/// Topics: Trie (Prefix Tree)
/// https://leetcode.com/problems/implement-trie-prefix-tree/
/// A trie (pronounced as "try") or prefix tree is a tree data structure used to efficiently store and retrieve keys in a dataset of strings.
/// There are various applications of this data structure, such as autocomplete and spellchecker.
/// Implement the Trie class:
///
/// Trie() Initializes the trie object.
/// void insert(String word) Inserts the string word into the trie.
/// boolean search(String word) Returns true if the string word is in the trie (i.e., was inserted before), and false otherwise.
/// boolean startsWith(String prefix) Returns true if there is a previously inserted string word that has the prefix prefix, and false otherwise.
class TrieNode {
    var children = [Character: TrieNode]()
    var isWord = false
}

class Trie {
    
    var root = TrieNode()
    
    init() {}
    
    func insert(_ word: String) {
        var node = root
        for char in word {
            if node.children[char] == nil {
                node.children[char] = TrieNode()
            }
            node = node.children[char]!
        }
        node.isWord = true
    }
    
    func search(_ word: String) -> Bool {
        var node = root
        for char in word {
            if node.children[char] == nil {
                return false
            }
            node = node.children[char]!
        }
       return node.isWord
    }
    
    func delete(_ word: String) {
        var node = root
        var path = [(TrieNode, Character)]()
        for char in word {
            guard let child = node.children[char] else {
                return
            }
            path.append((node, char))
            node = child
        }
        node.isWord = false
        for i in stride(from: path.count - 1, through: 0, by: -1) {
            let (node, char) = path[i]
            if node.children[char]?.children.count == 0 {
                node.children.removeValue(forKey: char)
            }
            else {
                break
            }
        }
    }
    
    func isEmpty() -> Bool {
        return root.children.count == 0
    }
    
    func startsWithOrMatch(_ prefix: String) -> (startWith:Bool, match:Bool) {
        var node = root
        for char in prefix {
            if node.children[char] == nil {
                return (startWith: false, match: false)
            }
            node = node.children[char]!
        }
        if node.isWord {
            return (startWith: true, match: true)
        }
        else {
            return (startWith: true, match: false)
        }
    }
    
    func startsWith(_ prefix: String) -> Bool {
        var node = root
        for char in prefix {
            if node.children[char] == nil {
                return false
            }
            node = node.children[char]!
        }
       return true
    }
}

/// Topics: Backtracking
/// https://leetcode.com/explore/interview/card/top-interview-questions-hard/119/backtracking/853/
/// Given an m x n board of characters and a list of strings words, return all words on the board.
/// Each word must be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring.
/// The same letter cell may not be used more than once in a word.
/// 思路：采用树`深度优先遍历`的方法来遍历所有路径，注意之前我用广度优先遍历实现会遇到test case时间超过限制
/// `深度优先遍历`：采用递归实现
/// `广度优先遍历`：采用队列实现，也叫层级遍历
/// 注意算法为了避免路径自相交，用`.`来标记单一一条路径上遍历过的节点，并在路径回退时赋值回原值，对path的操作同理
/// 而且对trie树的使用也很高效，trie的下降和path的前进是同步的，避免了每次从trie树的根部判断path是否在trie树中
class WordSearchII {
    
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        var _board = board
        var result = [String]()
        let trie = Trie()

        for word in words {
            trie.insert(word)
        }

        func backtrack(_ node: TrieNode, _ path: inout String, _ row: Int, _ col: Int, _ board: inout [[Character]]) {
            let char = board[row][col]
            guard let nextNode = node.children[char] else {
                return
            }

            path.append(char)
            board[row][col] = "."

            if nextNode.isWord {
                result.append(path)
                nextNode.isWord = false  // to avoid duplicates
            }

            // Explore neighbors
            let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

            for (dr, dc) in directions {
                let newRow = row + dr
                let newCol = col + dc

                if newRow >= 0 && newRow < board.count && newCol >= 0 && newCol < board[0].count {
                    backtrack(nextNode, &path, newRow, newCol, &board)
                }
            }

            path.removeLast()
            board[row][col] = char
        }

        for row in 0..<_board.count {
            for col in 0..<_board[0].count {
                var path = ""
                backtrack(trie.root, &path, row, col, &_board)
            }
        }

        return result
    }
}


class Algorithms {
    
    /// Topics: Linked list
    /// https://leetcode.com/explore/interview/card/top-interview-questions-hard/117/linked-list/839/
    public class ListNode {
          public var val: Int
          public var next: ListNode?
          public init() { self.val = 0; self.next = nil; }
          public init(_ val: Int) { self.val = val; self.next = nil; }
          public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }
    static func testMergeLists() {
        // [[1,4,5],[1,3,4],[2,6]]
        let list1 = ListNode(1, ListNode(4, ListNode(5)))
        let list2 = ListNode(1, ListNode(3, ListNode(4)))
        let list3 = ListNode(2, ListNode(6))
        var lists:[ListNode?] = [list1, list2, list3]
        let ret = mergeKLists(lists)
        print("\(ret!.val)")
    }
    static func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        // 结果队列
        var retList:ListNode? = nil
        // 指向返回队列的队尾
        var retTail:ListNode? = nil
        // 由还未遍历完的队列的头一个元素组成
        var headArr:[ListNode] = []
        // 初始化headArr，指向不空的队列的第一个元素
        for list in lists {
            if list != nil {
                headArr.append(list!)
            }
        }
        while(!headArr.isEmpty) {
            var minValue = 0
            // 每一轮哪些队列的头一个元素需要添加到结果队列
            var toMoves:[Int] = []
            for i in 0..<headArr.count {
                let head = headArr[i]
                if i == 0 {
                    toMoves.append(i)
                    minValue = head.val
                }
                else if head.val < minValue {
                    toMoves = [i]
                    minValue = head.val
                }
                else if head.val == minValue {
                    toMoves.append(i)
                }
            }
            // 添加到结果队列并移动该队列的指针
            // 从数组删除一个后后面的下表要前移，iDelta记录需要前移多少
            var iDelta = 0
            for i in toMoves {
                let head = headArr[i-iDelta]
                // 添加到结果队列
                if retList == nil {
                    retList = head
                    retTail = head
                }
                else {
                    retTail?.next = head
                    retTail = head
                }
                // 移动head
                if head.next != nil {
                    headArr[i-iDelta] = head.next!
                }
                else {
                    headArr.remove(at: i-iDelta)
                    iDelta += 1
                }
            }
            
        }
        return retList
    }
    
    /**
    Topics: Array and String
    https://leetcode.com/explore/interview/card/top-interview-questions-hard/116/array-and-strings/832/
    Given an unsorted integer array nums, return the smallest missing positive integer.
    You must implement an algorithm that runs in O(n) time and uses O(1) auxiliary space.
    基本思路：最小的missing正整数一定是 1～n+1之间，
    所以只要有一个长度为n的标记数组marks，遍历原始数组，发现1～n之间的数，就在marks对应的位置标记`find`，遍历结束后找到marks中索引最小的未被标记为`find`的位置即可
    如果都被标记为`find`，return n+1即可
    上面的思路可以说是化`值`为`索引`，当结果范围固定时，这是一种思路
    还要解决的问题是算法要求用O(1)的空间复杂度实现，如果使用marks数组，空间复杂度为O(n)，不符合要求，那么考虑可以用原始的nums数组的空间来担任marks数组
    这就要解决如果在原始的nums数组中标记某个位置为`find`，不能破坏那个位置的值，因为标记时那个位置可能还没有遍历到，
    可以考虑用`负绝对值`的方式来标记`find`（负数代表`find`，绝对值保留了那个位置的原始值信息）
     */
    static func firstMissingPositive(_ nums: [Int]) -> Int {
        // swift不允许改变原始参数nums的值，所以需要copy，其实这破坏了空间复杂度为O(1)的要求，这只是语言问题，不影响算法思路
        var nums = nums
        let n = nums.count
        // 首先把<=0的数排除在外，避免标记`find`时干扰结果，排除的方法是置为n+1，后续只处理绝对值1~n的元素
        for i in 0..<n {
            let value = nums[i]
            if value <= 0 {
                nums[i] = n + 1
            }
        }
        for i in 0..<n {
            let value = nums[i]
            let absValue = abs(value)
            
            if 1 <= absValue && absValue <= n {
                // 用`负绝对值`的方式来标记`find`（负数代表`find`，绝对值保留了那个位置的原始值信息）
                let value2 = nums[absValue - 1]
                let absValue2 = abs(value2)
                nums[absValue - 1] = -absValue2
            }
        }
        for i in 0..<n {
            // 找到未被标记为`find`的位置，即第一个>0的位置
            if nums[i] > 0 {
                return i + 1
            }
        }
        // 全部<0，返回n+1
        return n+1
    }
    
    /// Topics: Tree
    /// https://leetcode.com/explore/interview/card/top-interview-questions-hard/118/trees-and-graphs/842/
    /// A transformation sequence from word beginWord to word endWord using a dictionary wordList is a sequence of words beginWord -> s1 -> s2 -> ... -> sk such that:
    /// Every adjacent pair of words differs by a single letter.
    /// Every si for 1 <= i <= k is in wordList. Note that beginWord does not need to be in wordList.
    /// sk == endWord
    /// Given two words, beginWord and endWord, and a dictionary wordList, return the number of words in the shortest transformation sequence from beginWord to endWord, or 0 if no such sequence exists.
    /// All the words in wordList are unique.
    /// constraints：wordList[i].length == beginWord.length == endWord.length
    ///
    /// 思路：使用广度优先遍历算法，算法复杂度为O((word.count * 26)^(wordList.count))，注意因为路径必须从wordList中取，因此树最多只有wordList.count层
    static func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        var queue = [(beginWord, 1)]
        var wordSet = Set(wordList)
        if !wordSet.contains(endWord) {
            return 0
        }
        // 广度优先遍历树
        while !queue.isEmpty {
            // 前出后入
            let (word, level) = queue.removeFirst()
            if word == endWord {
                return level
            }
            for i in 0..<word.count {
                let char:Character = word[word.index(word.startIndex, offsetBy: i)]
                for newChar in "abcdefghijklmnopqrstuvwxyz" {
                    if newChar == char {
                        continue
                    }
                    var preStr = ""
                    if i > 0 {
                        preStr = String(word.prefix(i))
                    }
                    var suffixStr = ""
                    if i < word.count - 1 {
                        suffixStr = String(word.suffix(word.count - 1 - i))
                    }
                    let newWord = "\(preStr)\(newChar)\(suffixStr)"
                    // 仅当在wordSet中存在时才加入树，这很大的降低了时间复杂度
                    if wordSet.contains(newWord) {
                        wordSet.remove(newWord)
                        queue.append((newWord, level + 1))
                    }
                }
            }
        }
        return 0
    }
    
    /**
    Topics: Tree
    https://leetcode.com/explore/interview/card/top-interview-questions-hard/118/trees-and-graphs/844/
    Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.
    思路：采用递归，本质是查找：
    如果p，q其中之一是root，返回root
    否则，p，q在root的左或右子树中
    如果p，q在不同的子树中，返回root
    如果p，q都在左子树中，递归查找root.left，否则递归查找root.right

    特别说明：递归调用时，不能认为p，q都在root对应的树上，因为随着递归root不断下降，但是p，q不变
    可以这样理解lowestCommonAncestor函数做的事：
    当p，q都在root对应的树上时，返回的是最低公共节点，否则其中一个在root对应的树上时，返回那个节点，否则两个都不在root的树上，返回nil
     */
    class TreeNode {
        var val: Int
        var left: TreeNode?
        var right: TreeNode?
        
        init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
    }
    static func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let root, let p, let q else { return nil }
        if root.val == p.val || root.val == q.val {
            return root
        }
        let leftResult = lowestCommonAncestor(root.left, p, q)
        let rightResult = lowestCommonAncestor(root.right, p, q)
        if leftResult != nil && rightResult != nil {
            // p, q分别在不同的子树上
            return root
        }
        return leftResult != nil ? leftResult : rightResult
    }
    
    /**
     简化1: 判断p是否在root对应的树中
     */
    static func isInTree(_ root: TreeNode?, _ p: TreeNode?) -> Bool {
        guard let root, let p else { return false }
        if root.val == p.val {
            return true
        }
        if isInTree(root.left, p) {
            return true
        }
        return isInTree(root.right, p)
    }
    
    /**
     简化2: 判断p是否在root对应的树中，如果在，输出从p到root的路径
     */
    static func pathToRoot(_ root: TreeNode?, _ p: TreeNode?) -> [TreeNode] {
        var arr:[TreeNode] = []
        func _isInTree(_ root: TreeNode?, _ p: TreeNode?, _ arr: inout [TreeNode]) -> Bool {
            guard let root, let p else { return false }
            if root.val == p.val || _isInTree(root.left, p, &arr) || _isInTree(root.right, p, &arr){
                arr.append(root)
                return true
            }
            return false
        }
        _ = _isInTree(root, p, &arr)
        return arr
    }
    
    /**
     简化3: 另一种方法求最近的公共祖先
     */
    static func lowestCommonAncestor2(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        let path1 = pathToRoot(root, p)
        let path2 = pathToRoot(root, q)
        // 问题转化为求path1和path2的公共子串
        if path1.isEmpty || path2.isEmpty {
            return nil
        }
        // path1 和 path2 形成一个`Y`形，要求它们公共子串，先把它们变为等长
        let diff = path1.count - path2.count
        var i = 0, j = 0
        if diff > 0 {
            i = diff
        }
        else if diff < 0 {
            j = -diff
        }
        while path1[i] !== path2[j] {
            i += 1
            j += 1
        }
        return path1[i]
    }
}
