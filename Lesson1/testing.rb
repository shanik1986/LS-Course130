def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new { puts "Hi #{name}" }
name = "Griffin III"

call_me(chunk_of_code)
