# ErrorMerger

Adds a #merge method to ActiveModel-compliant models.

Allows the merging/consolidation of errors on multiple models to make it easy
to pass into some kind of error renderer.

Also adds #full_sentence and #full_sentences methods, with are comparable to
\#full_message and #full_messages respectively, except they ensure each error
message always ends with a period.

## Installation

Add this line to your application's Gemfile:

    gem 'error_merger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install error_merger


## Usage

```
  @user = User.new user_params
  @user.valid? # => false
  @account = Account.new account_params
  @account.valid? # => false
  @account.errors.merge @user

  @account.errors.full_messages # => will include errors for both Account and User

  @user.errors.full_messages # => ["Username can't be blank"]
  @user.errors.full_sentences # => ["Username can't be blank."]
  @user.errors.as_sentences # => "First name can't be blank. Last name can't be blank."
```

By default merged errors are prefixed with the model name. In the above example, an error on User might look like: "User: First name must not be blank".

The default behavior is the equivalent to: `@account.errors.merge @user, 'User: '`

To skip prefixing, pass an empty string: `''`.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
