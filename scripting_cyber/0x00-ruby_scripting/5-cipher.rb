class CaesarCipher
  def initialize(shift)
    @shift=shift
  end
  
  def encrypt(message)
    cipher(message, @shift)
  end
  
  def decrypt(message)
    cipher(message, -@shift)
  end

  def cipher(message, shift)
    message.chars.map do |char|
      if char.match?(/[A-Z]/)
        (((char.ord - 65 + shift) % 26) +65).chr
      elsif char.match?(/a-z/)
        (((char.ord - 97 + shift) % 26) +65).chr
      else
        char
      end
    end.join
  end
end
