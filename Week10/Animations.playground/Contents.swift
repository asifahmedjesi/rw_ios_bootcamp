
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true



extension UIView {
    
    static func animate(withDuration duration: TimeInterval,
                      animations: @escaping () -> Void,
                      group: DispatchGroup,
                      completion: ((Bool) -> Void)?) {

        group.enter()
        UIView.animate(withDuration: duration, animations: {
            animations()
        }) { (result) in
            defer { group.leave() }
            completion?(result)
        }
    }
}



let animationGroup = DispatchGroup()

// A red square
let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = UIColor.red

// A yellow box
let box = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
box.backgroundColor = UIColor.yellow
view.addSubview(box)


UIView.animate(withDuration: 1, animations: {
    box.center = CGPoint(x: 150, y: 150)
}, group: animationGroup) { (result) in
    UIView.animate(withDuration: 2, animations: {
        box.transform = CGAffineTransform(rotationAngle: .pi/4)
    }, group: animationGroup, completion: .none)
}

UIView.animate(withDuration: 4, animations: {
    view.backgroundColor = UIColor.blue
}, group: animationGroup, completion: .none)


animationGroup.notify(queue: DispatchQueue.main) {
    print("Animations Completed!")
}



// Note: Enable Xcode▸Editor▸Live View to see the animation.
PlaygroundPage.current.liveView = view


