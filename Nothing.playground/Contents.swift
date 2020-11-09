import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - Group enter/leave

//let queue = DispatchQueue(label: "123", attributes: .concurrent)
//
//let group = DispatchGroup()
//
//func taskToUploadImage(fileName: String) -> DispatchWorkItem {
//    group.enter()
//    let workItem = DispatchWorkItem {
//        sleep(.random(in: 3...5))
//        print("Image \(fileName) uploaded")
//        group.leave()
//    }
//    return workItem
//}
//
//queue.sync(execute: taskToUploadImage(fileName: "123.jpeg"))
//queue.sync(execute: taskToUploadImage(fileName: "hello.jpeg"))
//queue.sync(execute: taskToUploadImage(fileName: "world.jpeg"))
//
//group.notify(queue: queue) {
//    print("All images uploaded successfully")
//}


// MARK: - Barrier

let queue = DispatchQueue(label: "123", attributes: .concurrent)

// ====        ===
// ======      ====
// ======      ======
//       ======

class AsyncDictionary<K: Hashable, V> {
    private var dictionary: [K: V] = [:]
    private let queue = DispatchQueue(label: "com.itis.asyncdictionary", attributes: .concurrent)

    func getElement(key: K) -> V? {
        var result: V?
        queue.sync {
            result = dictionary[key]
        }
        return result
    }

    func getElement(key: K, completion: @escaping (V?) -> Void) {
        queue.async {
            completion(self.dictionary[key])
        }
    }

    func set(value: V, for key: K) {
        queue.async {
            self.dictionary[key] = value
        }
    }
}

let myDictionary = AsyncDictionary<String, Int>()

myDictionary.getElement(key: "123") { value in
    DispatchQueue.main.async {
        print(value ?? 0)
    }
}

myDictionary.set(value: 1, for: "123")

/*
 [a] imageA
 [b]
 [c]

 [a] imageD

 loadImage(name: String) { image in
     imageView.image = image
 }
*/
