module Associable
  extend ActiveSupport::Concern

  included do
    CustomField::ASSOCIABLE_MODEL_NAMES << associable_model_name
  end

  class_methods do
    def associable_model_name
      @associable_model_name ||= self.to_s.split('::')[-1].gsub(/(.)([A-Z])/, '\1_\2').downcase.to_sym
    end
  end
end
