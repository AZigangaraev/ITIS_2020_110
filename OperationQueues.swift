import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let operationQueue = OperationQueue()
operationQueue.maxConcurrentOperationCount = 3

let dependencyOperation = BlockOperation {
    sleep(3)
    print(12345)
}

(1...10).forEach { number in
    let operation = BlockOperation {
        sleep(1)
        print(number)
    }
    operationQueue.addOperation(operation)
}
let dependendOperation = BlockOperation {
    sleep(1)
    print(54321)
}
dependendOperation.addDependency(dependencyOperation)
operationQueue.addOperation(dependendOperation)

operationQueue.waitUntilAllOperationsAreFinished()
print("All operations are finished")

(1...10).forEach { number in
    let operation = BlockOperation {
        sleep(1)
        print(number)
    }
    operationQueue.addOperation(operation)
}

operationQueue.addOperation(dependencyOperation)
operationQueue.addBarrierBlock {
    sleep(5)
    print("Barrier")
}
(1...10).forEach { number in
    let operation = BlockOperation {
        sleep(1)
        print(number)
    }
    operationQueue.addOperation(operation)
}
