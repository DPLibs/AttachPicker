import Foundation
import UIKit

// MARK: - AttachModel
struct AttachModel {
    let type: AttachType
    let fileData: Data?
    let fileExtension: String
    let fileName: String
    let mimeType: String
    let image: UIImage?
    
    init?(localUrl: URL) {
        guard let data = try? Data(contentsOf: localUrl) else { return nil }
        self.type = AttachType(data.mimeType)
        self.fileData = data
        self.fileExtension = localUrl.pathExtension.lowercased()
        self.fileName = localUrl.lastPathComponent.lowercased()
        self.mimeType = data.mimeType
        self.image = nil
    }
    
    init?(image: UIImage) {
        guard let data = image.pngData() else { return nil }
        self.type = AttachType(data.mimeType)
        self.fileData = data
        self.fileExtension = "png"
        self.fileName = "file.\(self.fileExtension)".lowercased()
        self.mimeType = data.mimeType
        self.image = image
    }
    
}

// MARK: - AttachType
enum AttachType {
    case image
    case video
    case document
    
    init(_ fileContentType: String) {
        switch fileContentType.split(separator: "/").first ?? "" {
        case "image":
            self = .image
        case "video":
            self = .video
        default:
            self = .document
        }
    }
}
