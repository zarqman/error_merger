# ErrorMerger

Adds a .merge method to ActiveModel-compliant models.

Allows the merging/consolidation of errors on multiple models to make it easy
to pass into some kind of error renderer.

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
  @account = Account.new account_params
  @account.errors.merge @user

  @account.errors.to_sentence # => will include errors for both Account and User
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
