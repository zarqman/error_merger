module ErrorMerger

  # merges an association's Errors set into the current set
  # eg: @user.errors.merge @account
  #     @user.errors.merge @account, "Account ##{@account.id}: "
  def merge(association, prefix=nil)
    if association.errors.respond_to? :full_message
      prefix ||= "#{association.errors.instance_variable_get(:@base).class.model_name.human}: "
      association.errors.each do |attr, error|
        add :base, "#{prefix}#{association.errors.full_message(attr, error)}"
      end
    else
      association.errors.each do |error|
        add :base, error
      end
    end
  end

  def full_sentences
    map{ |attr, m| full_sentence(attr, m) }
  end

  def full_sentence(attribute, message)
    m = full_message(attribute, message)
    m.ends_with?('.') ? m : "#{m}."
  end

  def as_sentences
    full_sentences.join ' '
  end

end

ActiveModel::Errors.include ErrorMerger
