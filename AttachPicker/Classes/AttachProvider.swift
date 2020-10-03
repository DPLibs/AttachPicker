import Foundation
import UIKit

public protocol UIPicker: Hashable {}

public struct AttachProvider: Hashable {
    
    // MARK: - Props
    let title: Title
    let imagePicker: UIImagePickerController?
    let documentPicker: UIDocumentPickerViewController?
    
    public init(title: Title, imagePicker: UIImagePickerController?, documentPicker: UIDocumentPickerViewController?) {
        self.title = title
        self.imagePicker = imagePicker
        self.documentPicker = documentPicker
    }
    
    // MARK: - Static
    public enum Title: Hashable {
        case `default`
        case custom(text: String, style: UIAlertAction.Style)
        
        func text(_ provider: AttachProvider) -> String {
            switch self {
            case let .custom(text, _):
                return text
            case .default:
                if provider.documentPicker != nil {
                    return Assets.documentsText
                } else if let picker = provider.imagePicker {
                    switch picker.sourceType {
                    case .camera:
                        return Assets.cameraText
                    case .photoLibrary,
                         .savedPhotosAlbum:
                        return Assets.galleryText
                    @unknown default:
                        return Assets.unknownText
                    }
                } else {
                    return Assets.unknownText
                }
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case let .custom(_, style):
                return style
            case .default:
                return .default
            }
        }
    }
    
    // MARK: - Store
    static var camera: AttachProvider {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return AttachProvider(title: .default, imagePicker: nil, documentPicker: nil)
        }
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.mediaTypes = Set<AttachMediaType>.self.default.toStrings
        return AttachProvider(title: .default, imagePicker: picker, documentPicker: nil)
    }
    
    static var photoLibrary: AttachProvider {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return AttachProvider(title: .default, imagePicker: nil, documentPicker: nil)
        }
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        picker.mediaTypes = Set<AttachMediaType>.self.default.toStrings
        return AttachProvider(title: .default, imagePicker: picker, documentPicker: nil)
    }
    
    static var documentsSingleSelection: AttachProvider {
        let picker = UIDocumentPickerViewController(documentTypes: Set<AttachDocumentType>.self.default.toStrings, in: .import)
        picker.allowsMultipleSelection = false
        picker.modalPresentationStyle = .formSheet
        return AttachProvider(title: .default, imagePicker: nil, documentPicker: picker)
    }
    
    static var documentsMultipleSelection: AttachProvider {
        let picker = UIDocumentPickerViewController(documentTypes: Set<AttachDocumentType>.self.default.toStrings, in: .import)
        picker.allowsMultipleSelection = true
        picker.modalPresentationStyle = .formSheet
        return AttachProvider(title: .default, imagePicker: nil, documentPicker: picker)
    }
}

public extension Set where Element == AttachProvider {
    static let defaultSingleSelection: Self = [.photoLibrary, .camera, .documentsSingleSelection]
    static let defaultMultiSelection: Self = [.photoLibrary, .camera, .documentsMultipleSelection]
    
    static let photoLibrary: Self = [.photoLibrary]
    static let camera: Self = [.camera]
    static let documentsSingleSelection: Self = [.documentsMultipleSelection]
    static let documentsMultipleSelection: Self = [.documentsMultipleSelection]
}
