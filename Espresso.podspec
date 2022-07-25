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
    # - UI
    #     - UI-UIKit
    #     - UI-SwiftUI
    # - Combine
    #     - Combine-Core
    #     - Combine-UIKit
    # - Rx
    #     - Rx-Core
    #     - Rx-UIKit
    # - Promise
    #     - Promise-Core
    # 
    # - UIKit
    # - SwiftUI
    # - All
    # 
    # - Recipe-Modern-UIKit
    #     - Espresso/UI-UIKit
    #     - Espresso/Combine-UIKit
    #     - Spider-Web
    #     - Director
    #     - Swinject
    # 
    #  - Recipe-Rx-UIKit
    #     - Espresso/UI-UIKit
    #     - Espresso/Rx-UIKit
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

        ss.dependency     'Espresso/UI-UIKit'
        ss.dependency     'Espresso/UI-SwiftUI'

    end

    s.subspec 'UI-UIKit' do |ss|

        ss.source_files = 'Espresso/Classes/UI/UIKit/**/*'
        ss.dependency     'Espresso/Core'

        ss.dependency     'SnapKit', '~> 5.0'

    end

    s.subspec 'UI-SwiftUI' do |ss|

        ss.source_files = 'Espresso/Classes/UI/SwiftUI/**/*'
        ss.dependency     'Espresso/UI-UIKit'

    end

    ## Combine

    s.subspec 'Combine' do |ss|

        ss.dependency     'Espresso/Combine-Core'
        ss.dependency     'Espresso/Combine-UIKit'

    end

    s.subspec 'Combine-Core' do |ss|

        ss.source_files = 'Espresso/Classes/Combine/Core/**/*'
        ss.dependency     'Espresso/Core'

    end

    s.subspec 'Combine-UIKit' do |ss|

        ss.source_files = 'Espresso/Classes/Combine/UIKit/**/*'
        ss.dependency     'Espresso/Combine-Core'
        ss.dependency     'Espresso/UI-UIKit'

    end

    ## Rx

    s.subspec 'Rx' do |ss|

        ss.dependency     'Espresso/Rx-Core'
        ss.dependency     'Espresso/Rx-UIKit'

    end

    s.subspec 'Rx-Core' do |ss|

        ss.source_files = 'Espresso/Classes/Rx/Core/**/*'
        ss.dependency     'Espresso/Core'

        ss.dependency     'RxSwift', '~> 6.0'
        ss.dependency     'RxCocoa', '~> 6.0'

    end

    s.subspec 'Rx-UIKit' do |ss|

        ss.source_files = 'Espresso/Classes/Rx/UIKit/**/*'
        ss.dependency     'Espresso/Rx-Core'
        ss.dependency     'Espresso/UI-UIKit'

    end

    ## Promise

    s.subspec 'Promise' do |ss|

        ss.dependency     'Espresso/Promise-Core'

    end

    s.subspec 'Promise-Core' do |ss|

        ss.source_files = 'Espresso/Classes/Promise/Core/**/*'
        
        ss.dependency     'PromiseKit', '~> 6.0'

    end

    ## Aggregates

    s.subspec 'UIKit' do |ss|

        ss.dependency     'Espresso/Core'
        ss.dependency     'Espresso/UI-UIKit'
        ss.dependency     'Espresso/Combine-UIKit'
        ss.dependency     'Espresso/Rx-UIKit'

    end

    s.subspec 'SwiftUI' do |ss|

        ss.dependency     'Espresso/Core'
        ss.dependency     'Espresso/UI-SwiftUI'
        ss.dependency     'Espresso/Combine-Core'
        ss.dependency     'Espresso/Rx-Core'

    end

    s.subspec 'All' do |ss|

        ss.dependency     'Espresso/Core'
        ss.dependency     'Espresso/UI'
        ss.dependency     'Espresso/Combine'
        ss.dependency     'Espresso/Rx'
        ss.dependency     'Espresso/Promise'

    end

    ## Recipes

    s.subspec 'Recipe-Modern-UIKit' do |ss|

        ss.dependency     'Espresso/UI-UIKit'
        ss.dependency     'Espresso/Combine-UIKit'

        ss.dependency     'Spider-Web', '~> 2.0'
        ss.dependency     'Director',   '~> 1.0'
        ss.dependency     'Swinject',   '~> 2.0'

    end

    s.subspec 'Recipe-Rx-UIKit' do |ss|

        ss.dependency     'Espresso/UI-UIKit'
        ss.dependency     'Espresso/Rx-UIKit'

        ss.dependency     'Spider-Web', '~> 2.0'
        ss.dependency     'Director',   '~> 1.0'
        ss.dependency     'Swinject',   '~> 2.0'

    end

end
