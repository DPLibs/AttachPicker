import Foundation
import UIKit

public struct AttachProvider: Hashable {
    
    // MARK: - Props
    let title: Title
    let imagePicker: UIImagePickerController?
    let documentPicker: UIDocumentPickerViewController?
    
    // MARK: - Static
    public enum Title: Hashable {
        case `default`
        case custom(text: String, style: UIAlertAction.Style)
        
        static let documentsText = NSLocalizedString("Documents", comment: "")
        static let cameraText = NSLocalizedString("Camera", comment: "")
        static let galleryText = NSLocalizedString("Gallery", comment: "")
        static let unknownText = NSLocalizedString("Unknown", comment: "")
        
        func text(_ provider: AttachProvider) -> String {
            switch self {
            case let .custom(text, _):
                return text
            case .default:
                if provider.documentPicker != nil {
                    return Title.documentsText
                } else if let picker = provider.imagePicker {
                    switch picker.sourceType {
                    case .camera:
                        return Title.cameraText
                    case .photoLibrary,
                         .savedPhotosAlbum:
                        return Title.galleryText
                    @unknown default:
                        return Title.unknownText
                    }
                } else {
                    return Title.unknownText
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

extension Set where Element == AttachProvider {
    static let defaultSingleSelect: Self = [.photoLibrary, .camera, .documentsSingleSelection]
    static let defaultMultiSelect: Self = [.photoLibrary, .camera, .documentsMultipleSelection]
    
    static let photoLibrary: Self = [.photoLibrary]
    static let camera: Self = [.camera]
    static let documentsSingleSelection: Self = [.documentsMultipleSelection]
    static let documentsMultipleSelection: Self = [.documentsMultipleSelection]
}
