# ErrorMerger

Adds a #merge method to ActiveModel-compliant models.

Allows the merging/consolidation of errors on multiple models to make it easy
to pass into some kind of error renderer.

Also adds #full_sentence and #full_sentences methods, with are comparable to
\#full_message and #full_messages respectively, except they ensure each error
message always ends with a period.

## Installation

In your Gemfile, add:

    gem 'error_merger'


## Usage

#### Merging

```
@user = User.new name: nil
@user.valid? # => false
@account = Account.new group: 'invalid'
@account.valid? # => false

## By default, will prefix with the merged model's name:
@account.errors.merge @user
@account.errors.full_messages  # will include errors for both Account and User
# => ["Group is invalid", "User: Name can't be blank"]

## Disable the prefix:
@account.errors.merge @user, ''
# @account.errors.merge @user, false  # equivalent to ''
@account.errors.full_messages
# => ["Group is invalid", "Name can't be blank"]

## Or change it:
@account.errors.merge @user, 'Member'
@account.errors.full_messages
# => ["Group is invalid", "Member Name can't be blank"]

## By default, merged errors are associated with the model, not an association
## (by adding the errors to :base). An attribute may be specified. Since the
## standard rendering of the error message will use the attribute name as part
## of the error message, auto-prefixing is disabled.
@account.errors.merge @user, attribute: :user
@account.errors.messages
# => {group: ["is invalid"], user: ["Name can't be blank"]}
@account.errors.full_messages
# => ["Group is invalid", "User Name can't be blank"]

## A prefix can still be added, however:
@account.errors.merge @user, 'Member', attribute: :user
@account.errors.full_messages
# => ["Group is invalid", "User Member Name can't be blank"]
```

_Hint: to merge the actual attributes directly, use the built-in `merge!` method instead._
```
## This may cause weird behavior if both models have the same attribute (eg: both
## have a :name attribute).
@account.errors.merge! @user.errors
@account.errors.messages
# => {group: ["is invalid"], name: ["can't be blank"]}
@account.errors.full_messages
# => ["Group is invalid", "Name can't be blank"]
```


### Sentences

```
## Rails default behavior:
@user.errors.full_messages
# => ["Name can't be blank"]

## Make errors nicer for display to users:
@user.errors.full_sentences
# => ["Name can't be blank."]

## Combine sentences into a single string:
@user.errors.join_sentences
# => "First name can't be blank. Last name can't be blank."
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
