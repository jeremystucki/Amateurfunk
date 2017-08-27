import Foundation

extension Array {

    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }

}
