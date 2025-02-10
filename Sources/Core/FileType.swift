//
//  FileType.swift
//  Espresso
//
//  Created by Mitch on 2/9/25.
//

// MIME Types
// Anything not found on the official list, should
// generally be prefixed with "x-", i.e. "x-7z-compressed"
//
// https://www.iana.org/assignments/media-types/media-types.xhtml

import Foundation

public protocol FileTypeProtocol {
    
    var mime: String { get }
    var exts: [String] { get }
    
}

public enum FileType: FileTypeProtocol {
    
    case application(Application)
    case audio(Audio)
    case font(Font)
    case image(Image)
    case text(Text)
    case video(Video)
    
    case custom(mime: String,
                extensions: [String])
    
    case unknown
    
    public var mime: String {
        
        return switch self {
        case .application(let app): app.mime
        case .audio(let audio): audio.mime
        case .font(let font): font.mime
        case .image(let image): image.mime
        case .text(let text): text.mime
        case .video(let video): video.mime
        case .custom(let mime, _): mime
        case .unknown: "unknown"
        }
        
    }

    public var exts: [String] {
        
        return switch self {
        case .application(let app): app.exts
        case .audio(let audio): audio.exts
        case .font(let font): font.exts
        case .image(let image): image.exts
        case .text(let text): text.exts
        case .video(let video): video.exts
        case .custom(_, let exts): exts
        case .unknown: []
        }
        
    }
    
}

public extension FileType /* Application */ {
    
    enum Application: FileTypeProtocol {
        
        case bin
        case bz
        case bz2
        case bz3
        case `class`
        case doc
        case docx
        case epub
        case gtar
        case gz
        case jar
        case json
        case jsonld
        case mpkg
        case odp
        case ods
        case odt
        case ogx
        case pdf
        case php
        case ppt
        case pptx
        case rar
        case ser
        case sevenZip
        case sh
        case tar
        case xls
        case xlsx
        case xhtml
        case xml
        case zip
        
        public var mime: String {
                        
            return switch self {
            case .bin: "application/octet-stream"
            case .bz: "application/x-bzip"
            case .bz2: "application/x-bzip2"
            case .bz3: "application/vnd.bzip3"
            case .class: "application/x-java-vm"
            case .doc: "application/msword"
            case .docx: "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            case .epub: "application/epub+zip"
            case .gtar: "application/x-gtar"
            case .gz: "application/gzip"
            case .jar: "application/java-archive"
            case .json: "application/json"
            case .jsonld: "application/ld+json"
            case .mpkg: "application/vnd.apple.installer+xml"
            case .odp: "application/vnd.oasis.opendocument.presentation"
            case .ods: "application/vnd.oasis.opendocument.spreadsheet"
            case .odt: "application/vnd.oasis.opendocument.text"
            case .ogx: "application/ogg"
            case .pdf: "application/pdf"
            case .php: "application/x-httpd-php"
            case .ppt: "application/vnd.ms-powerpoint"
            case .pptx: "application/vnd.openxmlformats-officedocument.presentationml.presentation"
            case .rar: "application/vnd.rar"
            case .ser: "application/x-java-serialized-object"
            case .sevenZip: "application/x-7z-compressed"
            case .sh: "application/x-sh"
            case .tar: "application/x-tar"
            case .xls: "application/vnd.ms-excel"
            case .xlsx: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            case .xhtml: "application/xhtml+xml"
            case .xml: "application/xml"
            case .zip: "application/zip"
            }
                        
        }
        
        public var exts: [String] {
            
            return switch self {
            case .bin: ["bin", "exe"]
            case .bz: ["bz"]
            case .bz2: ["bz2", "boz"]
            case .bz3: ["bz3"]
            case .class: ["class"]
            case .doc: ["doc"]
            case .docx: ["docx"]
            case .epub: ["epub"]
            case .gtar: ["gtar"]
            case .gz: ["gz"]
            case .jar: ["jar"]
            case .json: ["json"]
            case .jsonld: ["jsonld"]
            case .mpkg: ["mpkg"]
            case .odp: ["odp"]
            case .ods: ["ods"]
            case .odt: ["odt"]
            case .ogx: ["ogx"]
            case .pdf: ["pdf"]
            case .php: ["php"]
            case .ppt: ["ppt"]
            case .pptx: ["pptx"]
            case .rar: ["rar"]
            case .ser: ["ser"]
            case .sevenZip: ["7z"]
            case .sh: ["sh"]
            case .tar: ["tar"]
            case .xls: ["xls"]
            case .xlsx: ["xlsx"]
            case .xhtml: ["xhtml"]
            case .xml: ["xml"]
            case .zip: ["zip"]
            }
            
        }
        
    }
    
}

public extension FileType /* Audio */ {
    
    enum Audio: FileTypeProtocol {
        
        case aac
        case midi
        case mp3
        case oga
        case opus
        case threeGP
        case threeGP2
        case wav
        case weba
        
        public var mime: String {
                        
            return switch self {
            case .aac: "audio/aac"
            case .midi: "audio/x-midi"
            case .mp3: "audio/mpeg"
            case .oga: "audio/ogg"
            case .opus: "audio/opus"
            case .threeGP: "audio/3gpp"
            case .threeGP2: "audio/3gpp2"
            case .wav: "audio/x-wav"
            case .weba: "audio/x-webm"
            }
                        
        }
        
        public var exts: [String] {
            
            return switch self {
            case .aac: ["aac", "m4a"]
            case .midi: ["mid", "midi"]
            case .mp3: ["mp3"]
            case .oga: ["oga"]
            case .opus: ["opus"]
            case .threeGP: ["3gp"]
            case .threeGP2: ["3g2"]
            case .wav: ["wav"]
            case .weba: ["weba"]
            }
            
        }
        
    }
    
}

public extension FileType /* Font */ {
    
    enum Font: FileTypeProtocol {
        
        case otf
        case ttf
        case woff
        case woff2
        
        public var mime: String {
                        
            return switch self {
            case .otf: "font/otf"
            case .ttf: "font/ttf"
            case .woff: "font/woff"
            case .woff2: "font/woff2"
            }
                        
        }
        
        public var exts: [String] {
            
            return switch self {
            case .otf: ["otf"]
            case .ttf: ["ttf"]
            case .woff: ["woff"]
            case .woff2: ["woff2"]
            }
            
        }
        
    }
    
}

public extension FileType /* Image */ {
    
    enum Image: FileTypeProtocol {
        
        case apng
        case avif
        case bmp
        case gif
        case ico
        case jpg
        case png
        case svg
        case tiff
        case webp
        
        public var mime: String {
                        
            return switch self {
            case .apng: "image/apng"
            case .avif: "image/avif"
            case .bmp: "image/bmp"
            case .gif: "image/gif"
            case .ico: "image/x-icon"
            case .jpg: "image/jpeg"
            case .png: "image/png"
            case .svg: "image/svg+xml"
            case .tiff: "image/tiff"
            case .webp: "image/webp"
            }
                        
        }
        
        public var exts: [String] {
            
            return switch self {
            case .apng: ["apng"]
            case .avif: ["avif"]
            case .bmp: ["bmp"]
            case .gif: ["gif"]
            case .ico: ["ico"]
            case .jpg: ["jpg", "jpeg"]
            case .png: ["png"]
            case .svg: ["svg"]
            case .tiff: ["tiff", "tif"]
            case .webp: ["webp"]
            }
            
        }
        
    }
    
}

public extension FileType /* Text */ {
    
    enum Text: FileTypeProtocol {
        
        case css
        case csv
        case html
        case ics
        case js
        case md
        case rtf
        case txt
        
        public var mime: String {
                        
            return switch self {
            case .css: "text/css"
            case .csv: "text/csv"
            case .html: "text/html"
            case .ics: "text/calendar"
            case .js: "text/javascript"
            case .md: "text/markdown"
            case .rtf: "text/richtext"
            case .txt: "text/plain"
            }
                        
        }
        
        public var exts: [String] {
            
            return switch self {
            case .css: ["css"]
            case .csv: ["csv"]
            case .html: ["html", "htm"]
            case .ics: ["ics"]
            case .js: ["js", "mjs"]
            case .md: ["md", "markdown", "mdown", "markdn"]
            case .rtf: ["rtf", "rtx"]
            case .txt: ["txt"]
            }
            
        }
        
    }
    
}

public extension FileType /* Video */ {
    
    enum Video: FileTypeProtocol {
        
        case avi
        case mp4
        case mov
        case mpg
        case ogv
        case threeGP
        case threeGP2
        case ts
        case webm
        
        public var mime: String {
                        
            return switch self {
            case .avi: "video/x-msvideo"
            case .mp4: "video/mp4"
            case .mov: "video/quicktime"
            case .mpg: "video/mpeg"
            case .ogv: "video/ogg"
            case .threeGP: "video/3gpp"
            case .threeGP2: "video/3gpp2"
            case .ts: "video/mp2t"
            case .webm: "video/x-webm"
            }
                        
        }
        
        public var exts: [String] {
            
            return switch self {
            case .avi: ["avi"]
            case .mp4: ["mp4"]
            case .mov: ["mov", "qt"]
            case .mpg: ["mpg", "mpeg"]
            case .ogv: ["ogv"]
            case .threeGP: ["3gp"]
            case .threeGP2: ["3g2"]
            case .ts: ["ts"]
            case .webm: ["webm"]
            }
            
        }
        
    }
    
}
