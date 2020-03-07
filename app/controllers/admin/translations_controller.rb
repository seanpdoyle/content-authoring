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
      record = Translation.find_or_initialize_by(translation_params.slice(
        :locale,
        :key,
      ))
      translation = translate(record.key, locale: record.locale)

      if translation.is_a?(Array)
        attributes = params.require(:translation).permit(
          :key,
          :locale,
          value: {},
        )
        attributes[:value] = attributes[:value].values

        record.update!(attributes)
      else
        record.update!(translation_params)
      end

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
