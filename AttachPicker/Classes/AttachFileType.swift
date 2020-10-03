import Foundation
import MobileCoreServices

// MARK: - AttachFileType
public protocol AttachFileType: Hashable {
    var kUTType: CFString { get }
    var kUTTypeString: String { get }
    
    init(_ kUTType: CFString)
}

public extension AttachFileType {
    var kUTTypeString: String {
        String(self.kUTType)
    }
}

public extension Set where Element: AttachFileType {
    var toStrings: [String] {
        self.map({ $0.kUTTypeString })
    }
}

// MARK: - AttachMediaType
public struct AttachMediaType: AttachFileType {
    public let kUTType: CFString
    
    public init(_ kUTType: CFString) {
        self.kUTType = kUTType
    }
    
    static let photo = AttachMediaType(kUTTypeMovie)
    static let movie = AttachMediaType(kUTTypeMovie)
}

extension Set where Element == AttachMediaType {
    static let `default`: Self = [.photo, .movie]
    static let photo: Self = [.photo]
    static let movie: Self = [.movie]
}

// MARK: - AttachDocumentType
public struct AttachDocumentType: AttachFileType {
    public let kUTType: CFString
    
    public init(_ kUTType: CFString) {
        self.kUTType = kUTType
    }
    
    static let text = AttachDocumentType(kUTTypeText)
    static let content = AttachDocumentType(kUTTypeContent)
    static let item = AttachDocumentType(kUTTypeItem)
    static let data = AttachDocumentType(kUTTypeData)
    static let pdf = AttachDocumentType(kUTTypePDF)
    static let png = AttachDocumentType(kUTTypePNG)
    static let jpeg = AttachDocumentType(kUTTypeJPEG)
    static let bmp = AttachDocumentType(kUTTypeBMP)
    static let tiff = AttachDocumentType(kUTTypeTIFF)
    static let xml = AttachDocumentType(kUTTypeXML)
    static let plainText = AttachDocumentType(kUTTypePlainText)
}

public extension Set where Element == AttachDocumentType {
    static let `default`: Self = [.text, .content, .item, .data, .pdf, .png, .jpeg, .bmp, .tiff, .xml, .plainText]
    static let popular: Self = [.text, .data, .pdf, .png, .jpeg, .plainText]
    
    static var text: Self = [.text]
    static var content: Self = [.content]
    static var item: Self = [.item]
    static var data: Self = [.data]
    static var pdf: Self = [.pdf]
    static var png: Self = [.png]
    static var jpeg: Self = [.jpeg]
    static var bmp: Self = [.bmp]
    static var tiff: Self = [.tiff]
    static var xml: Self = [.xml]
    static var plainText: Self = [.plainText]
}
