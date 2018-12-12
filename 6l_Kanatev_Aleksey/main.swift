//
//  main.swift
//  6l_Kanatev_Aleksey
//
//  Created by AlexMacPro on 10/12/2018.
//  Copyright © 2018 AlexMacPro. All rights reserved.
//

import Foundation

protocol Weightable {
    var weight: Double { get set }
}

class Queue: Weightable {
    var name: String
    var weight: Double

    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        return "[Имя: \(self.name), вес: \(self.weight)]\n"
    }
}

struct Stack<T: Weightable> {
    var weight = 0.0
    
    var elements: [T] = []

    mutating func push(_ element: T) {
        elements.append(element)
    }

    mutating func pop() {
        elements.removeFirst()
    }
    

    mutating func filterByMaxWeight(setMaxWeight: Double){
        let maxWeight = setMaxWeight
        var tempArray = [T]()
        for element in elements {
            if element.weight < maxWeight {
                tempArray.append(element)
            }
            elements = tempArray
        }
        
    }

    var totalWeight: Double {
        var weight = 0.0

        for element in elements {
            weight += element.weight
        }
        return weight
    }
    
    subscript(elements: Int ...) -> Double? {
        var weight: Double? = 0.0
        for index in elements {
            if index < self.elements.count {
            weight! += self.elements[index].weight
            } else {
                weight = nil
            }
        }
        return weight
    }
}

var stackQueueForFastFood = Stack<Queue>()

stackQueueForFastFood.push(Queue(name: "Alex", weight: 88.0))
stackQueueForFastFood.push(Queue(name: "Dan", weight: 132.0))
stackQueueForFastFood.push(Queue(name: "Andrey", weight: 70.0))
stackQueueForFastFood.push(Queue(name: "Elizabeth", weight: 150.0))
stackQueueForFastFood.push(Queue(name: "Maria", weight: 55.0))
stackQueueForFastFood.push(Queue(name: "Max", weight: 110.0))
stackQueueForFastFood.push(Queue(name: "Victoria", weight: 80.0))
stackQueueForFastFood.push(Queue(name: "Ben", weight: 115.0))

print("Выводим информацию о содержимом массива.")
print(stackQueueForFastFood)

stackQueueForFastFood.pop()
print("\nПроверяем продвижение очереди на одного человека.")
print(stackQueueForFastFood)

print("\nПосчитаем общий вес оставшихся любителей фастфуда.")
print("Общий вес очереди: \(stackQueueForFastFood.totalWeight) кг\n")

stackQueueForFastFood.filterByMaxWeight(setMaxWeight: 100)

print("Посмотрим, кто остался в очереди после введения запрета на посещение фастфуда людям с избыточным весом.")
print(stackQueueForFastFood)

print("\nИспользуем сабскрипт. Считаем вес людей по индексу в очереди")
print(stackQueueForFastFood[2,0] as Any)

print("\nПытаемся при подсчете обратиться к несуществующему массиву")
print(stackQueueForFastFood[2,0,3] as Any)

print("  ")

// создаем функцию фильтрации по кложеру
func filteredByClosure(stack: Stack<Queue>, closure: (Int) -> Bool) -> [Queue] {
    var tempArray = [Queue]()
    for element in stack.elements {
        if closure(Int(element.weight)) {
            tempArray.append(element)
        }
    }
    return tempArray
}

var abc = filteredByClosure(stack: stackQueueForFastFood, closure: {(element: (Int)) -> Bool in
    return element <= 75
})

print("\nВыведем массив людей, оставшихся после фильтрации по кложеру:")
print(abc)

