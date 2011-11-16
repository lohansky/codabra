module LocaleDispatcher
  LOCALES = ['en', 'ru'].freeze
  TRANSLATE = {'ru' => I18n.t(:'languages.russian'),
               'en' => I18n.t(:'languages.english')}.freeze

  class << self
    def generate_for_select_box
      LOCALES.map do |locale|
        [TRANSLATE[locale], locale]
      end
    end

    def locale(codabra)
      return codabra.locale if codabra
      'en'
    end

    def locale_name(codabra)
      TRANSLATE[self.locale(codabra)]
    end
  end
end
