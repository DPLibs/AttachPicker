import Foundation
import UIKit

// MARK: - AttachModel
public struct AttachModel {
    public let type: AttachType
    public let fileData: Data?
    public let fileExtension: String
    public let fileName: String
    public let mimeType: String
    public let image: UIImage?
    
    public init?(localUrl: URL) {
        guard let data = try? Data(contentsOf: localUrl) else { return nil }
        self.type = AttachType(data.mimeType)
        self.fileData = data
        self.fileExtension = localUrl.pathExtension.lowercased()
        self.fileName = localUrl.lastPathComponent.lowercased()
        self.mimeType = data.mimeType
        self.image = nil
    }
    
    public init?(image: UIImage) {
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
public enum AttachType {
    case image
    case video
    case document
    
    public init(_ fileContentType: String) {
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
