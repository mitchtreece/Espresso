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

    s.default_subspec = 'UIKit'

    ## Core

    s.subspec 'Core' do |core|

        core.dependency      'Espresso/Core-Core'
        core.dependency      'Espresso/Core-Types'

    end

    s.subspec 'Core-Core' do |core|

        core.source_files       = 'Espresso/Classes/Core/Core/**/*'
        core.dependency         'Swinject', '~> 2.0'

    end

    s.subspec 'Core-Types' do |core|

        core.source_files       = 'Espresso/Classes/Core/Types/**/*'

    end

    ## UI

    s.subspec 'UI' do |ui|

        ui.dependency      'Espresso/UI-UIKit'
        ui.dependency      'Espresso/UI-SwiftUI'

    end

    s.subspec 'UI-UIKit' do |ui|

        ui.source_files      = 'Espresso/Classes/UI/UIKit/**/*'
        ui.dependency        'Espresso/Core'
        ui.dependency        'SnapKit', '~> 5.0'

    end

    s.subspec 'UI-SwiftUI' do |ui|

        ui.source_files      = 'Espresso/Classes/UI/SwiftUI/**/*'
        ui.dependency        'Espresso/UI-UIKit'

    end

    ## Combine

    s.subspec 'Combine' do |combine|

        combine.dependency      'Espresso/Combine-Core'
        combine.dependency      'Espresso/Combine-UIKit'

    end

    s.subspec 'Combine-Core' do |combine|

        combine.source_files      = 'Espresso/Classes/Combine/Core/**/*'
        combine.dependency        'Espresso/Core'

    end

    s.subspec 'Combine-UIKit' do |combine|

        combine.source_files      = 'Espresso/Classes/Combine/UIKit/**/*'
        combine.dependency        'Espresso/Combine-Core'
        combine.dependency        'Espresso/UI-UIKit'

    end

    ## Rx

    s.subspec 'Rx' do |rx|

        rx.dependency      'Espresso/Rx-Core'
        rx.dependency      'Espresso/Rx-UIKit'

    end

    s.subspec 'Rx-Core' do |rx|

        rx.source_files      = 'Espresso/Classes/Rx/Core/**/*'
        rx.dependency          'Espresso/Core'
        rx.dependency          'RxSwift', '~> 6.0'
        rx.dependency          'RxCocoa', '~> 6.0'

    end

    s.subspec 'Rx-UIKit' do |rx|

        rx.source_files      = 'Espresso/Classes/Rx/UIKit/**/*'
        rx.dependency          'Espresso/Rx-Core'
        rx.dependency          'Espresso/UI-UIKit'

    end

    ## Aggregates

    s.subspec 'UIKit' do |uikit|

        uikit.dependency          'Espresso/Core'
        uikit.dependency          'Espresso/UI-UIKit'
        uikit.dependency          'Espresso/Combine-UIKit'
        uikit.dependency          'Espresso/Rx-UIKit'

    end

    s.subspec 'SwiftUI' do |swiftui|

        swiftui.dependency          'Espresso/Core'
        swiftui.dependency          'Espresso/UI-SwiftUI'
        swiftui.dependency          'Espresso/Combine-Core'
        swiftui.dependency          'Espresso/Rx-Core'

    end

    s.subspec 'All' do |all|

        all.dependency          'Espresso/Core'
        all.dependency          'Espresso/UI'
        all.dependency          'Espresso/Combine'
        all.dependency          'Espresso/Rx'

    end

end
