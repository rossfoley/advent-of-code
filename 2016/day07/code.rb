class IPv7
  def initialize ip
    @address = ip
    @supernet_sequences = []
    @hypernet_sequences = []
    process_address
  end

  def process_address
    @address.scan /(\[?[a-z]+\]?)/ do |match|
      sequence = match[0]
      if sequence[0] == '['
        @hypernet_sequences << sequence[1...-1]
      else
        @supernet_sequences << sequence
      end
    end
  end

  def substring_window str, length
    (0..(str.length - length)).map {|i| str[i...(i+length)]}
  end

  # Part 1
  def supports_tls?
    supernet_abba = @supernet_sequences.any? {|s| contains_abba? s}
    hypernet_abba = @hypernet_sequences.any? {|s| contains_abba? s}
    supernet_abba && !hypernet_abba
  end

  # Match sequences like ABBA or RXXR but not CCCC
  def contains_abba? sequence
    substring_window(sequence, 4).any? do |str|
      str[0] != str[1] && str[0] == str[3] && str[1] == str[2]
    end
  end

  # Part 2
  def supports_ssl?
    supernet_abas = @supernet_sequences.flat_map {|s| aba_sequences s}
    hypernet_abas = @hypernet_sequences.flat_map {|s| aba_sequences s}
    supernet_babs = supernet_abas.map {|aba| invert_aba aba}
    (supernet_babs & hypernet_abas).any?
  end

  # Match sequences like ABA or RXR but not CCC
  def aba_sequences sequence
    substring_window(sequence, 3).map do |str|
      if str[0] != str[1] && str[0] == str[2]
        str
      else
        nil
      end
    end.compact
  end

  def invert_aba aba
    a, b = aba[0], aba[1]
    "#{b}#{a}#{b}"
  end
end

ips = File.read('input.txt').lines.map do |line|
  IPv7.new line
end

tls_count = ips.count {|ip| ip.supports_tls?}
puts "Part 1: #{tls_count}"

ssl_count = ips.count {|ip| ip.supports_ssl?}
puts "Part 2: #{ssl_count}"
