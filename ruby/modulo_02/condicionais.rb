# estrutura condicional ternaria
sexo = 'F'

puts (sexo == 'M' ? 'Masculino' : 'Femino')


#case
print 'Digite uma idade: '
idade = gets.chomp.to_i

case idade
when 0..2
    puts "Bebê"
when 3..12
    puts "Criança"
when 13..18
    puts "Adolescente"
else
    puts "Adulto"
end


# if
print 'Digite um número: '
x = gets.chomp.to_i
if x > 50
    puts 'x é maior que 50'
else x < 50
    puts 'x é menor que 50'
end

# unless/a menos que... = usado pegar primeiro o falso
print 'Digite um número para verificação: '
x = gets.chomp.to_i

unless x >= 50
    puts 'não é maior ou igual a 50 '
else x < 50
    puts 'x é menor que 50'
end