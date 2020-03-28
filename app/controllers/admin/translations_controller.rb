module Admin
  class TranslationsController < ApplicationController
    def edit
      translation = Translation.find_or_initialize_by(
        key: params[:id],
        locale: I18n.locale,
      )
      translation.assign_attributes(value: translate(params[:id]))

      render locals: {
        attribute: params[:attribute_id],
        translation: translation,
      }
    end

    def create
      translation = Translation.find_or_initialize_by(translation_params.slice(
        :locale,
        :key,
      ))

      translation.update!(translation_params)

      redirect_back fallback_location: root_path
    end

    private

    def translation_params
      params.require(:translation).permit(
        :key,
        :value,
        :locale,
      )
    end
  end
end
