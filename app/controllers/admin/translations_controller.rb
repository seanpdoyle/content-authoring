module Admin
  class TranslationsController < ApplicationController
    def create
      translation = Translation.new(translation_params)

      if translation.valid?
        I18n.backend.store_translations(translation.locale, {
          translation.key => translation.value
        })

        redirect_back fallback_location: root_url
      else
        head :unprocessable_entity
      end
    end

    private

    def translation_params
      params.require(:translation).permit(:locale, :key, :value)
    end
  end
end
