class TranslationsController < ApplicationController
  def create
    translation = Translation.new(translation_params)

    if translation.save
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
