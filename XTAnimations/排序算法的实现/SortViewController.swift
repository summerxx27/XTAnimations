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

        // Do any additional setup after loading the view.
        title = "[排序]"
        view.backgroundColor = .white
//        var array = [7, 8, 4, 20, 9, 3]

//        bubbleSort(&array)
//        selectionSort(&array)
//        insertionSort(&array)
//        quickSort(&array, low: 0, high: 5)
//        print(array)

//        let array = [10, 2, 5, 3, 7, 1, 8, 9, 6, 4]
//        let sortedArray = mergeSort(array)
//        print(sortedArray)

        let array1 = ["1", "2"]
        let array2 = ["A"]

        print(crossMerge(array1, array2))



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


