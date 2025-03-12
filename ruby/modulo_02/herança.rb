class Pessoa
    attr_accessor :nome, :email
end

class PessoaFisica < Pessoa
    attr_accessor :cpf
    
    def falar(texto)
        texto
    end
end

class PessoaJuridica < Pessoa
     attr_accessor :cnpj

     def pagar_fornecedor
        puts "Pagando fornecedor..."
     end
end

p1 = Pessoa.new
# setter
p1.nome = "Daiana"
p1.email = "daiana@teste.com"
# getter
puts p1.nome
puts p1.email

# ----------------------------

p2 = PessoaFisica.new
# setter
p2.nome = "Patric"
p2.email = "pat@teste.com"
p2.cpf = "234234242"

# getter
puts p2.nome
puts p2.email
puts p2.cpf

puts p2.falar("hello!")

# ------------------------------

p2 = PessoaJuridica.new
# setter
p2.nome = "Patric"
p2.email = "pat@teste.com"
p2.cnpj = "234234456-242"

# getter
puts p2.nome
puts p2.email
puts p2.cnpj

p2.pagar_fornecedor

