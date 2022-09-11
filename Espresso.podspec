Pod::Spec.new do |s|

    s.name             = 'Espresso'
    s.version          = '3.0.0'
    s.summary          = 'Swift convenience library for iOS.'

    s.description      = <<-DESC
      Espresso is a Swift convenience library for iOS.
      Everything is better with a little coffee.
      DESC

    s.homepage                  = 'https://github.com/mitchtreece/Espresso'
    s.license                   = { :type => 'MIT', :file => 'LICENSE' }
    s.author                    = { 'Mitch Treece' => 'mitchtreece@me.com' }
    s.source                    = { :git => 'https://github.com/mitchtreece/Espresso.git', :tag => s.version.to_s }
    s.social_media_url          = 'https://twitter.com/mitchtreece'

    s.swift_version             = '5'
    s.ios.deployment_target     = '13.0'

    # Subspecs

    # - Core
    #     - Core-Core
    #     - Core-Types
    #
    # - UI
    #     - UI-Core
    #     - UI-UIKit
    #     - UI-SwiftUI
    #
    # - PromiseKit
    #     - PromiseKit-Core
    # 
    # - UIKit
    # - SwiftUI
    # - All
    # 
    # - Recipe-Modern-UIKit
    #     - Espresso/UI-UIKit
    #     - Espresso/PromiseKit
    #     - Spider-Web
    #     - Director
    #     - Swinject

    s.default_subspec = 'UIKit'

    ## Core

    s.subspec 'Core' do |ss|

        ss.dependency     'Espresso/Core-Core'
        ss.dependency     'Espresso/Core-Types'

    end

    s.subspec 'Core-Core' do |ss|

        ss.source_files = 'Espresso/Classes/Core/Core/**/*'

    end

    s.subspec 'Core-Types' do |ss|

        ss.source_files = 'Espresso/Classes/Core/Types/**/*'

    end

    ## UI

    s.subspec 'UI' do |ss|

        ss.dependency     'Espresso/UI-Core'
        ss.dependency     'Espresso/UI-UIKit'
        ss.dependency     'Espresso/UI-SwiftUI'

    end

    s.subspec 'UI-Core' do |ss|

        ss.source_files = 'Espresso/Classes/UI/Core/**/*'
        ss.dependency     'Espresso/Core'

    end

    s.subspec 'UI-UIKit' do |ss|

        ss.source_files = 'Espresso/Classes/UI/UIKit/**/*'
        ss.dependency     'Espresso/UI-Core'

        ss.dependency     'SnapKit', '~> 5.0'

    end

    s.subspec 'UI-SwiftUI' do |ss|

        ss.source_files = 'Espresso/Classes/UI/SwiftUI/**/*'
        ss.dependency     'Espresso/UI-Core'

    end

    ## Promise

    s.subspec 'PromiseKit' do |ss|

        ss.dependency     'Espresso/PromiseKit-Core'

    end

    s.subspec 'PromiseKit-Core' do |ss|

        ss.source_files = 'Espresso/Classes/PromiseKit/Core/**/*'
        ss.dependency     'Espresso/Core'

        ss.dependency     'PromiseKit', '~> 6.0'

    end

    ## Aggregates

    s.subspec 'UIKit' do |ss|

        ss.dependency     'Espresso/Core'
        ss.dependency     'Espresso/UI-UIKit'

    end

    s.subspec 'SwiftUI' do |ss|

        ss.dependency     'Espresso/Core'
        ss.dependency     'Espresso/UI-SwiftUI'

    end

    s.subspec 'All' do |ss|

        ss.dependency     'Espresso/Core'
        ss.dependency     'Espresso/UI'
        ss.dependency     'Espresso/PromiseKit'

    end

    ## Recipes

    s.subspec 'Recipe-Modern-UIKit' do |ss|

        ss.dependency     'Espresso/UI-UIKit'
        ss.dependency     'Espresso/PromiseKit'

        ss.dependency     'Spider-Web', '~> 2.0'
        ss.dependency     'Director',   '~> 1.0'
        ss.dependency     'Swinject',   '~> 2.0'

    end

end
