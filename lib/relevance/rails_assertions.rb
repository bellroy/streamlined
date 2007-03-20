module Relevance; end
module Relevance::RailsAssertions
  def assert_true(expr, *args)
    assert_equal(true, expr, *args)
  end

  def assert_false(expr, *args)
    assert_equal(false, expr, *args)
  end

  def assert_create_form
    assert_form(form_fields.merge(:post=>url_for_create))
  end

  def assert_update_form
    assert_form(form_fields.merge(:post=>url_for_update))
  end

  # since Rails assert_response does not support e.g. ranges
  def assert_success_or_redirect
    assert((200...400)===@response.response_code, "response should be success or redirect, was #{@response.response_code}")
  end

  def assert_assigns(name)
    value = assigns(name)
    assert_not_nil(value, "Should assign a value for @#{name}")
    value
  end

  def assert_not_valid(model)
    assert(!model.valid?, "Should be valid: #{model}")
  end

  def assert_form(options)
    @html_document = nil  # TODO: this should not be necessary
    url = options[:post]
    if url
      url = url_for(url.merge(:only_path=>true)) if Hash===url
      actions = assert_select("form").map {|x| x["action"]}
      assert_select("form[action=#{url}]", {:count=>1}, "Expected #{url}, got #{actions.inspect}") do
        [:input, :textarea, :select].each do |type|
          fields = options[type]
          if fields
            fields.each do |field|
              field = "#{form_model_name}_#{field}" if form_model_name
              assert_select("#{type}[id=#{field}]", :count=>1)  
            end
          end          
        end
      end
    end
  end
end