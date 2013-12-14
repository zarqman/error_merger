module ErrorMerger
  # merges an association's Errors set into the current set
  # eg: @user.errors.merge @account
  #     @user.errors.merge @account, "Account ##{@account.id}: "
  def merge(association, prefix=nil)
    if association.errors.respond_to? :full_message
      prefix ||= "#{association.class.model_name.human}: "
      association.errors.each do |attr, error|
        add :base, "#{prefix}#{association.errors.full_message(attr, error)}"
      end
    else
      association.errors.each do |error|
        add :base, error
      end
    end
  end

end

ActiveModel::Errors.send :include, ErrorMerger
