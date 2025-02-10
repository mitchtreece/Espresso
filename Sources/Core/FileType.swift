//
//  FileType.swift
//  Espresso
//
//  Created by Mitch on 2/9/25.
//

import Foundation

public protocol FileTypeProtocol {
    
    var mime: String { get }
    var extensions: [String] { get }
    
}

public enum FileType: FileTypeProtocol {
    
    case audio(Audio)
    case document(Document)
    case image(Image)
    case video(Video)
    
    case custom(mime: String,
                extensions: [String])
    
    case unknown
    
    public var mime: String {
        
        return switch self {
        case .audio(let audio): audio.mime
        case .document(let doc): doc.mime
        case .image(let image): image.mime
        case .video(let video): video.mime
        case .custom(let mime, _): mime
        case .unknown: "unknown"
        }
        
    }

    public var extensions: [String] {
        
        return switch self {
        case .audio(let audio): audio.extensions
        case .document(let doc): doc.extensions
        case .image(let image): image.extensions
        case .video(let video): video.extensions
        case .custom(_, let exts): exts
        case .unknown: []
        }
        
    }
    
}

public extension FileType /* Audio */ {
    
    enum Audio: FileTypeProtocol {
        
        case aac
        case mp3
        
        public var mime: String {
                        
            return switch self {
            case .aac: "audio/aac"
            case .mp3: "audio/mpeg"
            }
                        
        }
        
        public var extensions: [String] {
            
            return switch self {
            case .aac: ["aac", "m4a"]
            case .mp3: ["mp3"]
            }
            
        }
        
    }
    
}

public extension FileType /* Document */ {
    
    enum Document: FileTypeProtocol {
        
        case md
        case pdf
        case txt
        
        public var mime: String {
                        
            return switch self {
            case .md: "text/markdown"
            case .pdf: "application/pdf"
            case .txt: "text/plain"
            }
                        
        }
        
        public var extensions: [String] {
            
            return switch self {
            case .md: ["md"]
            case .pdf: ["pdf"]
            case .txt: ["txt"]
            }
            
        }
        
    }
    
}

public extension FileType /* Image */ {
    
    enum Image: FileTypeProtocol {
        
        case gif
        case png
        case jpg
        
        public var mime: String {
                        
            return switch self {
            case .gif: "image/gif"
            case .png: "image/png"
            case .jpg: "image/jpeg"
            }
                        
        }
        
        public var extensions: [String] {
            
            return switch self {
            case .gif: ["gif"]
            case .png: ["png"]
            case .jpg: ["jpg", "jpeg"]
            }
            
        }
        
    }
    
}

public extension FileType /* Video */ {
    
    enum Video: FileTypeProtocol {
        
        case mp4
        
        public var mime: String {
                        
            return switch self {
            case .mp4: "video/mp4"
            }
                        
        }
        
        public var extensions: [String] {
            
            return switch self {
            case .mp4: ["mp4"]
            }
            
        }
        
    }
    
}
