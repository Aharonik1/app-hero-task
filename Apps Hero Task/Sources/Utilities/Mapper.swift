import Foundation

protocol Mapper {
    associatedtype Input
    associatedtype Output

    func map(_ input: Input) -> Output
}
