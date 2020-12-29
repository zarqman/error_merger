module ErrorMerger

  # merges an association's Errors set into the current set
  # eg: @user.errors.merge @account
  #     @user.errors.merge @account, "Account ##{@account.id}:"
  #     @user.errors.merge @account, attribute: :account
  def merge(assoc_or_errors, prefix=nil, attribute: :base)
    if assoc_or_errors.respond_to?(:errors) && assoc_or_errors.errors.is_a?(ActiveModel::Errors)
      errors = assoc_or_errors.errors
    else
      errors = assoc_or_errors
    end

    if attribute == :base && prefix.nil? && errors.instance_variable_defined?(:@base)
      prefix = "#{errors.instance_variable_get(:@base).class.model_name.human}: "
    else
      prefix ||= nil
    end
    prefix = "#{prefix} " if prefix =~ /[a-z0-9]$/i

    if errors.respond_to? :full_messages
      errors = errors.full_messages
    elsif errors.is_a? Hash
      errors = errors.values.flatten
    end

    errors.each do |error|
      add attribute, "#{prefix}#{error}"
    end
  end

  def full_sentences
    if defined?(ActiveModel::Error)
      map do |error|
        m = error.full_message
        m.end_with?('.') ? m : "#{m}."
      end
    else
      map{ |attr, m| full_sentence(attr, m) }
    end
  end

  def full_sentence(attribute, message)
    m = full_message(attribute, message)
    m.end_with?('.') ? m : "#{m}."
  end

  def join_sentences
    full_sentences.join ' '
  end

  alias_method :as_sentences, :join_sentences

end

ActiveModel::Errors.include ErrorMerger
