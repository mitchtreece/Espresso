Pod::Spec.new do |s|

    s.name             = 'Espresso'
    s.version          = '2.4.1'
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
    s.ios.deployment_target     = '11.0'

    # Subspecs

    s.default_subspec = 'UIKit'

    s.subspec 'Core' do |core|

        core.source_files       = 'Espresso/Classes/Core/**/*'
        core.dependency         'Swinject', '~> 2.0'

    end

    s.subspec 'UIKit' do |uikit|

        uikit.source_files      = 'Espresso/Classes/UIKit/**/*'
        uikit.dependency        'Espresso/Core'
        uikit.dependency        'SnapKit', '~> 5.0'

    end

    s.subspec 'Rx' do |rx|

        rx.source_files         = 'Espresso/Classes/Rx/**/*'
        rx.dependency           'Espresso/Core'
        rx.dependency           'RxSwift', '~> 6.0'
        rx.dependency           'RxCocoa', '~> 6.0'

    end

    s.subspec 'Rx-UIKit' do |rxuikit|

        rxuikit.source_files    = 'Espresso/Classes/Rx-UIKit/**/*'
        rxuikit.dependency      'Espresso/Rx'
        rxuikit.dependency      'Espresso/UIKit'

    end

    s.subspec 'All' do |all|

        all.dependency          'Espresso/Core'
        all.dependency          'Espresso/UIKit'
        all.dependency          'Espresso/Rx'
        all.dependency          'Espresso/Rx-UIKit'

    end

end
