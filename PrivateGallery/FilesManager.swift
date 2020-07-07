//import Foundation
//
//
//enum FilesPaths: String {
//    case items = "/photos.dat"
//}
//
//class FilesManager: NSObject {
//    static let shared = FilesManager()
//    private override init() {}
//
//    func saveData(data: Data, for path: FilesPaths) {
//        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + path.rawValue
//
//        if !FileManager.default.fileExists(atPath: documentsPath) {
//            FileManager.default.createFile(atPath: documentsPath,
//                                           contents: nil,
//                                           attributes: nil)
//        }
//
//        let file: FileHandle? = FileHandle(forWritingAtPath: documentsPath)
//        if file != nil {
//            file?.write(data)
//            file?.closeFile()
//        } else {
//            print("Ooops! Something went wrong!")
//        }
//    }
//
//
//    func loadData(for path: FilesPaths) -> Data? {
//        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + path.rawValue
//
//        let file: FileHandle? = FileHandle(forReadingAtPath: documentsPath)
//        if file != nil {
//            let data = file?.readDataToEndOfFile()
//            file?.closeFile()
//            return data
//        }
//        else {
//            print("Ooops! Something went wrong!")
//            return nil
//        }
//    }
//}
