//
//  SortViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/9.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

class SortViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let cardView = UIView(frame: CGRect(x: 50, y: 50, width: 200, height: 300))
//        cardView.backgroundColor = UIColor.clear
//
//        let frontView = UIView(frame: cardView.bounds)
//        frontView.backgroundColor = UIColor.red
//
//        let backView = UIView(frame: cardView.bounds)
//        backView.backgroundColor = UIColor.blue
//
//        cardView.addSubview(frontView)
//        cardView.addSubview(backView)
//
//        view.addSubview(cardView)
//
//        setupDoubleSidedCard(view: cardView)


        let testView = UIView().then {
            $0.backgroundColor = UIColor.purple
        }

        view.addSubview(testView)

        testView.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.left.equalTo(200)
            make.width.height.equalTo(50)
        }

        animateView(testView)
    }

    func animateView(_ view: UIView) {
        // 初始状态：位置在屏幕底部，透明度为0
        view.transform = CGAffineTransform(translationX: 0, y: 50)
        view.alpha = 0

        // 动画开始
        UIView.animateKeyframes(withDuration: 2.0, delay: 0, options: [], animations: {

            // Step 1: 移动到原位置并淡入
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                view.transform = .identity // 回到初始位置
                view.alpha = 1.0 // 完全可见
            }

            // Step 2: 前后翻转 90 度
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                var transform = CATransform3DIdentity
                transform.m34 = -1.0 / 500.0 // 设置透视效果
                transform = CATransform3DRotate(transform, .pi / 2, 1, 0, 0) // 沿 X 轴翻转 90 度
                view.layer.transform = transform
            }


            // Step 3: 淡出并消失
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                view.alpha = 0.0 // 完全不可见
            }

        }, completion: { _ in
            // 动画完成时，将 view 位置和透明度恢复到初始状态
            view.transform = .identity
            view.alpha = 0
        })
    }

    func setupDoubleSidedCard(view: UIView) {
        view.clipsToBounds = true

        let transform = CATransform3DIdentity
        view.layer.sublayerTransform = transform

        let frontTransform = CATransform3DIdentity
        var backTransform = CATransform3DIdentity

        backTransform = CATransform3DMakeRotation(CGFloat.pi, 0, 1, 0)

        let duration = 1.0

        CATransaction.begin()
        let flipAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        flipAnimation.fromValue = 0
        flipAnimation.toValue = CGFloat.pi
        flipAnimation.duration = duration
        flipAnimation.isRemovedOnCompletion = false
        flipAnimation.fillMode = CAMediaTimingFillMode.forwards
        CATransaction.setCompletionBlock {
            view.layer.transform = view.layer.presentation()?.transform ?? backTransform
        }
        view.layer.add(flipAnimation, forKey: "flipAnimation")
        CATransaction.commit()
    }

    /// 1. 冒泡排序
    func bubbleSort(_ array: inout [Int]) {
        let count = array.count
        for i in 0..<count {
            for j in 0..<count-i-1 {
                if array[j] > array[j+1] {
                    let temp = array[j]
                    array[j] = array[j+1]
                    array[j+1] = temp
                }
            }
        }
    }

    /// 2. 选择排序
    func selectionSort(_ array: inout [Int]) {
        let count = array.count
        for i in 0..<count {
            var minIndex = i
            for j in i+1..<count {
                if array[j] < array[minIndex] {
                    minIndex = j
                }
            }
            if i != minIndex {
                let temp = array[i]
                array[i] = array[minIndex]
                array[minIndex] = temp
            }
        }
    }

    /// 3. 插入排序
    func insertionSort(_ array: inout [Int]) {
        let count = array.count
        for i in 1..<count {
            let key = array[i]
            var j = i - 1
            while j >= 0 && array[j] > key {
                array[j + 1] = array[j]
                j -= 1
            }
            array[j + 1] = key
        }
    }

    /// 4. 快速排序
    func quickSort(_ array: inout [Int], low: Int, high: Int) {
        if low < high {
            let pivotIndex = partition(&array, low: low, high: high)
            quickSort(&array, low: low, high: pivotIndex - 1)
            quickSort(&array, low: pivotIndex + 1, high: high)
        }
    }

    func partition(_ array: inout [Int], low: Int, high: Int) -> Int {
        let pivot = array[high]
        var i = low - 1
        for j in low..<high {
            if array[j] <= pivot {
                i += 1
                let temp = array[i]
                array[i] = array[j]
                array[j] = temp
            }
        }
        let temp = array[i + 1]
        array[i + 1] = array[high]
        array[high] = temp
        return i + 1
    }

    /// 5. 归并排序
    func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
        guard array.count > 1 else {
            return array
        }

        let middleIndex = array.count / 2
        let leftArray = mergeSort(Array(array[0..<middleIndex]))
        let rightArray = mergeSort(Array(array[middleIndex..<array.count]))

        return merge(leftArray, rightArray)
    }

    func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
        var leftIndex = 0
        var rightIndex = 0

        var orderedArray: [T] = []

        while leftIndex < left.count && rightIndex < right.count {
            let leftElement = left[leftIndex]
            let rightElement = right[rightIndex]

            if leftElement < rightElement {
                orderedArray.append(leftElement)
                leftIndex += 1
            } else if leftElement > rightElement {
                orderedArray.append(rightElement)
                rightIndex += 1
            } else {
                orderedArray.append(leftElement)
                leftIndex += 1
                orderedArray.append(rightElement)
                rightIndex += 1
            }
        }

        while leftIndex < left.count {
            orderedArray.append(left[leftIndex])
            leftIndex += 1
        }

        while rightIndex < right.count {
            orderedArray.append(right[rightIndex])
            rightIndex += 1
        }

        return orderedArray
    }

    func crossMerge<T>(_ array1: [T], _ array2: [T]) -> [T] {
        var mergedArray: [T] = []
        let maxLength = max(array1.count, array2.count)

        for i in 0..<maxLength {
            if i < array1.count {
                mergedArray.append(array1[i])
            }
            if i < array2.count {
                mergedArray.append(array2[i])
            }
        }

        return mergedArray
    }
}



