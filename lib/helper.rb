# frozen_string_literal: true

def demodulize(klass)
  klass.class.name&.split('::').last
end

def get_selected_option(prompt, options)
  option = nil
  while option.nil?
    printf("> #{prompt} ")
    option = gets.chomp.to_i
    unless options.include?(option)
      option = nil
      printf("> Invalid option! Try again.\n".red)
    end
  end

  option
end
