import Foundation

struct LinkedList<T> {
    final class Node<T> {
        let value: T
        init(_ value: T, next: Node<T>? = nil) {
            self.value = value
            self.next = next
        }

        var next: Node<T>? = nil
    }
    
    var first: Node<T>? = nil
}

extension LinkedList {
    var isEmpty: Bool {
        return first == nil
    }
}

extension LinkedList {
    @discardableResult func insert<T>(_ node: Node<T>, after: Node<T>) -> Node<T> {
        node.next = after.next
        after.next = node
        return node
    }
    
    @discardableResult mutating func prepend(_ node: Node<T>) -> Node<T> {
        node.next = first
        self.first = node
        return node
    }
    
    @discardableResult func remove(after node: LinkedList<T>.Node<T>) -> LinkedList<T>.Node<T>? {
        let removed = node.next
        node.next = node.next?.next
        return removed
    }
}

extension LinkedList {
    func forEach(body: (LinkedList<T>.Node<T>) -> ()) {
        var node = first
        while node != nil {
            body(node!)
            node = node?.next
        }
    }
}

print("Populating parking lot.")
var parkingLot = LinkedList<String>()
parkingLot.prepend(LinkedList.Node("Car"))
let truck = parkingLot.prepend(LinkedList.Node("Truck"))
parkingLot.insert(LinkedList.Node("Chopper"), after: truck)
parkingLot.forEach(body: { print($0.value) })
print("Empty: \(parkingLot.isEmpty)")
/*
 Populating parking lot.
 Truck
 Chopper
 Car
 Empty: false
 */

print("Rearranging parking lot.")
parkingLot.remove(after: truck)
parkingLot.forEach(body: { print($0.value) })
/*
 Rearranging parking lot.
 Truck
 Car
 */

print("Populating numbers.")
var numbers = LinkedList<Int>()
let first = numbers.prepend(LinkedList.Node(1))
numbers.insert(LinkedList.Node(2), after: first)
numbers.forEach(body: { print($0.value) })
/*
 Populating numbers.
 1
 2
 */
