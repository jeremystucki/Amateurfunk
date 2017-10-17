import Foundation

protocol DataLoader {
    func removeAllSections() throws
    func loadSectionFromFile(_ file: URL) throws
}
