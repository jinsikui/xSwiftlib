//
//  Algorithms.swift
//  xSwiftlib
//
//  Created by Sikui Jin on 2023/11/1.
//

import Foundation


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

class Algorithms {
    
    /// Topics: Array and String
    /// https://leetcode.com/explore/interview/card/top-interview-questions-hard/116/array-and-strings/832/
    /// Given an unsorted integer array nums, return the smallest missing positive integer.
    /// You must implement an algorithm that runs in O(n) time and uses O(1) auxiliary space.
    /// 基本思路：最小的missing正整数一定是 1～n+1之间，
    /// 所以只要有一个长度为n的标记数组marks，遍历原始数组，发现1～n之间的数，就在marks对应的位置标记`find`，遍历结束后找到marks中索引最小的未被标记为`find`的位置即可
    /// 如果都被标记为`find`，return n+1即可
    /// 上面的思路可以说是化`值`为`索引`，当结果范围固定时，这是一种思路
    /// 还要解决的问题是算法要求用O(1)的空间复杂度实现，如果使用marks数组，空间复杂度为O(n)，不符合要求，那么考虑可以用原始的nums数组的空间来担任marks数组
    /// 这就要解决如果在原始的nums数组中标记某个位置为`find`，不能破坏那个位置的值，因为标记时那个位置可能还没有遍历到，
    /// 可以考虑用`负绝对值`的方式来标记`find`（负数代表`find`，绝对值保留了那个位置的原始值信息）
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
    
    /// Topics: Tree
    /// https://leetcode.com/explore/interview/card/top-interview-questions-hard/118/trees-and-graphs/844/
    /// Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.
    /// 思路：采用递归，本质是查找：
    /// 如果p，q其中之一是root，返回root
    /// 否则，p，q在root的左或右子树中
    /// 如果p，q在不同的子树中，返回root
    /// 如果p，q都在左子树中，递归查找root.left，否则递归查找root.right
    ///
    /// 特别说明：递归调用时，不能认为p，q都在root对应的树上，因为随着递归root不断下降，但是p，q不变
    /// 可以这样理解lowestCommonAncestor函数做的事：
    /// 当p，q都在root对应的树上时，返回的是最低公共节点，否则其中一个在root对应的树上时，返回查找到的那个节点，否则两个都不在root的树上，返回nil
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
}
