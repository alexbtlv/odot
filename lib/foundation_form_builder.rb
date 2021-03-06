class FoundationFormBuilder < ActionView::Helpers::FormBuilder
	include ActionView::Helpers::TagHelper
	include ActionView::Helpers::CaptureHelper
	include ActionView::Helpers::TextHelper

	attr_accessor :output_buffer

	%w(text_field email_field password_field).each do |form_method|
		define_method(form_method) do |*args|
			attribute = args[0]
			options = args[1] || {}
			options[:label] ||= attribute.to_s.titleize
			label_text ||= options.delete(:label)
			label_options ||= {}
			wrapper_options ||= {}
			if errors_on?(attribute)
				wrapper_options = { wrapper_classes: "error" }
			end
			wrapper(wrapper_options) do
				label(attribute, label_text, label_options) +
				super(attribute, options) + errors_for_field(attribute)		
			end	
		end
	end

	def text_field(attribute, options={})
		options[:label] ||= attribute
		label_text ||= options.delete(:label).to_s.titleize
		label_options ||= {}
		wrapper_options ||= {}
		if errors_on?(attribute)
			wrapper_options = { wrapper_classes: "error" }
		end
		wrapper(wrapper_options) do
			label(attribute, label_text, label_options) +
			super(attribute, options) + errors_for_field(attribute)		
		end	
	end

	def submit(text, options={})
		options[:class] ||= "button radius expand"
		wrapper do
			super(text, options)
		end
	end

	def wrapper(options={}, &block)
		content_tag(:div, class: "row") do
			content_tag(:div, capture(&block), class: "small-12 column #{options[:wrapper_classes]}")
		end
	end

	def errors_on?(attribute)
		object.errors[attribute].size > 0
	end

	def errors_for_field(attribute, options={})
		return "" if object.errors[attribute].empty?
		content_tag(:small, object.errors[attribute].to_sentence.capitalize, class: "error")
	end
end