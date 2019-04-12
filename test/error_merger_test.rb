require 'test_helper'

class ErrorMergerTest < ActiveSupport::TestCase

  setup do
    @author = Author.new
    @author.errors.add :name, :blank
  end


  test "merge Model" do
    @book = Book.new
    @book.errors.merge @author
    assert_equal({base: ["Author: Name can't be blank"]}, @book.errors.messages)
    assert_equal ["Author: Name can't be blank"], @book.errors.full_messages

    @book = Book.new
    @book.errors.merge @author, ''
    assert_equal({base: ["Name can't be blank"]}, @book.errors.messages)
    assert_equal ["Name can't be blank"], @book.errors.full_messages

    @book = Book.new
    @book.errors.merge @author, false
    assert_equal({base: ["Name can't be blank"]}, @book.errors.messages)
    assert_equal ["Name can't be blank"], @book.errors.full_messages

    @book = Book.new
    @book.errors.merge @author, attribute: :author
    assert_equal({author: ["Name can't be blank"]}, @book.errors.messages)
    assert_equal ["Author Name can't be blank"], @book.errors.full_messages

    @book = Book.new
    @book.errors.merge @author, '- ', attribute: :author
    assert_equal({author: ["- Name can't be blank"]}, @book.errors.messages)
    assert_equal ["Author - Name can't be blank"], @book.errors.full_messages
  end

  test "merge AM::Errors" do
    @book = Book.new
    @book.errors.merge @author.errors
    assert_equal({base: ["Author: Name can't be blank"]}, @book.errors.messages)

    @book = Book.new
    @book.errors.merge @author.errors, ''
    assert_equal({base: ["Name can't be blank"]}, @book.errors.messages)
  end

  test "merge Array" do
    @error_array = ["Something is invalid"]

    @book = Book.new
    @book.errors.merge @error_array
    assert_equal({base: ["Something is invalid"]}, @book.errors.messages)

    @book = Book.new
    @book.errors.merge @error_array, 'Prefix', attribute: :whatev
    assert_equal({whatev: ["Prefix Something is invalid"]}, @book.errors.messages)
    assert_equal ["Whatev Prefix Something is invalid"], @book.errors.full_messages
  end

  test "merge Hash" do
    @error_hash   = {something: "Something is invalid"}
    @error_hash_2 = {something: ["Something is invalid"]}

    @book = Book.new
    @book.errors.merge @error_hash, ''
    assert_equal({base: ["Something is invalid"]}, @book.errors.messages)

    @book = Book.new
    @book.errors.merge @error_hash_2, ''
    assert_equal({base: ["Something is invalid"]}, @book.errors.messages)
  end

  test "merge Errors-like" do
    e1 = ["Not valid"]
    e1.instance_variable_set :@base, Author.new

    @book = Book.new
    @book.errors.merge e1
    assert_equal({base: ["Author: Not valid"]}, @book.errors.messages)
  end


  test "sentences" do
    assert_equal "Name is invalid.", @author.errors.full_sentence(:name, "is invalid")
    assert_equal "Name is invalid.", @author.errors.full_sentence(:name, "is invalid.")

    @author.errors.add :name, :invalid
    assert_equal ["Name can't be blank.", "Name is invalid."], @author.errors.full_sentences
    assert_equal "Name can't be blank. Name is invalid.", @author.errors.join_sentences
    assert_equal "Name can't be blank. Name is invalid.", @author.errors.as_sentences
  end

end
