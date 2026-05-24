Markdown

# Ruby Programming Essentials: Methods & Classes

Welcome to the Ruby Programming Essentials repository! This guide serves as a comprehensive reference for fundamental Ruby concepts, specifically focusing on **Methods (Functions)** and **Class Structures**. Understanding these concepts is critical for building custom security tools, automation scripts, and penetration testing modules (such as those used in the Metasploit Framework).

---

## 📋 Table of Contents
1. [Method Definition & Naming Conventions](#1-method-definition--naming-conventions)
2. [Implicit Returns (The Ruby Way)](#2-implicit-returns-the-ruby-way)
3. [Method Arguments & Default Values](#3-method-arguments--default-values)
4. [Variable Arguments (Splat Operator)](#4-variable-arguments-splat-operator)
5. [Class Methods vs. Instance Methods](#5-class-methods-vs-instance-methods)
6. [The `alias` Statement](#6-the-alias-statement)

---

## 1. Method Definition & Naming Conventions

In Ruby, methods are defined using the `def` keyword and closed with `end`. 

### Naming Rules:
* Method names **must start with a lowercase letter** or an underscore (`_`).
* Starting a method name with an uppercase letter will result in a syntax error because uppercase names are reserved for constants and classes in Ruby.
* The standard convention is `snake_case` (all lowercase with underscores separating words).

```ruby
# ❌ INCORRECT (Will cause a Syntax Error)
def MethodName
  puts "This will fail"
end

#  CORRECT
def method_name
  puts "This is the correct Ruby way"
end

2. Implicit Returns (The Ruby Way)

One of Ruby's most unique features is implicit return. If no explicit return statement is used, a Ruby method automatically returns the value of the last executed statement.
Ruby

def calculate
   x = 10
   y = 20
   z = 30 # This is the last executed statement
end

result = calculate
puts result # Output: 30

    ⚠️ Important Note on puts: > The puts method outputs text to the console, but it always returns nil. If your last line is a puts statement, the method will return nil.
    Ruby

    def calculate_with_puts
      z = 30
      puts z
    end
    # This method will print 30, but its return value is actually nil!

3. Method Arguments & Default Values

Ruby allows you to assign default values to method parameters. If an argument is missing during the method call, the default value kicks in. Parentheses are also optional when calling methods in Ruby.
Ruby

def test_language(a1 = "Python", a2 = "Java")
  puts "The programming language is #{a1}"
  puts "The programming language is #{a2}"
end

# Call option 1: Providing both arguments
test_language("Ruby", "C#")
# Output:
# The programming language is Ruby
# The programming language is C#

# Call option 2: Providing no arguments (Uses defaults)
test_language
# Output:
# The programming language is Python
# The programming language is Java

# Call option 3: Providing only one argument (omitting parentheses)
test_language 25

4. Variable Arguments (Splat Operator)

If you need a method to accept an unpredictable, flexible number of parameters, use the Splat Operator (*). This bundles incoming arguments into a single Array inside the method.
Ruby

def target_scanners(*args)
  puts "Scanning targets: #{args.inspect}"
end

target_scanners("192.168.1.1")
target_scanners("10.0.0.1", "10.0.0.2", "10.0.0.5") 
# Output: Scanning targets: ["10.0.0.1", "10.0.0.2", "10.0.0.5"]

5. Class Methods vs. Instance Methods

Understanding the architectural difference between Class methods and Instance methods is crucial for framework interaction (like writing custom Metasploit modules).

    Instance Methods: Require an object (instance) of the class to be created using .new before they can be called.

    Class Methods: Can be called directly on the Class itself without creating an instance. They are usually prefixed with self..

Ruby

class Scanner
  # Instance Method
  def run_scan
    puts "Scanning single target..."
  end

  # Class Method
  def self.version
    puts "Scanner v2.4.1"
  end
end

# Calling Instance Method
my_scanner = Scanner.new
my_scanner.run_scan

# Calling Class Method (No instance needed!)
Scanner.version

6. The alias Statement

The alias statement is used to create a copy or an alternate name for an existing method or global variable.

    🛑 Constraint: alias cannot be defined within a method body. It must be declared directly within the class scope or top-level scope.

Ruby

class Exploit
  def launch
    puts "Exploit fired!"
  end

  # Defining alias within the class scope
  alias fire launch
end

payload = Exploit.new
payload.fire # Output: Exploit fired!
