
import Foundation

class Bindable<T> { //generic
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    /**
     - Important:
     Best pratice is to only set any UI attribute in a single binding. Failing to follow
     that suggestion can result in hard to track bugs where the order that values are set results in
     different UI outcomes.
     
     - Parameters:
     - listener: The *closure* to execute when respond to value changes.
     */
    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
