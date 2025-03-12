puts "Digite seu nome:"
nome = gets
puts "O seu nome é: " + nome

puts "========================="

=begin
caso queira um código mais limpo, usar gets.chomp. para visualizar o que tem na váriavel mais detalhadamente

puts "com o inspecto >>" + nome.inspect
=end

puts "Digite seu salário: "
sal = gets.chomp.to_f # .to_f converterá para floter

puts "Seu salário atualizado é: " + (sal * 1.10).to_s # usamos .to_s para converter para strig, observe que estamos concatenando com uma string
